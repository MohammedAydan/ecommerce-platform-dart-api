import 'dart:convert';

import 'package:ecommerce_platform_api/ecommerce_platform_api.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:test/test.dart';

void main() {
  test('requires HTTPS base URLs by default', () {
    expect(
      () => EcommerceApiClient(baseUrl: 'http://api.example.test'),
      throwsA(isA<ArgumentError>()),
    );
    expect(
      () => EcommercePlatformClient(baseUrl: 'https://user:pass@api.example.test'),
      throwsA(isA<ArgumentError>()),
    );
  });

  test('allows explicitly configured insecure HTTP for local development', () {
    final transport = EcommerceApiClient(
      baseUrl: 'http://127.0.0.1:3000/',
      allowInsecureHttp: true,
    );
    expect(transport.baseUrl, 'http://127.0.0.1:3000');
    transport.close();
  });

  test('adds bearer and idempotency headers and parses success envelope',
      () async {
    late http.Request captured;
    final httpClient = MockClient((request) async {
      captured = request;
      return http.Response(
        jsonEncode({
          'success': true,
          'data': {'id': 'order-1'},
          'pagination': {'page': 1, 'limit': 10, 'total': 1, 'totalPages': 1},
        }),
        200,
        headers: {'content-type': 'application/json'},
      );
    });

    final client = EcommercePlatformClient(
      baseUrl: 'https://api.example.test',
      authTokenProvider: const StaticAuthTokenProvider('token-123'),
    );
    final transport = EcommerceApiClient(
      baseUrl: 'https://api.example.test',
      httpClient: httpClient,
      authTokenProvider: const StaticAuthTokenProvider('token-123'),
    );
    final response = await transport.request<dynamic>(
      'POST',
      '/api/v1/orders',
      body: const JsonBody({'items': []}),
      idempotencyKey: 'idem-1',
    );

    expect(response.success, isTrue);
    expect(response.data, {'id': 'order-1'});
    expect(response.pagination?.total, 1);
    expect(captured.headers['authorization'], 'Bearer token-123');
    expect(captured.headers['idempotency-key'], 'idem-1');
    expect(captured.headers['content-type'], 'application/json');
    expect(jsonDecode(captured.body), {'items': []});
    client.close();
    transport.close();
  });

  test('throws ApiException for standard backend errors', () async {
    final transport = EcommerceApiClient(
      baseUrl: 'https://api.example.test',
      httpClient: MockClient((_) async => http.Response(
            jsonEncode({
              'success': false,
              'error': {
                'code': 'PRODUCT_NOT_FOUND',
                'message': 'Product not found',
              },
            }),
            404,
            headers: {'content-type': 'application/json'},
          )),
    );

    expect(
      () => transport.request<dynamic>('GET', '/api/v1/products/missing',
          authenticated: false),
      throwsA(isA<ApiException>()
          .having((e) => e.code, 'code', 'PRODUCT_NOT_FOUND')),
    );
    transport.close();
  });

  test('generated endpoint builds path parameters correctly', () async {
    late Uri capturedUri;
    final transport = EcommerceApiClient(
      baseUrl: 'https://api.example.test',
      httpClient: MockClient((request) async {
        capturedUri = request.url;
        return http.Response(
          jsonEncode({
            'success': true,
            'data': {'id': 'p-1'}
          }),
          200,
          headers: {'content-type': 'application/json'},
        );
      }),
    );
    final api = EcommercePlatformApi(transport);

    final response = await api.getApiV1ProductsId(
      id: 'p-1',
      authenticated: false,
      query: {'locale': 'en'},
    );

    expect(response.success, isTrue);
    expect(capturedUri.path, '/api/v1/products/p-1');
    expect(capturedUri.queryParameters['locale'], 'en');
    transport.close();
  });

  test('typed models serialize exact backend field names', () {
    final input = OrderInput(
      items: [const CartItemInput(productId: 'p-1', quantity: 2)],
      shippingAddress: const ShippingAddressInput(
        fullName: 'Customer',
        phone: '+201000000000',
        addressLine1: 'Street 1',
        city: 'Cairo',
        country: 'EG',
      ),
      paymentMethod: 'cod',
    );

    expect(input.toJson(), {
      'items': [
        {'productId': 'p-1', 'quantity': 2},
      ],
      'shippingAddress': {
        'fullName': 'Customer',
        'phone': '+201000000000',
        'addressLine1': 'Street 1',
        'city': 'Cairo',
        'country': 'EG',
      },
      'paymentMethod': 'cod',
    });
  });

  test('validates checkout requests before sending them', () async {
    var requests = 0;
    final transport = EcommerceApiClient(
      baseUrl: 'https://api.example.test',
      httpClient: MockClient((_) async {
        requests++;
        return http.Response('{}', 200);
      }),
    );

    expect(
      () => transport.request<dynamic>(
        'POST',
        '/api/v1/checkout/quote',
        body: const CheckoutQuoteRequest(items: []),
      ),
      throwsA(isA<ModelValidationException>()),
    );
    expect(requests, 0);
    transport.close();
  });

  test('persists Better Auth set-cookie and sends it on the next request',
      () async {
    final cookieStore = MemoryCookieStore();
    var call = 0;
    final transport = EcommerceApiClient(
      baseUrl: 'https://api.example.test',
      cookieStore: cookieStore,
      httpClient: MockClient((request) async {
        call++;
        if (call == 1) {
          return http.Response(
            jsonEncode({'success': true, 'data': {}}),
            200,
            headers: {
              'content-type': 'application/json',
              'set-cookie': 'better-auth.session_token=abc123; Path=/; HttpOnly'
            },
          );
        }
        expect(request.headers['cookie'], 'better-auth.session_token=abc123');
        return http.Response(jsonEncode({'success': true, 'data': {}}), 200,
            headers: {'content-type': 'application/json'});
      }),
    );

    await transport.request<dynamic>('POST', '/api/auth/sign-in/email',
        body: const JsonBody({'email': 'a@b.com', 'password': 'password'}));
    await transport.request<dynamic>('GET', '/api/auth/get-session');
    expect(call, 2);
    transport.close();
  });

  test('typed public client decodes catalog products', () async {
    final transport = EcommerceApiClient(
      baseUrl: 'https://api.example.test',
      httpClient: MockClient((request) async {
        expect(request.url.path, '/api/v1/products');
        expect(request.url.queryParameters['page'], '1');
        return http.Response(
            jsonEncode({
              'success': true,
              'data': [
                {
                  'id': 'p-1',
                  'name': 'Mouse',
                  'slug': 'mouse',
                  'price': 10,
                  'images': [],
                  'tags': [],
                  'variants': []
                }
              ]
            }),
            200,
            headers: {'content-type': 'application/json'});
      }),
    );
    final client = PublicApiClient(transport);
    final response = await client.listProducts(
        query: const CatalogQuery(page: 1, limit: 10));
    expect(response.data?.single.id, 'p-1');
    expect(response.data?.single.name, 'Mouse');
    transport.close();
  });

  test('public payment methods decode the country response object', () async {
    final transport = EcommerceApiClient(
      baseUrl: 'https://api.example.test',
      httpClient: MockClient((request) async {
        expect(request.url.path, '/api/v1/shipping/countries/EG/payment-methods');
        return http.Response(
          jsonEncode({
            'success': true,
            'data': {
              'country': 'EG',
              'methods': [
                {'type': 'PAYMOB', 'name': 'Card'},
                {'type': 'COD', 'name': 'Cash on delivery'},
              ],
            },
          }),
          200,
          headers: {'content-type': 'application/json'},
        );
      }),
    );
    final response = await PublicApiClient(transport).paymentMethods(countryCode: 'EG');
    expect(response.data?['country'], 'EG');
    expect((response.data?['methods'] as List).length, 2);
    transport.close();
  });

  test('auth facade uses Better Auth email endpoint and typed body', () async {
    late http.Request captured;
    final transport = EcommerceApiClient(
      baseUrl: 'https://api.example.test',
      httpClient: MockClient((request) async {
        captured = request;
        return http.Response(
            jsonEncode({
              'user': {'id': 'u-1', 'email': 'a@b.com'}
            }),
            200,
            headers: {'content-type': 'application/json'});
      }),
    );
    final response = await AuthApiClient(transport)
        .signIn(const SignInRequest(email: 'a@b.com', password: 'password'));
    expect(response.success, isTrue);
    expect(captured.url.path, '/api/auth/sign-in/email');
    expect(jsonDecode(captured.body),
        {'email': 'a@b.com', 'password': 'password'});
    transport.close();
  });

  test('typed cart client sends guest cart id on GET', () async {
    late http.Request captured;
    final transport = EcommerceApiClient(
      baseUrl: 'https://api.example.test',
      httpClient: MockClient((request) async {
        captured = request;
        return http.Response(
          jsonEncode({'success': true, 'data': {'id': 'guest-1', 'items': []}}),
          200,
          headers: {'content-type': 'application/json'},
        );
      }),
    );

    final response = await CartApiClient(transport).get(cartId: 'guest-1');
    expect(response.data?.id, 'guest-1');
    expect(captured.headers['x-cart-id'], 'guest-1');
    transport.close();
  });

  test('manifest and agent tool catalogs are complete and safe by default', () {
    expect(ecommercePlatformOperations.length, 135);
    expect(EcommerceAgentTools.safe.length, 9);
    expect(EcommerceAgentTools.safe.every((tool) => tool.readOnly), isTrue);
    expect(
        EcommerceAgentTools.safe
            .every((tool) => tool.inputSchema['additionalProperties'] == false),
        isTrue);
  });
}
