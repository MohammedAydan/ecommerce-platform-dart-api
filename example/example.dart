import 'package:ecommerce_platform_api/ecommerce_platform_api.dart';

Future<void> main() async {
  final client = EcommercePlatformClient(
    baseUrl: 'https://your-domain.example',
    authTokenProvider: const StaticAuthTokenProvider('replace-with-token'),
  );

  try {
    final products = await client.api.getApiV1Products(
      authenticated: false,
      query: {'locale': 'en', 'page': 1, 'limit': 20},
    );
    print('Product response: ${products.raw}');

    final createdOrder = await client.api.postApiV1Orders(
      body: OrderInput(
        items: [CartItemInput(productId: 'product-id', quantity: 1)],
        shippingAddress: ShippingAddressInput(
          fullName: 'Customer Name',
          phone: '+201000000000',
          addressLine1: 'Street 1',
          city: 'Cairo',
          country: 'EG',
        ),
        paymentMethod: 'cod',
      ),
      idempotencyKey: 'demo-order-request-001',
    );
    print('Order response: ${createdOrder.raw}');
  } on ApiException catch (error) {
    print('Backend error ${error.statusCode}: ${error.code} ${error.message}');
  } on NetworkApiException catch (error) {
    print('Network error: ${error.message}');
  } finally {
    client.close();
  }
}
