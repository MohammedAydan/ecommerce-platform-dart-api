import 'package:ecommerce_platform_api/ecommerce_platform_api.dart';

Future<void> main() async {
  final client = EcommercePlatformClient(
    baseUrl: 'https://ec-swart.vercel.app',
    cookieStore: MemoryCookieStore(),
  );

  try {
    final products = await client.publicApi.listProducts(
      query: const CatalogQuery(
        locale: AppLocale.en,
        search: 'wireless mouse',
        inStockOnly: true,
        page: 1,
        limit: 10,
      ),
    );
    print('Products: ${products.data?.length ?? 0}');

    final quote = await client.checkout.quote(
      const CheckoutQuoteRequest(
        items: [CartItemInput(productId: 'product-id', quantity: 1)],
      ),
    );
    print('Quote: ${quote.data?.total} ${quote.data?.currency}');

    print('Safe agent tools: ${EcommerceAgentTools.toJson().length}');
  } on ModelValidationException catch (error) {
    print('Local validation failed: $error');
  } on ApiException catch (error) {
    print('Backend error ${error.statusCode}: ${error.code} ${error.message}');
  } on NetworkApiException catch (error) {
    print('Network error: ${error.message}');
  } finally {
    client.close();
  }
}
