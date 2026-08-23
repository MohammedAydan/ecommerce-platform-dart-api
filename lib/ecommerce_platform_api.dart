library ecommerce_platform_api;

export 'src/api_client.dart'
    show AppKeyProvider, ApiClientKind, EcommerceApiClient;
export 'src/generated_api.dart' show EcommercePlatformApi;
export 'src/models.dart';
export 'src/admin_models.dart';
export 'src/typed_clients.dart';
export 'src/agent_tools.dart';
export 'src/operation_manifest.dart';
export 'src/types.dart';

import 'src/api_client.dart';
import 'src/generated_api.dart';
import 'src/typed_clients.dart';
import 'src/types.dart';

/// Main facade for the Ecommerce Platform backend client.
///
/// Every route operation is available through [api]. The transport is kept
/// public so applications can customize headers, cookies, token providers,
/// retries, and the underlying `package:http` client.
class EcommercePlatformClient {
  EcommercePlatformClient({
    required String baseUrl,
    required AppKeyProvider appKeyProvider,
    ApiClientKind appClientKind = ApiClientKind.mobile,
    AuthTokenProvider? authTokenProvider,
    Map<String, String>? defaultHeaders,
    String? cookie,
    CookieStore? cookieStore,
    bool throwOnApiError = true,
    Duration requestTimeout = const Duration(seconds: 30),
    int maxRetries = 2,
    Duration retryDelay = const Duration(milliseconds: 250),
    bool retryUnsafeRequests = false,
    bool allowInsecureHttp = false,
  }) : transport = EcommerceApiClient(
          baseUrl: baseUrl,
          appKeyProvider: appKeyProvider,
          appClientKind: appClientKind,
          authTokenProvider: authTokenProvider,
          defaultHeaders: defaultHeaders,
          cookie: cookie,
          cookieStore: cookieStore,
          throwOnApiError: throwOnApiError,
          requestTimeout: requestTimeout,
          maxRetries: maxRetries,
          retryDelay: retryDelay,
          retryUnsafeRequests: retryUnsafeRequests,
          allowInsecureHttp: allowInsecureHttp,
        ) {
    api = EcommercePlatformApi(transport);
    auth = AuthApiClient(transport);
    publicApi = PublicApiClient(transport);
    checkout = CheckoutApiClient(transport);
    cart = CartApiClient(transport);
    account = AccountApiClient(transport);
    addresses = AddressesApiClient(transport);
    orders = OrdersApiClient(transport);
    admin = AdminApiClient(transport);
  }

  final EcommerceApiClient transport;
  late final EcommercePlatformApi api;
  late final AuthApiClient auth;
  late final PublicApiClient publicApi;
  late final CheckoutApiClient checkout;
  late final CartApiClient cart;
  late final AccountApiClient account;
  late final AddressesApiClient addresses;
  late final OrdersApiClient orders;
  late final AdminApiClient admin;

  Future<ApiResponse<dynamic>> uploadMedia({
    required List<MultipartPart> files,
    String? folder,
    Map<String, String>? headers,
  }) {
    return transport.upload<dynamic>(
      '/api/v1/media/upload',
      files: files,
      fields: {if (folder != null) 'folder': folder},
      headers: headers,
    );
  }

  void close() => transport.close();
}
