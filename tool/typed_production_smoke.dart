import 'package:ecommerce_platform_api/ecommerce_platform_api.dart';

Future<void> main() async {
  final client = EcommercePlatformClient(
    baseUrl: 'https://ec-swart.vercel.app',
    cookieStore: MemoryCookieStore(),
    throwOnApiError: false,
  );
  var failures = 0;

  Future<void> check(String name, Future<ApiResponse<dynamic>> Function() run,
      {Set<int> allowed = const {200}}) async {
    try {
      final response = await run();
      final status = response.statusCode ?? 0;
      final pass = allowed.contains(status) &&
          (status == 401 ||
              response.success ||
              response.raw['status'] == 'ok' ||
              response.raw['status'] == 'ready');
      print('${pass ? 'PASS' : 'FAIL'} $name: $status');
      if (!pass) failures++;
    } catch (error) {
      failures++;
      print('FAIL $name: $error');
    }
  }

  try {
    await check(
        'typed products',
        () => client.publicApi.listProducts(
            query:
                const CatalogQuery(locale: AppLocale.en, page: 1, limit: 10)));
    await check('typed categories',
        () => client.publicApi.listCategories(locale: AppLocale.en));
    await check('typed brands',
        () => client.publicApi.listBrands(locale: AppLocale.en));
    await check('typed shipping countries', client.publicApi.shippingCountries);
    await check('typed EG governorates',
        () => client.publicApi.shippingGovernorates(country: 'EG'));
    await check('typed EG payment methods',
        () => client.publicApi.paymentMethods(countryCode: 'EG'));
    await check('typed commerce country', client.publicApi.commerceCountry);
    await check('typed guest cart', client.cart.get);
    await check('typed account guard', client.account.profile, allowed: {401});

    final products = await client.publicApi
        .listProducts(query: const CatalogQuery(page: 1, limit: 1));
    final productId = products.data?.firstOrNull?.id;
    if (productId == null) {
      failures++;
      print('FAIL typed product lookup: no product id');
    } else {
      await check('typed product reviews',
          () => client.publicApi.productReviews(productId));
      await check(
          'typed checkout quote',
          () => client.checkout.quote(CheckoutQuoteRequest(
              items: [CartItemInput(productId: productId, quantity: 1)])));
    }
  } finally {
    client.close();
  }

  if (failures > 0)
    throw StateError('$failures typed production checks failed');
}

extension<T> on List<T> {
  T? get firstOrNull => isEmpty ? null : first;
}
