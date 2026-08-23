import 'package:ecommerce_platform_api/ecommerce_platform_api.dart';

class SmokeCheck {
  const SmokeCheck(this.name, this.run, {this.allowedStatuses = const {200}});

  final String name;
  final Future<ApiResponse<dynamic>> Function() run;
  final Set<int> allowedStatuses;
}

Future<void> main() async {
  final client = EcommercePlatformClient(
    baseUrl: 'https://ec-swart.vercel.app',
    throwOnApiError: false,
  );

  final checks = <SmokeCheck>[
    SmokeCheck('health', () => client.api.getApiHealth(authenticated: false)),
    SmokeCheck(
        'readiness', () => client.api.getApiHealthReady(authenticated: false)),
    SmokeCheck(
      'products',
      () => client.api.getApiV1Products(
        authenticated: false,
        query: {'locale': 'en', 'page': 1, 'limit': 10},
      ),
    ),
    SmokeCheck(
      'categories',
      () => client.api.getApiV1Categories(
        authenticated: false,
        query: {'locale': 'en'},
      ),
    ),
    SmokeCheck(
      'brands',
      () => client.api.getApiV1Brands(
        authenticated: false,
        query: {'locale': 'en'},
      ),
    ),
    SmokeCheck(
      'hero',
      () => client.api.getApiV1Hero(
        authenticated: false,
        query: {'locale': 'en'},
      ),
    ),
    SmokeCheck('shipping countries',
        () => client.api.getApiV1ShippingCountries(authenticated: false)),
    SmokeCheck(
      'shipping governorates',
      () => client.api.getApiV1ShippingGovernorates(
        authenticated: false,
        query: {'country': 'EG'},
      ),
    ),
    SmokeCheck(
      'shipping regions',
      () => client.api.getApiV1ShippingRegions(
        authenticated: false,
        query: {'country': 'EG'},
      ),
    ),
    SmokeCheck('commerce country',
        () => client.api.getApiV1CommerceCountry(authenticated: false)),
    SmokeCheck(
      'payment methods EG',
      () => client.api.getApiV1ShippingCountriesCodePaymentMethods(
        code: 'EG',
        authenticated: false,
      ),
    ),
    SmokeCheck(
      'guest cart',
      () => client.api.getApiV1Cart(authenticated: false),
    ),
    SmokeCheck(
      'account profile without auth',
      () => client.api.getApiV1AccountProfile(authenticated: false),
      allowedStatuses: {401},
    ),
    SmokeCheck(
      'orders without auth',
      () => client.api.getApiV1Orders(authenticated: false),
      allowedStatuses: {401},
    ),
    SmokeCheck(
      'admin dashboard without auth',
      () => client.api.getApiV1AdminDashboard(authenticated: false),
      allowedStatuses: {401},
    ),
    SmokeCheck(
      'admin products without auth',
      () => client.api.getApiV1AdminProducts(authenticated: false),
      allowedStatuses: {401},
    ),
  ];

  var failures = 0;
  try {
    for (final check in checks) {
      try {
        final response = await check.run();
        final status = response.statusCode ?? 0;
        final passed = check.allowedStatuses.contains(status) &&
            (status == 401 ||
                response.success ||
                response.raw['status'] == 'ok' ||
                response.raw['status'] == 'ready');
        print('${passed ? 'PASS' : 'FAIL'} ${check.name}: $status');
        if (!passed) failures++;
      } on ApiException catch (error) {
        failures++;
        print(
            'FAIL ${check.name}: ${error.statusCode} ${error.code} ${error.message}');
      } on NetworkApiException catch (error) {
        failures++;
        print('FAIL ${check.name}: ${error.message}');
      }
    }

    final productsResponse = await client.api.getApiV1Products(
      authenticated: false,
      query: {'locale': 'en', 'page': 1, 'limit': 1},
    );
    final products = productsResponse.data is List
        ? productsResponse.data as List
        : const [];
    if (products.isNotEmpty && products.first is Map) {
      final productId = '${(products.first as Map)['id']}';
      final reviewResponse = await client.api.getApiV1ProductsIdReviews(
        id: productId,
        authenticated: false,
        query: {'page': 1, 'limit': 10},
      );
      print(
          '${reviewResponse.success ? 'PASS' : 'FAIL'} product reviews: ${reviewResponse.statusCode}');
      if (!reviewResponse.success) failures++;

      final quoteResponse = await client.api.postApiV1CheckoutQuote(
        authenticated: false,
        body: const CheckoutQuoteInput(
          items: [CartItemInput(productId: 'placeholder', quantity: 1)],
        ),
      );
      final quoteStatus = quoteResponse.statusCode ?? 0;
      final quoteExpected = quoteStatus == 200 || quoteStatus == 400;
      print(
          '${quoteExpected ? 'PASS' : 'FAIL'} checkout quote validation: $quoteStatus');
      if (!quoteExpected) failures++;

      final realQuoteResponse = await client.api.postApiV1CheckoutQuote(
        authenticated: false,
        body: CheckoutQuoteInput(
          items: [CartItemInput(productId: productId, quantity: 1)],
          shippingAddress: const ShippingAddressInput(
            fullName: 'Smoke Test',
            phone: '+201000000000',
            addressLine1: 'Read-only smoke test address',
            city: 'Cairo',
            country: 'EG',
          ),
        ),
      );
      final realQuoteStatus = realQuoteResponse.statusCode ?? 0;
      print(
          '${realQuoteStatus == 200 ? 'PASS' : 'FAIL'} checkout quote real product: $realQuoteStatus');
      if (realQuoteStatus != 200) failures++;
    } else {
      failures++;
      print('FAIL dynamic product lookup: no product returned');
    }
  } finally {
    client.close();
  }

  if (failures > 0) {
    throw StateError('$failures production checks failed');
  }
}
