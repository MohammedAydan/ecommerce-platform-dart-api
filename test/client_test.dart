import 'dart:convert';

import 'package:ecommerce_platform_api/ecommerce_platform_api.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:test/test.dart';

void main() {
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
}
