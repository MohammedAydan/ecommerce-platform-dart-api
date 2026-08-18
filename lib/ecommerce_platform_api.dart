library ecommerce_platform_api;

export 'src/api_client.dart' show EcommerceApiClient;
export 'src/generated_api.dart' show EcommercePlatformApi;
export 'src/models.dart';
export 'src/operation_manifest.dart';
export 'src/types.dart';

import 'src/api_client.dart';
import 'src/generated_api.dart';
import 'src/types.dart';

/// Main facade for the Ecommerce Platform backend client.
///
/// Every route operation is available through [api]. The transport is kept
/// public so applications can customize headers, cookies, token providers,
/// retries, and the underlying `package:http` client.
class EcommercePlatformClient {
  EcommercePlatformClient({
    required String baseUrl,
    AuthTokenProvider? authTokenProvider,
    Map<String, String>? defaultHeaders,
    String? cookie,
    bool throwOnApiError = true,
  }) : transport = EcommerceApiClient(
          baseUrl: baseUrl,
          authTokenProvider: authTokenProvider,
          defaultHeaders: defaultHeaders,
          cookie: cookie,
          throwOnApiError: throwOnApiError,
        ) {
    api = EcommercePlatformApi(transport);
  }

  final EcommerceApiClient transport;
  late final EcommercePlatformApi api;

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
