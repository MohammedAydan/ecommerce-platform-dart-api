// GENERATED FILE. Source: api_route_inventory.json at the backend commit documented in API_REFERENCE.md.
import 'api_client.dart';
import 'types.dart';
import 'models.dart';

class EcommercePlatformApi {
  EcommercePlatformApi(this.client);

  final EcommerceApiClient client;

  /// GET /api/auth/{...auth}
  Future<ApiResponse<dynamic>> getApiAuthCatchAll({
    String catchAll = '',
    Map<String, dynamic>? query,
    dynamic body,
    Map<String, String>? headers,
    bool authenticated = true,
    String? idempotencyKey,
  }) =>
      client.request<dynamic>(
        'GET',
        '/api/auth/${catchAll}',
        query: query,
        body: body is JsonModel ? body.toJson() : body,
        headers: headers,
        authenticated: authenticated,
        idempotencyKey: idempotencyKey,
      );

  /// POST /api/auth/{...auth}
  Future<ApiResponse<dynamic>> postApiAuthCatchAll({
    String catchAll = '',
    Map<String, dynamic>? query,
    dynamic body,
    Map<String, String>? headers,
    bool authenticated = true,
    String? idempotencyKey,
  }) =>
      client.request<dynamic>(
        'POST',
        '/api/auth/${catchAll}',
        query: query,
        body: body is JsonModel ? body.toJson() : body,
        headers: headers,
        authenticated: authenticated,
        idempotencyKey: idempotencyKey,
      );

  /// GET /api/health/ready
  Future<ApiResponse<dynamic>> getApiHealthReady({
    Map<String, dynamic>? query,
    dynamic body,
    Map<String, String>? headers,
    bool authenticated = true,
    String? idempotencyKey,
  }) =>
      client.request<dynamic>(
        'GET',
        '/api/health/ready',
        query: query,
        body: body is JsonModel ? body.toJson() : body,
        headers: headers,
        authenticated: authenticated,
        idempotencyKey: idempotencyKey,
      );

  /// GET /api/health
  Future<ApiResponse<dynamic>> getApiHealth({
    Map<String, dynamic>? query,
    dynamic body,
    Map<String, String>? headers,
    bool authenticated = true,
    String? idempotencyKey,
  }) =>
      client.request<dynamic>(
        'GET',
        '/api/health',
        query: query,
        body: body is JsonModel ? body.toJson() : body,
        headers: headers,
        authenticated: authenticated,
        idempotencyKey: idempotencyKey,
      );

  /// POST /api/v1/account/orders/{id}/cancel
  Future<ApiResponse<dynamic>> postApiV1AccountOrdersIdCancel({
    required String id,
    Map<String, dynamic>? query,
    dynamic body,
    Map<String, String>? headers,
    bool authenticated = true,
    String? idempotencyKey,
  }) =>
      client.request<dynamic>(
        'POST',
        '/api/v1/account/orders/${id}/cancel',
        query: query,
        body: body is JsonModel ? body.toJson() : body,
        headers: headers,
        authenticated: authenticated,
        idempotencyKey: idempotencyKey,
      );

  /// GET /api/v1/account/orders/{id}
  Future<ApiResponse<dynamic>> getApiV1AccountOrdersId({
    required String id,
    Map<String, dynamic>? query,
    dynamic body,
    Map<String, String>? headers,
    bool authenticated = true,
    String? idempotencyKey,
  }) =>
      client.request<dynamic>(
        'GET',
        '/api/v1/account/orders/${id}',
        query: query,
        body: body is JsonModel ? body.toJson() : body,
        headers: headers,
        authenticated: authenticated,
        idempotencyKey: idempotencyKey,
      );

  /// POST /api/v1/account/orders/{id}
  Future<ApiResponse<dynamic>> postApiV1AccountOrdersId({
    required String id,
    Map<String, dynamic>? query,
    dynamic body,
    Map<String, String>? headers,
    bool authenticated = true,
    String? idempotencyKey,
  }) =>
      client.request<dynamic>(
        'POST',
        '/api/v1/account/orders/${id}',
        query: query,
        body: body is JsonModel ? body.toJson() : body,
        headers: headers,
        authenticated: authenticated,
        idempotencyKey: idempotencyKey,
      );

  /// GET /api/v1/account/profile
  Future<ApiResponse<dynamic>> getApiV1AccountProfile({
    Map<String, dynamic>? query,
    dynamic body,
    Map<String, String>? headers,
    bool authenticated = true,
    String? idempotencyKey,
  }) =>
      client.request<dynamic>(
        'GET',
        '/api/v1/account/profile',
        query: query,
        body: body is JsonModel ? body.toJson() : body,
        headers: headers,
        authenticated: authenticated,
        idempotencyKey: idempotencyKey,
      );

  /// PATCH /api/v1/account/profile
  Future<ApiResponse<dynamic>> patchApiV1AccountProfile({
    Map<String, dynamic>? query,
    dynamic body,
    Map<String, String>? headers,
    bool authenticated = true,
    String? idempotencyKey,
  }) =>
      client.request<dynamic>(
        'PATCH',
        '/api/v1/account/profile',
        query: query,
        body: body is JsonModel ? body.toJson() : body,
        headers: headers,
        authenticated: authenticated,
        idempotencyKey: idempotencyKey,
      );

  /// GET /api/v1/account/reviews/{id}
  Future<ApiResponse<dynamic>> getApiV1AccountReviewsId({
    required String id,
    Map<String, dynamic>? query,
    dynamic body,
    Map<String, String>? headers,
    bool authenticated = true,
    String? idempotencyKey,
  }) =>
      client.request<dynamic>(
        'GET',
        '/api/v1/account/reviews/${id}',
        query: query,
        body: body is JsonModel ? body.toJson() : body,
        headers: headers,
        authenticated: authenticated,
        idempotencyKey: idempotencyKey,
      );

  /// DELETE /api/v1/account/reviews/{id}
  Future<ApiResponse<dynamic>> deleteApiV1AccountReviewsId({
    required String id,
    Map<String, dynamic>? query,
    dynamic body,
    Map<String, String>? headers,
    bool authenticated = true,
    String? idempotencyKey,
  }) =>
      client.request<dynamic>(
        'DELETE',
        '/api/v1/account/reviews/${id}',
        query: query,
        body: body is JsonModel ? body.toJson() : body,
        headers: headers,
        authenticated: authenticated,
        idempotencyKey: idempotencyKey,
      );

  /// GET /api/v1/account/reviews
  Future<ApiResponse<dynamic>> getApiV1AccountReviews({
    Map<String, dynamic>? query,
    dynamic body,
    Map<String, String>? headers,
    bool authenticated = true,
    String? idempotencyKey,
  }) =>
      client.request<dynamic>(
        'GET',
        '/api/v1/account/reviews',
        query: query,
        body: body is JsonModel ? body.toJson() : body,
        headers: headers,
        authenticated: authenticated,
        idempotencyKey: idempotencyKey,
      );

  /// POST /api/v1/account/reviews
  Future<ApiResponse<dynamic>> postApiV1AccountReviews({
    Map<String, dynamic>? query,
    dynamic body,
    Map<String, String>? headers,
    bool authenticated = true,
    String? idempotencyKey,
  }) =>
      client.request<dynamic>(
        'POST',
        '/api/v1/account/reviews',
        query: query,
        body: body is JsonModel ? body.toJson() : body,
        headers: headers,
        authenticated: authenticated,
        idempotencyKey: idempotencyKey,
      );

  /// POST /api/v1/account/security
  Future<ApiResponse<dynamic>> postApiV1AccountSecurity({
    Map<String, dynamic>? query,
    dynamic body,
    Map<String, String>? headers,
    bool authenticated = true,
    String? idempotencyKey,
  }) =>
      client.request<dynamic>(
        'POST',
        '/api/v1/account/security',
        query: query,
        body: body is JsonModel ? body.toJson() : body,
        headers: headers,
        authenticated: authenticated,
        idempotencyKey: idempotencyKey,
      );

  /// GET /api/v1/account/sessions
  Future<ApiResponse<dynamic>> getApiV1AccountSessions({
    Map<String, dynamic>? query,
    dynamic body,
    Map<String, String>? headers,
    bool authenticated = true,
    String? idempotencyKey,
  }) =>
      client.request<dynamic>(
        'GET',
        '/api/v1/account/sessions',
        query: query,
        body: body is JsonModel ? body.toJson() : body,
        headers: headers,
        authenticated: authenticated,
        idempotencyKey: idempotencyKey,
      );

  /// DELETE /api/v1/account/sessions
  Future<ApiResponse<dynamic>> deleteApiV1AccountSessions({
    Map<String, dynamic>? query,
    dynamic body,
    Map<String, String>? headers,
    bool authenticated = true,
    String? idempotencyKey,
  }) =>
      client.request<dynamic>(
        'DELETE',
        '/api/v1/account/sessions',
        query: query,
        body: body is JsonModel ? body.toJson() : body,
        headers: headers,
        authenticated: authenticated,
        idempotencyKey: idempotencyKey,
      );

  /// GET /api/v1/account/settings
  Future<ApiResponse<dynamic>> getApiV1AccountSettings({
    Map<String, dynamic>? query,
    dynamic body,
    Map<String, String>? headers,
    bool authenticated = true,
    String? idempotencyKey,
  }) =>
      client.request<dynamic>(
        'GET',
        '/api/v1/account/settings',
        query: query,
        body: body is JsonModel ? body.toJson() : body,
        headers: headers,
        authenticated: authenticated,
        idempotencyKey: idempotencyKey,
      );

  /// PATCH /api/v1/account/settings
  Future<ApiResponse<dynamic>> patchApiV1AccountSettings({
    Map<String, dynamic>? query,
    dynamic body,
    Map<String, String>? headers,
    bool authenticated = true,
    String? idempotencyKey,
  }) =>
      client.request<dynamic>(
        'PATCH',
        '/api/v1/account/settings',
        query: query,
        body: body is JsonModel ? body.toJson() : body,
        headers: headers,
        authenticated: authenticated,
        idempotencyKey: idempotencyKey,
      );

  /// PUT /api/v1/addresses/{id}/default
  Future<ApiResponse<dynamic>> putApiV1AddressesIdDefault({
    required String id,
    Map<String, dynamic>? query,
    dynamic body,
    Map<String, String>? headers,
    bool authenticated = true,
    String? idempotencyKey,
  }) =>
      client.request<dynamic>(
        'PUT',
        '/api/v1/addresses/${id}/default',
        query: query,
        body: body is JsonModel ? body.toJson() : body,
        headers: headers,
        authenticated: authenticated,
        idempotencyKey: idempotencyKey,
      );

  /// PATCH /api/v1/addresses/{id}
  Future<ApiResponse<dynamic>> patchApiV1AddressesId({
    required String id,
    Map<String, dynamic>? query,
    dynamic body,
    Map<String, String>? headers,
    bool authenticated = true,
    String? idempotencyKey,
  }) =>
      client.request<dynamic>(
        'PATCH',
        '/api/v1/addresses/${id}',
        query: query,
        body: body is JsonModel ? body.toJson() : body,
        headers: headers,
        authenticated: authenticated,
        idempotencyKey: idempotencyKey,
      );

  /// DELETE /api/v1/addresses/{id}
  Future<ApiResponse<dynamic>> deleteApiV1AddressesId({
    required String id,
    Map<String, dynamic>? query,
    dynamic body,
    Map<String, String>? headers,
    bool authenticated = true,
    String? idempotencyKey,
  }) =>
      client.request<dynamic>(
        'DELETE',
        '/api/v1/addresses/${id}',
        query: query,
        body: body is JsonModel ? body.toJson() : body,
        headers: headers,
        authenticated: authenticated,
        idempotencyKey: idempotencyKey,
      );

  /// GET /api/v1/addresses
  Future<ApiResponse<dynamic>> getApiV1Addresses({
    Map<String, dynamic>? query,
    dynamic body,
    Map<String, String>? headers,
    bool authenticated = true,
    String? idempotencyKey,
  }) =>
      client.request<dynamic>(
        'GET',
        '/api/v1/addresses',
        query: query,
        body: body is JsonModel ? body.toJson() : body,
        headers: headers,
        authenticated: authenticated,
        idempotencyKey: idempotencyKey,
      );

  /// POST /api/v1/addresses
  Future<ApiResponse<dynamic>> postApiV1Addresses({
    Map<String, dynamic>? query,
    dynamic body,
    Map<String, String>? headers,
    bool authenticated = true,
    String? idempotencyKey,
  }) =>
      client.request<dynamic>(
        'POST',
        '/api/v1/addresses',
        query: query,
        body: body is JsonModel ? body.toJson() : body,
        headers: headers,
        authenticated: authenticated,
        idempotencyKey: idempotencyKey,
      );

  /// DELETE /api/v1/addresses
  Future<ApiResponse<dynamic>> deleteApiV1Addresses({
    Map<String, dynamic>? query,
    dynamic body,
    Map<String, String>? headers,
    bool authenticated = true,
    String? idempotencyKey,
  }) =>
      client.request<dynamic>(
        'DELETE',
        '/api/v1/addresses',
        query: query,
        body: body is JsonModel ? body.toJson() : body,
        headers: headers,
        authenticated: authenticated,
        idempotencyKey: idempotencyKey,
      );

  /// GET /api/v1/admin/audit-logs
  Future<ApiResponse<dynamic>> getApiV1AdminAuditLogs({
    Map<String, dynamic>? query,
    dynamic body,
    Map<String, String>? headers,
    bool authenticated = true,
    String? idempotencyKey,
  }) =>
      client.request<dynamic>(
        'GET',
        '/api/v1/admin/audit-logs',
        query: query,
        body: body is JsonModel ? body.toJson() : body,
        headers: headers,
        authenticated: authenticated,
        idempotencyKey: idempotencyKey,
      );

  /// PATCH /api/v1/admin/brands/{id}
  Future<ApiResponse<dynamic>> patchApiV1AdminBrandsId({
    required String id,
    Map<String, dynamic>? query,
    dynamic body,
    Map<String, String>? headers,
    bool authenticated = true,
    String? idempotencyKey,
  }) =>
      client.request<dynamic>(
        'PATCH',
        '/api/v1/admin/brands/${id}',
        query: query,
        body: body is JsonModel ? body.toJson() : body,
        headers: headers,
        authenticated: authenticated,
        idempotencyKey: idempotencyKey,
      );

  /// DELETE /api/v1/admin/brands/{id}
  Future<ApiResponse<dynamic>> deleteApiV1AdminBrandsId({
    required String id,
    Map<String, dynamic>? query,
    dynamic body,
    Map<String, String>? headers,
    bool authenticated = true,
    String? idempotencyKey,
  }) =>
      client.request<dynamic>(
        'DELETE',
        '/api/v1/admin/brands/${id}',
        query: query,
        body: body is JsonModel ? body.toJson() : body,
        headers: headers,
        authenticated: authenticated,
        idempotencyKey: idempotencyKey,
      );

  /// GET /api/v1/admin/brands
  Future<ApiResponse<dynamic>> getApiV1AdminBrands({
    Map<String, dynamic>? query,
    dynamic body,
    Map<String, String>? headers,
    bool authenticated = true,
    String? idempotencyKey,
  }) =>
      client.request<dynamic>(
        'GET',
        '/api/v1/admin/brands',
        query: query,
        body: body is JsonModel ? body.toJson() : body,
        headers: headers,
        authenticated: authenticated,
        idempotencyKey: idempotencyKey,
      );

  /// POST /api/v1/admin/brands
  Future<ApiResponse<dynamic>> postApiV1AdminBrands({
    Map<String, dynamic>? query,
    dynamic body,
    Map<String, String>? headers,
    bool authenticated = true,
    String? idempotencyKey,
  }) =>
      client.request<dynamic>(
        'POST',
        '/api/v1/admin/brands',
        query: query,
        body: body is JsonModel ? body.toJson() : body,
        headers: headers,
        authenticated: authenticated,
        idempotencyKey: idempotencyKey,
      );

  /// PATCH /api/v1/admin/categories/{id}
  Future<ApiResponse<dynamic>> patchApiV1AdminCategoriesId({
    required String id,
    Map<String, dynamic>? query,
    dynamic body,
    Map<String, String>? headers,
    bool authenticated = true,
    String? idempotencyKey,
  }) =>
      client.request<dynamic>(
        'PATCH',
        '/api/v1/admin/categories/${id}',
        query: query,
        body: body is JsonModel ? body.toJson() : body,
        headers: headers,
        authenticated: authenticated,
        idempotencyKey: idempotencyKey,
      );

  /// DELETE /api/v1/admin/categories/{id}
  Future<ApiResponse<dynamic>> deleteApiV1AdminCategoriesId({
    required String id,
    Map<String, dynamic>? query,
    dynamic body,
    Map<String, String>? headers,
    bool authenticated = true,
    String? idempotencyKey,
  }) =>
      client.request<dynamic>(
        'DELETE',
        '/api/v1/admin/categories/${id}',
        query: query,
        body: body is JsonModel ? body.toJson() : body,
        headers: headers,
        authenticated: authenticated,
        idempotencyKey: idempotencyKey,
      );

  /// GET /api/v1/admin/categories
  Future<ApiResponse<dynamic>> getApiV1AdminCategories({
    Map<String, dynamic>? query,
    dynamic body,
    Map<String, String>? headers,
    bool authenticated = true,
    String? idempotencyKey,
  }) =>
      client.request<dynamic>(
        'GET',
        '/api/v1/admin/categories',
        query: query,
        body: body is JsonModel ? body.toJson() : body,
        headers: headers,
        authenticated: authenticated,
        idempotencyKey: idempotencyKey,
      );

  /// POST /api/v1/admin/categories
  Future<ApiResponse<dynamic>> postApiV1AdminCategories({
    Map<String, dynamic>? query,
    dynamic body,
    Map<String, String>? headers,
    bool authenticated = true,
    String? idempotencyKey,
  }) =>
      client.request<dynamic>(
        'POST',
        '/api/v1/admin/categories',
        query: query,
        body: body is JsonModel ? body.toJson() : body,
        headers: headers,
        authenticated: authenticated,
        idempotencyKey: idempotencyKey,
      );

  /// PATCH /api/v1/admin/contact/{id}
  Future<ApiResponse<dynamic>> patchApiV1AdminContactId({
    required String id,
    Map<String, dynamic>? query,
    dynamic body,
    Map<String, String>? headers,
    bool authenticated = true,
    String? idempotencyKey,
  }) =>
      client.request<dynamic>(
        'PATCH',
        '/api/v1/admin/contact/${id}',
        query: query,
        body: body is JsonModel ? body.toJson() : body,
        headers: headers,
        authenticated: authenticated,
        idempotencyKey: idempotencyKey,
      );

  /// GET /api/v1/admin/contact
  Future<ApiResponse<dynamic>> getApiV1AdminContact({
    Map<String, dynamic>? query,
    dynamic body,
    Map<String, String>? headers,
    bool authenticated = true,
    String? idempotencyKey,
  }) =>
      client.request<dynamic>(
        'GET',
        '/api/v1/admin/contact',
        query: query,
        body: body is JsonModel ? body.toJson() : body,
        headers: headers,
        authenticated: authenticated,
        idempotencyKey: idempotencyKey,
      );

  /// POST /api/v1/admin/coupons/{id}/reset
  Future<ApiResponse<dynamic>> postApiV1AdminCouponsIdReset({
    required String id,
    Map<String, dynamic>? query,
    dynamic body,
    Map<String, String>? headers,
    bool authenticated = true,
    String? idempotencyKey,
  }) =>
      client.request<dynamic>(
        'POST',
        '/api/v1/admin/coupons/${id}/reset',
        query: query,
        body: body is JsonModel ? body.toJson() : body,
        headers: headers,
        authenticated: authenticated,
        idempotencyKey: idempotencyKey,
      );

  /// PATCH /api/v1/admin/coupons/{id}
  Future<ApiResponse<dynamic>> patchApiV1AdminCouponsId({
    required String id,
    Map<String, dynamic>? query,
    dynamic body,
    Map<String, String>? headers,
    bool authenticated = true,
    String? idempotencyKey,
  }) =>
      client.request<dynamic>(
        'PATCH',
        '/api/v1/admin/coupons/${id}',
        query: query,
        body: body is JsonModel ? body.toJson() : body,
        headers: headers,
        authenticated: authenticated,
        idempotencyKey: idempotencyKey,
      );

  /// DELETE /api/v1/admin/coupons/{id}
  Future<ApiResponse<dynamic>> deleteApiV1AdminCouponsId({
    required String id,
    Map<String, dynamic>? query,
    dynamic body,
    Map<String, String>? headers,
    bool authenticated = true,
    String? idempotencyKey,
  }) =>
      client.request<dynamic>(
        'DELETE',
        '/api/v1/admin/coupons/${id}',
        query: query,
        body: body is JsonModel ? body.toJson() : body,
        headers: headers,
        authenticated: authenticated,
        idempotencyKey: idempotencyKey,
      );

  /// GET /api/v1/admin/coupons
  Future<ApiResponse<dynamic>> getApiV1AdminCoupons({
    Map<String, dynamic>? query,
    dynamic body,
    Map<String, String>? headers,
    bool authenticated = true,
    String? idempotencyKey,
  }) =>
      client.request<dynamic>(
        'GET',
        '/api/v1/admin/coupons',
        query: query,
        body: body is JsonModel ? body.toJson() : body,
        headers: headers,
        authenticated: authenticated,
        idempotencyKey: idempotencyKey,
      );

  /// POST /api/v1/admin/coupons
  Future<ApiResponse<dynamic>> postApiV1AdminCoupons({
    Map<String, dynamic>? query,
    dynamic body,
    Map<String, String>? headers,
    bool authenticated = true,
    String? idempotencyKey,
  }) =>
      client.request<dynamic>(
        'POST',
        '/api/v1/admin/coupons',
        query: query,
        body: body is JsonModel ? body.toJson() : body,
        headers: headers,
        authenticated: authenticated,
        idempotencyKey: idempotencyKey,
      );

  /// GET /api/v1/admin/customers
  Future<ApiResponse<dynamic>> getApiV1AdminCustomers({
    Map<String, dynamic>? query,
    dynamic body,
    Map<String, String>? headers,
    bool authenticated = true,
    String? idempotencyKey,
  }) =>
      client.request<dynamic>(
        'GET',
        '/api/v1/admin/customers',
        query: query,
        body: body is JsonModel ? body.toJson() : body,
        headers: headers,
        authenticated: authenticated,
        idempotencyKey: idempotencyKey,
      );

  /// GET /api/v1/admin/dashboard
  Future<ApiResponse<dynamic>> getApiV1AdminDashboard({
    Map<String, dynamic>? query,
    dynamic body,
    Map<String, String>? headers,
    bool authenticated = true,
    String? idempotencyKey,
  }) =>
      client.request<dynamic>(
        'GET',
        '/api/v1/admin/dashboard',
        query: query,
        body: body is JsonModel ? body.toJson() : body,
        headers: headers,
        authenticated: authenticated,
        idempotencyKey: idempotencyKey,
      );

  /// POST /api/v1/admin/hero-slides/{id}/duplicate
  Future<ApiResponse<dynamic>> postApiV1AdminHeroSlidesIdDuplicate({
    required String id,
    Map<String, dynamic>? query,
    dynamic body,
    Map<String, String>? headers,
    bool authenticated = true,
    String? idempotencyKey,
  }) =>
      client.request<dynamic>(
        'POST',
        '/api/v1/admin/hero-slides/${id}/duplicate',
        query: query,
        body: body is JsonModel ? body.toJson() : body,
        headers: headers,
        authenticated: authenticated,
        idempotencyKey: idempotencyKey,
      );

  /// GET /api/v1/admin/hero-slides/{id}
  Future<ApiResponse<dynamic>> getApiV1AdminHeroSlidesId({
    required String id,
    Map<String, dynamic>? query,
    dynamic body,
    Map<String, String>? headers,
    bool authenticated = true,
    String? idempotencyKey,
  }) =>
      client.request<dynamic>(
        'GET',
        '/api/v1/admin/hero-slides/${id}',
        query: query,
        body: body is JsonModel ? body.toJson() : body,
        headers: headers,
        authenticated: authenticated,
        idempotencyKey: idempotencyKey,
      );

  /// PATCH /api/v1/admin/hero-slides/{id}
  Future<ApiResponse<dynamic>> patchApiV1AdminHeroSlidesId({
    required String id,
    Map<String, dynamic>? query,
    dynamic body,
    Map<String, String>? headers,
    bool authenticated = true,
    String? idempotencyKey,
  }) =>
      client.request<dynamic>(
        'PATCH',
        '/api/v1/admin/hero-slides/${id}',
        query: query,
        body: body is JsonModel ? body.toJson() : body,
        headers: headers,
        authenticated: authenticated,
        idempotencyKey: idempotencyKey,
      );

  /// DELETE /api/v1/admin/hero-slides/{id}
  Future<ApiResponse<dynamic>> deleteApiV1AdminHeroSlidesId({
    required String id,
    Map<String, dynamic>? query,
    dynamic body,
    Map<String, String>? headers,
    bool authenticated = true,
    String? idempotencyKey,
  }) =>
      client.request<dynamic>(
        'DELETE',
        '/api/v1/admin/hero-slides/${id}',
        query: query,
        body: body is JsonModel ? body.toJson() : body,
        headers: headers,
        authenticated: authenticated,
        idempotencyKey: idempotencyKey,
      );

  /// PATCH /api/v1/admin/hero-slides/reorder
  Future<ApiResponse<dynamic>> patchApiV1AdminHeroSlidesReorder({
    Map<String, dynamic>? query,
    dynamic body,
    Map<String, String>? headers,
    bool authenticated = true,
    String? idempotencyKey,
  }) =>
      client.request<dynamic>(
        'PATCH',
        '/api/v1/admin/hero-slides/reorder',
        query: query,
        body: body is JsonModel ? body.toJson() : body,
        headers: headers,
        authenticated: authenticated,
        idempotencyKey: idempotencyKey,
      );

  /// GET /api/v1/admin/hero-slides
  Future<ApiResponse<dynamic>> getApiV1AdminHeroSlides({
    Map<String, dynamic>? query,
    dynamic body,
    Map<String, String>? headers,
    bool authenticated = true,
    String? idempotencyKey,
  }) =>
      client.request<dynamic>(
        'GET',
        '/api/v1/admin/hero-slides',
        query: query,
        body: body is JsonModel ? body.toJson() : body,
        headers: headers,
        authenticated: authenticated,
        idempotencyKey: idempotencyKey,
      );

  /// POST /api/v1/admin/hero-slides
  Future<ApiResponse<dynamic>> postApiV1AdminHeroSlides({
    Map<String, dynamic>? query,
    dynamic body,
    Map<String, String>? headers,
    bool authenticated = true,
    String? idempotencyKey,
  }) =>
      client.request<dynamic>(
        'POST',
        '/api/v1/admin/hero-slides',
        query: query,
        body: body is JsonModel ? body.toJson() : body,
        headers: headers,
        authenticated: authenticated,
        idempotencyKey: idempotencyKey,
      );

  /// GET /api/v1/admin/inventory
  Future<ApiResponse<dynamic>> getApiV1AdminInventory({
    Map<String, dynamic>? query,
    dynamic body,
    Map<String, String>? headers,
    bool authenticated = true,
    String? idempotencyKey,
  }) =>
      client.request<dynamic>(
        'GET',
        '/api/v1/admin/inventory',
        query: query,
        body: body is JsonModel ? body.toJson() : body,
        headers: headers,
        authenticated: authenticated,
        idempotencyKey: idempotencyKey,
      );

  /// PATCH /api/v1/admin/inventory
  Future<ApiResponse<dynamic>> patchApiV1AdminInventory({
    Map<String, dynamic>? query,
    dynamic body,
    Map<String, String>? headers,
    bool authenticated = true,
    String? idempotencyKey,
  }) =>
      client.request<dynamic>(
        'PATCH',
        '/api/v1/admin/inventory',
        query: query,
        body: body is JsonModel ? body.toJson() : body,
        headers: headers,
        authenticated: authenticated,
        idempotencyKey: idempotencyKey,
      );

  /// GET /api/v1/admin/orders/{id}
  Future<ApiResponse<dynamic>> getApiV1AdminOrdersId({
    required String id,
    Map<String, dynamic>? query,
    dynamic body,
    Map<String, String>? headers,
    bool authenticated = true,
    String? idempotencyKey,
  }) =>
      client.request<dynamic>(
        'GET',
        '/api/v1/admin/orders/${id}',
        query: query,
        body: body is JsonModel ? body.toJson() : body,
        headers: headers,
        authenticated: authenticated,
        idempotencyKey: idempotencyKey,
      );

  /// PATCH /api/v1/admin/orders/{id}
  Future<ApiResponse<dynamic>> patchApiV1AdminOrdersId({
    required String id,
    Map<String, dynamic>? query,
    dynamic body,
    Map<String, String>? headers,
    bool authenticated = true,
    String? idempotencyKey,
  }) =>
      client.request<dynamic>(
        'PATCH',
        '/api/v1/admin/orders/${id}',
        query: query,
        body: body is JsonModel ? body.toJson() : body,
        headers: headers,
        authenticated: authenticated,
        idempotencyKey: idempotencyKey,
      );

  /// GET /api/v1/admin/orders
  Future<ApiResponse<dynamic>> getApiV1AdminOrders({
    Map<String, dynamic>? query,
    dynamic body,
    Map<String, String>? headers,
    bool authenticated = true,
    String? idempotencyKey,
  }) =>
      client.request<dynamic>(
        'GET',
        '/api/v1/admin/orders',
        query: query,
        body: body is JsonModel ? body.toJson() : body,
        headers: headers,
        authenticated: authenticated,
        idempotencyKey: idempotencyKey,
      );

  /// PATCH /api/v1/admin/orders
  Future<ApiResponse<dynamic>> patchApiV1AdminOrders({
    Map<String, dynamic>? query,
    dynamic body,
    Map<String, String>? headers,
    bool authenticated = true,
    String? idempotencyKey,
  }) =>
      client.request<dynamic>(
        'PATCH',
        '/api/v1/admin/orders',
        query: query,
        body: body is JsonModel ? body.toJson() : body,
        headers: headers,
        authenticated: authenticated,
        idempotencyKey: idempotencyKey,
      );

  /// PATCH /api/v1/admin/payment-providers/{provider}
  Future<ApiResponse<dynamic>> patchApiV1AdminPaymentProvidersProvider({
    required String provider,
    Map<String, dynamic>? query,
    dynamic body,
    Map<String, String>? headers,
    bool authenticated = true,
    String? idempotencyKey,
  }) =>
      client.request<dynamic>(
        'PATCH',
        '/api/v1/admin/payment-providers/${provider}',
        query: query,
        body: body is JsonModel ? body.toJson() : body,
        headers: headers,
        authenticated: authenticated,
        idempotencyKey: idempotencyKey,
      );

  /// POST /api/v1/admin/payment-providers/{provider}/test
  Future<ApiResponse<dynamic>> postApiV1AdminPaymentProvidersProviderTest({
    required String provider,
    Map<String, dynamic>? query,
    dynamic body,
    Map<String, String>? headers,
    bool authenticated = true,
    String? idempotencyKey,
  }) =>
      client.request<dynamic>(
        'POST',
        '/api/v1/admin/payment-providers/${provider}/test',
        query: query,
        body: body is JsonModel ? body.toJson() : body,
        headers: headers,
        authenticated: authenticated,
        idempotencyKey: idempotencyKey,
      );

  /// GET /api/v1/admin/payment-providers
  Future<ApiResponse<dynamic>> getApiV1AdminPaymentProviders({
    Map<String, dynamic>? query,
    dynamic body,
    Map<String, String>? headers,
    bool authenticated = true,
    String? idempotencyKey,
  }) =>
      client.request<dynamic>(
        'GET',
        '/api/v1/admin/payment-providers',
        query: query,
        body: body is JsonModel ? body.toJson() : body,
        headers: headers,
        authenticated: authenticated,
        idempotencyKey: idempotencyKey,
      );

  /// POST /api/v1/admin/payment-providers
  Future<ApiResponse<dynamic>> postApiV1AdminPaymentProviders({
    Map<String, dynamic>? query,
    dynamic body,
    Map<String, String>? headers,
    bool authenticated = true,
    String? idempotencyKey,
  }) =>
      client.request<dynamic>(
        'POST',
        '/api/v1/admin/payment-providers',
        query: query,
        body: body is JsonModel ? body.toJson() : body,
        headers: headers,
        authenticated: authenticated,
        idempotencyKey: idempotencyKey,
      );

  /// GET /api/v1/admin/payments
  Future<ApiResponse<dynamic>> getApiV1AdminPayments({
    Map<String, dynamic>? query,
    dynamic body,
    Map<String, String>? headers,
    bool authenticated = true,
    String? idempotencyKey,
  }) =>
      client.request<dynamic>(
        'GET',
        '/api/v1/admin/payments',
        query: query,
        body: body is JsonModel ? body.toJson() : body,
        headers: headers,
        authenticated: authenticated,
        idempotencyKey: idempotencyKey,
      );

  /// PATCH /api/v1/admin/price-lists/{id}
  Future<ApiResponse<dynamic>> patchApiV1AdminPriceListsId({
    required String id,
    Map<String, dynamic>? query,
    dynamic body,
    Map<String, String>? headers,
    bool authenticated = true,
    String? idempotencyKey,
  }) =>
      client.request<dynamic>(
        'PATCH',
        '/api/v1/admin/price-lists/${id}',
        query: query,
        body: body is JsonModel ? body.toJson() : body,
        headers: headers,
        authenticated: authenticated,
        idempotencyKey: idempotencyKey,
      );

  /// DELETE /api/v1/admin/price-lists/{id}
  Future<ApiResponse<dynamic>> deleteApiV1AdminPriceListsId({
    required String id,
    Map<String, dynamic>? query,
    dynamic body,
    Map<String, String>? headers,
    bool authenticated = true,
    String? idempotencyKey,
  }) =>
      client.request<dynamic>(
        'DELETE',
        '/api/v1/admin/price-lists/${id}',
        query: query,
        body: body is JsonModel ? body.toJson() : body,
        headers: headers,
        authenticated: authenticated,
        idempotencyKey: idempotencyKey,
      );

  /// GET /api/v1/admin/price-lists
  Future<ApiResponse<dynamic>> getApiV1AdminPriceLists({
    Map<String, dynamic>? query,
    dynamic body,
    Map<String, String>? headers,
    bool authenticated = true,
    String? idempotencyKey,
  }) =>
      client.request<dynamic>(
        'GET',
        '/api/v1/admin/price-lists',
        query: query,
        body: body is JsonModel ? body.toJson() : body,
        headers: headers,
        authenticated: authenticated,
        idempotencyKey: idempotencyKey,
      );

  /// POST /api/v1/admin/price-lists
  Future<ApiResponse<dynamic>> postApiV1AdminPriceLists({
    Map<String, dynamic>? query,
    dynamic body,
    Map<String, String>? headers,
    bool authenticated = true,
    String? idempotencyKey,
  }) =>
      client.request<dynamic>(
        'POST',
        '/api/v1/admin/price-lists',
        query: query,
        body: body is JsonModel ? body.toJson() : body,
        headers: headers,
        authenticated: authenticated,
        idempotencyKey: idempotencyKey,
      );

  /// GET /api/v1/admin/products
  Future<ApiResponse<dynamic>> getApiV1AdminProducts({
    Map<String, dynamic>? query,
    dynamic body,
    Map<String, String>? headers,
    bool authenticated = true,
    String? idempotencyKey,
  }) =>
      client.request<dynamic>(
        'GET',
        '/api/v1/admin/products',
        query: query,
        body: body is JsonModel ? body.toJson() : body,
        headers: headers,
        authenticated: authenticated,
        idempotencyKey: idempotencyKey,
      );

  /// POST /api/v1/admin/products
  Future<ApiResponse<dynamic>> postApiV1AdminProducts({
    Map<String, dynamic>? query,
    dynamic body,
    Map<String, String>? headers,
    bool authenticated = true,
    String? idempotencyKey,
  }) =>
      client.request<dynamic>(
        'POST',
        '/api/v1/admin/products',
        query: query,
        body: body is JsonModel ? body.toJson() : body,
        headers: headers,
        authenticated: authenticated,
        idempotencyKey: idempotencyKey,
      );

  /// PATCH /api/v1/admin/products
  Future<ApiResponse<dynamic>> patchApiV1AdminProducts({
    Map<String, dynamic>? query,
    dynamic body,
    Map<String, String>? headers,
    bool authenticated = true,
    String? idempotencyKey,
  }) =>
      client.request<dynamic>(
        'PATCH',
        '/api/v1/admin/products',
        query: query,
        body: body is JsonModel ? body.toJson() : body,
        headers: headers,
        authenticated: authenticated,
        idempotencyKey: idempotencyKey,
      );

  /// DELETE /api/v1/admin/products
  Future<ApiResponse<dynamic>> deleteApiV1AdminProducts({
    Map<String, dynamic>? query,
    dynamic body,
    Map<String, String>? headers,
    bool authenticated = true,
    String? idempotencyKey,
  }) =>
      client.request<dynamic>(
        'DELETE',
        '/api/v1/admin/products',
        query: query,
        body: body is JsonModel ? body.toJson() : body,
        headers: headers,
        authenticated: authenticated,
        idempotencyKey: idempotencyKey,
      );

  /// PATCH /api/v1/admin/reviews/{id}
  Future<ApiResponse<dynamic>> patchApiV1AdminReviewsId({
    required String id,
    Map<String, dynamic>? query,
    dynamic body,
    Map<String, String>? headers,
    bool authenticated = true,
    String? idempotencyKey,
  }) =>
      client.request<dynamic>(
        'PATCH',
        '/api/v1/admin/reviews/${id}',
        query: query,
        body: body is JsonModel ? body.toJson() : body,
        headers: headers,
        authenticated: authenticated,
        idempotencyKey: idempotencyKey,
      );

  /// DELETE /api/v1/admin/reviews/{id}
  Future<ApiResponse<dynamic>> deleteApiV1AdminReviewsId({
    required String id,
    Map<String, dynamic>? query,
    dynamic body,
    Map<String, String>? headers,
    bool authenticated = true,
    String? idempotencyKey,
  }) =>
      client.request<dynamic>(
        'DELETE',
        '/api/v1/admin/reviews/${id}',
        query: query,
        body: body is JsonModel ? body.toJson() : body,
        headers: headers,
        authenticated: authenticated,
        idempotencyKey: idempotencyKey,
      );

  /// GET /api/v1/admin/reviews
  Future<ApiResponse<dynamic>> getApiV1AdminReviews({
    Map<String, dynamic>? query,
    dynamic body,
    Map<String, String>? headers,
    bool authenticated = true,
    String? idempotencyKey,
  }) =>
      client.request<dynamic>(
        'GET',
        '/api/v1/admin/reviews',
        query: query,
        body: body is JsonModel ? body.toJson() : body,
        headers: headers,
        authenticated: authenticated,
        idempotencyKey: idempotencyKey,
      );

  /// PATCH /api/v1/admin/reviews
  Future<ApiResponse<dynamic>> patchApiV1AdminReviews({
    Map<String, dynamic>? query,
    dynamic body,
    Map<String, String>? headers,
    bool authenticated = true,
    String? idempotencyKey,
  }) =>
      client.request<dynamic>(
        'PATCH',
        '/api/v1/admin/reviews',
        query: query,
        body: body is JsonModel ? body.toJson() : body,
        headers: headers,
        authenticated: authenticated,
        idempotencyKey: idempotencyKey,
      );

  /// GET /api/v1/admin/roles
  Future<ApiResponse<dynamic>> getApiV1AdminRoles({
    Map<String, dynamic>? query,
    dynamic body,
    Map<String, String>? headers,
    bool authenticated = true,
    String? idempotencyKey,
  }) =>
      client.request<dynamic>(
        'GET',
        '/api/v1/admin/roles',
        query: query,
        body: body is JsonModel ? body.toJson() : body,
        headers: headers,
        authenticated: authenticated,
        idempotencyKey: idempotencyKey,
      );

  /// POST /api/v1/admin/roles
  Future<ApiResponse<dynamic>> postApiV1AdminRoles({
    Map<String, dynamic>? query,
    dynamic body,
    Map<String, String>? headers,
    bool authenticated = true,
    String? idempotencyKey,
  }) =>
      client.request<dynamic>(
        'POST',
        '/api/v1/admin/roles',
        query: query,
        body: body is JsonModel ? body.toJson() : body,
        headers: headers,
        authenticated: authenticated,
        idempotencyKey: idempotencyKey,
      );

  /// GET /api/v1/admin/settings
  Future<ApiResponse<dynamic>> getApiV1AdminSettings({
    Map<String, dynamic>? query,
    dynamic body,
    Map<String, String>? headers,
    bool authenticated = true,
    String? idempotencyKey,
  }) =>
      client.request<dynamic>(
        'GET',
        '/api/v1/admin/settings',
        query: query,
        body: body is JsonModel ? body.toJson() : body,
        headers: headers,
        authenticated: authenticated,
        idempotencyKey: idempotencyKey,
      );

  /// POST /api/v1/admin/settings
  Future<ApiResponse<dynamic>> postApiV1AdminSettings({
    Map<String, dynamic>? query,
    dynamic body,
    Map<String, String>? headers,
    bool authenticated = true,
    String? idempotencyKey,
  }) =>
      client.request<dynamic>(
        'POST',
        '/api/v1/admin/settings',
        query: query,
        body: body is JsonModel ? body.toJson() : body,
        headers: headers,
        authenticated: authenticated,
        idempotencyKey: idempotencyKey,
      );

  /// PATCH /api/v1/admin/shipping/{id}
  Future<ApiResponse<dynamic>> patchApiV1AdminShippingId({
    required String id,
    Map<String, dynamic>? query,
    dynamic body,
    Map<String, String>? headers,
    bool authenticated = true,
    String? idempotencyKey,
  }) =>
      client.request<dynamic>(
        'PATCH',
        '/api/v1/admin/shipping/${id}',
        query: query,
        body: body is JsonModel ? body.toJson() : body,
        headers: headers,
        authenticated: authenticated,
        idempotencyKey: idempotencyKey,
      );

  /// DELETE /api/v1/admin/shipping/{id}
  Future<ApiResponse<dynamic>> deleteApiV1AdminShippingId({
    required String id,
    Map<String, dynamic>? query,
    dynamic body,
    Map<String, String>? headers,
    bool authenticated = true,
    String? idempotencyKey,
  }) =>
      client.request<dynamic>(
        'DELETE',
        '/api/v1/admin/shipping/${id}',
        query: query,
        body: body is JsonModel ? body.toJson() : body,
        headers: headers,
        authenticated: authenticated,
        idempotencyKey: idempotencyKey,
      );

  /// GET /api/v1/admin/shipping
  Future<ApiResponse<dynamic>> getApiV1AdminShipping({
    Map<String, dynamic>? query,
    dynamic body,
    Map<String, String>? headers,
    bool authenticated = true,
    String? idempotencyKey,
  }) =>
      client.request<dynamic>(
        'GET',
        '/api/v1/admin/shipping',
        query: query,
        body: body is JsonModel ? body.toJson() : body,
        headers: headers,
        authenticated: authenticated,
        idempotencyKey: idempotencyKey,
      );

  /// POST /api/v1/admin/shipping
  Future<ApiResponse<dynamic>> postApiV1AdminShipping({
    Map<String, dynamic>? query,
    dynamic body,
    Map<String, String>? headers,
    bool authenticated = true,
    String? idempotencyKey,
  }) =>
      client.request<dynamic>(
        'POST',
        '/api/v1/admin/shipping',
        query: query,
        body: body is JsonModel ? body.toJson() : body,
        headers: headers,
        authenticated: authenticated,
        idempotencyKey: idempotencyKey,
      );

  /// PATCH /api/v1/admin/shipping-countries/{id}
  Future<ApiResponse<dynamic>> patchApiV1AdminShippingCountriesId({
    required String id,
    Map<String, dynamic>? query,
    dynamic body,
    Map<String, String>? headers,
    bool authenticated = true,
    String? idempotencyKey,
  }) =>
      client.request<dynamic>(
        'PATCH',
        '/api/v1/admin/shipping-countries/${id}',
        query: query,
        body: body is JsonModel ? body.toJson() : body,
        headers: headers,
        authenticated: authenticated,
        idempotencyKey: idempotencyKey,
      );

  /// DELETE /api/v1/admin/shipping-countries/{id}
  Future<ApiResponse<dynamic>> deleteApiV1AdminShippingCountriesId({
    required String id,
    Map<String, dynamic>? query,
    dynamic body,
    Map<String, String>? headers,
    bool authenticated = true,
    String? idempotencyKey,
  }) =>
      client.request<dynamic>(
        'DELETE',
        '/api/v1/admin/shipping-countries/${id}',
        query: query,
        body: body is JsonModel ? body.toJson() : body,
        headers: headers,
        authenticated: authenticated,
        idempotencyKey: idempotencyKey,
      );

  /// GET /api/v1/admin/shipping-countries
  Future<ApiResponse<dynamic>> getApiV1AdminShippingCountries({
    Map<String, dynamic>? query,
    dynamic body,
    Map<String, String>? headers,
    bool authenticated = true,
    String? idempotencyKey,
  }) =>
      client.request<dynamic>(
        'GET',
        '/api/v1/admin/shipping-countries',
        query: query,
        body: body is JsonModel ? body.toJson() : body,
        headers: headers,
        authenticated: authenticated,
        idempotencyKey: idempotencyKey,
      );

  /// POST /api/v1/admin/shipping-countries
  Future<ApiResponse<dynamic>> postApiV1AdminShippingCountries({
    Map<String, dynamic>? query,
    dynamic body,
    Map<String, String>? headers,
    bool authenticated = true,
    String? idempotencyKey,
  }) =>
      client.request<dynamic>(
        'POST',
        '/api/v1/admin/shipping-countries',
        query: query,
        body: body is JsonModel ? body.toJson() : body,
        headers: headers,
        authenticated: authenticated,
        idempotencyKey: idempotencyKey,
      );

  /// PATCH /api/v1/admin/shipping-governorates/{id}
  Future<ApiResponse<dynamic>> patchApiV1AdminShippingGovernoratesId({
    required String id,
    Map<String, dynamic>? query,
    dynamic body,
    Map<String, String>? headers,
    bool authenticated = true,
    String? idempotencyKey,
  }) =>
      client.request<dynamic>(
        'PATCH',
        '/api/v1/admin/shipping-governorates/${id}',
        query: query,
        body: body is JsonModel ? body.toJson() : body,
        headers: headers,
        authenticated: authenticated,
        idempotencyKey: idempotencyKey,
      );

  /// DELETE /api/v1/admin/shipping-governorates/{id}
  Future<ApiResponse<dynamic>> deleteApiV1AdminShippingGovernoratesId({
    required String id,
    Map<String, dynamic>? query,
    dynamic body,
    Map<String, String>? headers,
    bool authenticated = true,
    String? idempotencyKey,
  }) =>
      client.request<dynamic>(
        'DELETE',
        '/api/v1/admin/shipping-governorates/${id}',
        query: query,
        body: body is JsonModel ? body.toJson() : body,
        headers: headers,
        authenticated: authenticated,
        idempotencyKey: idempotencyKey,
      );

  /// GET /api/v1/admin/shipping-governorates
  Future<ApiResponse<dynamic>> getApiV1AdminShippingGovernorates({
    Map<String, dynamic>? query,
    dynamic body,
    Map<String, String>? headers,
    bool authenticated = true,
    String? idempotencyKey,
  }) =>
      client.request<dynamic>(
        'GET',
        '/api/v1/admin/shipping-governorates',
        query: query,
        body: body is JsonModel ? body.toJson() : body,
        headers: headers,
        authenticated: authenticated,
        idempotencyKey: idempotencyKey,
      );

  /// POST /api/v1/admin/shipping-governorates
  Future<ApiResponse<dynamic>> postApiV1AdminShippingGovernorates({
    Map<String, dynamic>? query,
    dynamic body,
    Map<String, String>? headers,
    bool authenticated = true,
    String? idempotencyKey,
  }) =>
      client.request<dynamic>(
        'POST',
        '/api/v1/admin/shipping-governorates',
        query: query,
        body: body is JsonModel ? body.toJson() : body,
        headers: headers,
        authenticated: authenticated,
        idempotencyKey: idempotencyKey,
      );

  /// PATCH /api/v1/admin/tags/{id}
  Future<ApiResponse<dynamic>> patchApiV1AdminTagsId({
    required String id,
    Map<String, dynamic>? query,
    dynamic body,
    Map<String, String>? headers,
    bool authenticated = true,
    String? idempotencyKey,
  }) =>
      client.request<dynamic>(
        'PATCH',
        '/api/v1/admin/tags/${id}',
        query: query,
        body: body is JsonModel ? body.toJson() : body,
        headers: headers,
        authenticated: authenticated,
        idempotencyKey: idempotencyKey,
      );

  /// DELETE /api/v1/admin/tags/{id}
  Future<ApiResponse<dynamic>> deleteApiV1AdminTagsId({
    required String id,
    Map<String, dynamic>? query,
    dynamic body,
    Map<String, String>? headers,
    bool authenticated = true,
    String? idempotencyKey,
  }) =>
      client.request<dynamic>(
        'DELETE',
        '/api/v1/admin/tags/${id}',
        query: query,
        body: body is JsonModel ? body.toJson() : body,
        headers: headers,
        authenticated: authenticated,
        idempotencyKey: idempotencyKey,
      );

  /// GET /api/v1/admin/tags
  Future<ApiResponse<dynamic>> getApiV1AdminTags({
    Map<String, dynamic>? query,
    dynamic body,
    Map<String, String>? headers,
    bool authenticated = true,
    String? idempotencyKey,
  }) =>
      client.request<dynamic>(
        'GET',
        '/api/v1/admin/tags',
        query: query,
        body: body is JsonModel ? body.toJson() : body,
        headers: headers,
        authenticated: authenticated,
        idempotencyKey: idempotencyKey,
      );

  /// POST /api/v1/admin/tags
  Future<ApiResponse<dynamic>> postApiV1AdminTags({
    Map<String, dynamic>? query,
    dynamic body,
    Map<String, String>? headers,
    bool authenticated = true,
    String? idempotencyKey,
  }) =>
      client.request<dynamic>(
        'POST',
        '/api/v1/admin/tags',
        query: query,
        body: body is JsonModel ? body.toJson() : body,
        headers: headers,
        authenticated: authenticated,
        idempotencyKey: idempotencyKey,
      );

  /// GET /api/v1/admin/users/{id}
  Future<ApiResponse<dynamic>> getApiV1AdminUsersId({
    required String id,
    Map<String, dynamic>? query,
    dynamic body,
    Map<String, String>? headers,
    bool authenticated = true,
    String? idempotencyKey,
  }) =>
      client.request<dynamic>(
        'GET',
        '/api/v1/admin/users/${id}',
        query: query,
        body: body is JsonModel ? body.toJson() : body,
        headers: headers,
        authenticated: authenticated,
        idempotencyKey: idempotencyKey,
      );

  /// PATCH /api/v1/admin/users/{id}
  Future<ApiResponse<dynamic>> patchApiV1AdminUsersId({
    required String id,
    Map<String, dynamic>? query,
    dynamic body,
    Map<String, String>? headers,
    bool authenticated = true,
    String? idempotencyKey,
  }) =>
      client.request<dynamic>(
        'PATCH',
        '/api/v1/admin/users/${id}',
        query: query,
        body: body is JsonModel ? body.toJson() : body,
        headers: headers,
        authenticated: authenticated,
        idempotencyKey: idempotencyKey,
      );

  /// GET /api/v1/admin/users
  Future<ApiResponse<dynamic>> getApiV1AdminUsers({
    Map<String, dynamic>? query,
    dynamic body,
    Map<String, String>? headers,
    bool authenticated = true,
    String? idempotencyKey,
  }) =>
      client.request<dynamic>(
        'GET',
        '/api/v1/admin/users',
        query: query,
        body: body is JsonModel ? body.toJson() : body,
        headers: headers,
        authenticated: authenticated,
        idempotencyKey: idempotencyKey,
      );

  /// PATCH /api/v1/admin/wallets/{id}
  Future<ApiResponse<dynamic>> patchApiV1AdminWalletsId({
    required String id,
    Map<String, dynamic>? query,
    dynamic body,
    Map<String, String>? headers,
    bool authenticated = true,
    String? idempotencyKey,
  }) =>
      client.request<dynamic>(
        'PATCH',
        '/api/v1/admin/wallets/${id}',
        query: query,
        body: body is JsonModel ? body.toJson() : body,
        headers: headers,
        authenticated: authenticated,
        idempotencyKey: idempotencyKey,
      );

  /// DELETE /api/v1/admin/wallets/{id}
  Future<ApiResponse<dynamic>> deleteApiV1AdminWalletsId({
    required String id,
    Map<String, dynamic>? query,
    dynamic body,
    Map<String, String>? headers,
    bool authenticated = true,
    String? idempotencyKey,
  }) =>
      client.request<dynamic>(
        'DELETE',
        '/api/v1/admin/wallets/${id}',
        query: query,
        body: body is JsonModel ? body.toJson() : body,
        headers: headers,
        authenticated: authenticated,
        idempotencyKey: idempotencyKey,
      );

  /// GET /api/v1/admin/wallets
  Future<ApiResponse<dynamic>> getApiV1AdminWallets({
    Map<String, dynamic>? query,
    dynamic body,
    Map<String, String>? headers,
    bool authenticated = true,
    String? idempotencyKey,
  }) =>
      client.request<dynamic>(
        'GET',
        '/api/v1/admin/wallets',
        query: query,
        body: body is JsonModel ? body.toJson() : body,
        headers: headers,
        authenticated: authenticated,
        idempotencyKey: idempotencyKey,
      );

  /// POST /api/v1/admin/wallets
  Future<ApiResponse<dynamic>> postApiV1AdminWallets({
    Map<String, dynamic>? query,
    dynamic body,
    Map<String, String>? headers,
    bool authenticated = true,
    String? idempotencyKey,
  }) =>
      client.request<dynamic>(
        'POST',
        '/api/v1/admin/wallets',
        query: query,
        body: body is JsonModel ? body.toJson() : body,
        headers: headers,
        authenticated: authenticated,
        idempotencyKey: idempotencyKey,
      );

  /// GET /api/v1/auth/{...auth}
  Future<ApiResponse<dynamic>> getApiV1AuthCatchAll({
    String catchAll = '',
    Map<String, dynamic>? query,
    dynamic body,
    Map<String, String>? headers,
    bool authenticated = true,
    String? idempotencyKey,
  }) =>
      client.request<dynamic>(
        'GET',
        '/api/v1/auth/${catchAll}',
        query: query,
        body: body is JsonModel ? body.toJson() : body,
        headers: headers,
        authenticated: authenticated,
        idempotencyKey: idempotencyKey,
      );

  /// POST /api/v1/auth/{...auth}
  Future<ApiResponse<dynamic>> postApiV1AuthCatchAll({
    String catchAll = '',
    Map<String, dynamic>? query,
    dynamic body,
    Map<String, String>? headers,
    bool authenticated = true,
    String? idempotencyKey,
  }) =>
      client.request<dynamic>(
        'POST',
        '/api/v1/auth/${catchAll}',
        query: query,
        body: body is JsonModel ? body.toJson() : body,
        headers: headers,
        authenticated: authenticated,
        idempotencyKey: idempotencyKey,
      );

  /// GET /api/v1/brands
  Future<ApiResponse<dynamic>> getApiV1Brands({
    Map<String, dynamic>? query,
    dynamic body,
    Map<String, String>? headers,
    bool authenticated = true,
    String? idempotencyKey,
  }) =>
      client.request<dynamic>(
        'GET',
        '/api/v1/brands',
        query: query,
        body: body is JsonModel ? body.toJson() : body,
        headers: headers,
        authenticated: authenticated,
        idempotencyKey: idempotencyKey,
      );

  /// POST /api/v1/cart/merge
  Future<ApiResponse<dynamic>> postApiV1CartMerge({
    Map<String, dynamic>? query,
    dynamic body,
    Map<String, String>? headers,
    bool authenticated = true,
    String? idempotencyKey,
  }) =>
      client.request<dynamic>(
        'POST',
        '/api/v1/cart/merge',
        query: query,
        body: body is JsonModel ? body.toJson() : body,
        headers: headers,
        authenticated: authenticated,
        idempotencyKey: idempotencyKey,
      );

  /// GET /api/v1/cart
  Future<ApiResponse<dynamic>> getApiV1Cart({
    Map<String, dynamic>? query,
    dynamic body,
    Map<String, String>? headers,
    bool authenticated = true,
    String? idempotencyKey,
  }) =>
      client.request<dynamic>(
        'GET',
        '/api/v1/cart',
        query: query,
        body: body is JsonModel ? body.toJson() : body,
        headers: headers,
        authenticated: authenticated,
        idempotencyKey: idempotencyKey,
      );

  /// POST /api/v1/cart
  Future<ApiResponse<dynamic>> postApiV1Cart({
    Map<String, dynamic>? query,
    dynamic body,
    Map<String, String>? headers,
    bool authenticated = true,
    String? idempotencyKey,
  }) =>
      client.request<dynamic>(
        'POST',
        '/api/v1/cart',
        query: query,
        body: body is JsonModel ? body.toJson() : body,
        headers: headers,
        authenticated: authenticated,
        idempotencyKey: idempotencyKey,
      );

  /// PATCH /api/v1/cart
  Future<ApiResponse<dynamic>> patchApiV1Cart({
    Map<String, dynamic>? query,
    dynamic body,
    Map<String, String>? headers,
    bool authenticated = true,
    String? idempotencyKey,
  }) =>
      client.request<dynamic>(
        'PATCH',
        '/api/v1/cart',
        query: query,
        body: body is JsonModel ? body.toJson() : body,
        headers: headers,
        authenticated: authenticated,
        idempotencyKey: idempotencyKey,
      );

  /// DELETE /api/v1/cart
  Future<ApiResponse<dynamic>> deleteApiV1Cart({
    Map<String, dynamic>? query,
    dynamic body,
    Map<String, String>? headers,
    bool authenticated = true,
    String? idempotencyKey,
  }) =>
      client.request<dynamic>(
        'DELETE',
        '/api/v1/cart',
        query: query,
        body: body is JsonModel ? body.toJson() : body,
        headers: headers,
        authenticated: authenticated,
        idempotencyKey: idempotencyKey,
      );

  /// GET /api/v1/categories
  Future<ApiResponse<dynamic>> getApiV1Categories({
    Map<String, dynamic>? query,
    dynamic body,
    Map<String, String>? headers,
    bool authenticated = true,
    String? idempotencyKey,
  }) =>
      client.request<dynamic>(
        'GET',
        '/api/v1/categories',
        query: query,
        body: body is JsonModel ? body.toJson() : body,
        headers: headers,
        authenticated: authenticated,
        idempotencyKey: idempotencyKey,
      );

  /// POST /api/v1/checkout/quote
  Future<ApiResponse<dynamic>> postApiV1CheckoutQuote({
    Map<String, dynamic>? query,
    dynamic body,
    Map<String, String>? headers,
    bool authenticated = true,
    String? idempotencyKey,
  }) =>
      client.request<dynamic>(
        'POST',
        '/api/v1/checkout/quote',
        query: query,
        body: body is JsonModel ? body.toJson() : body,
        headers: headers,
        authenticated: authenticated,
        idempotencyKey: idempotencyKey,
      );

  /// POST /api/v1/checkout
  Future<ApiResponse<dynamic>> postApiV1Checkout({
    Map<String, dynamic>? query,
    dynamic body,
    Map<String, String>? headers,
    bool authenticated = true,
    String? idempotencyKey,
  }) =>
      client.request<dynamic>(
        'POST',
        '/api/v1/checkout',
        query: query,
        body: body is JsonModel ? body.toJson() : body,
        headers: headers,
        authenticated: authenticated,
        idempotencyKey: idempotencyKey,
      );

  /// GET /api/v1/commerce/country
  Future<ApiResponse<dynamic>> getApiV1CommerceCountry({
    Map<String, dynamic>? query,
    dynamic body,
    Map<String, String>? headers,
    bool authenticated = true,
    String? idempotencyKey,
  }) =>
      client.request<dynamic>(
        'GET',
        '/api/v1/commerce/country',
        query: query,
        body: body is JsonModel ? body.toJson() : body,
        headers: headers,
        authenticated: authenticated,
        idempotencyKey: idempotencyKey,
      );

  /// POST /api/v1/commerce/country
  Future<ApiResponse<dynamic>> postApiV1CommerceCountry({
    Map<String, dynamic>? query,
    dynamic body,
    Map<String, String>? headers,
    bool authenticated = true,
    String? idempotencyKey,
  }) =>
      client.request<dynamic>(
        'POST',
        '/api/v1/commerce/country',
        query: query,
        body: body is JsonModel ? body.toJson() : body,
        headers: headers,
        authenticated: authenticated,
        idempotencyKey: idempotencyKey,
      );

  /// POST /api/v1/contact
  Future<ApiResponse<dynamic>> postApiV1Contact({
    Map<String, dynamic>? query,
    dynamic body,
    Map<String, String>? headers,
    bool authenticated = true,
    String? idempotencyKey,
  }) =>
      client.request<dynamic>(
        'POST',
        '/api/v1/contact',
        query: query,
        body: body is JsonModel ? body.toJson() : body,
        headers: headers,
        authenticated: authenticated,
        idempotencyKey: idempotencyKey,
      );

  /// GET /api/v1/hero
  Future<ApiResponse<dynamic>> getApiV1Hero({
    Map<String, dynamic>? query,
    dynamic body,
    Map<String, String>? headers,
    bool authenticated = true,
    String? idempotencyKey,
  }) =>
      client.request<dynamic>(
        'GET',
        '/api/v1/hero',
        query: query,
        body: body is JsonModel ? body.toJson() : body,
        headers: headers,
        authenticated: authenticated,
        idempotencyKey: idempotencyKey,
      );

  /// GET /api/v1/store/branding
  Future<ApiResponse<dynamic>> getApiV1StoreBranding({
    Map<String, dynamic>? query,
    dynamic body,
    Map<String, String>? headers,
    bool authenticated = true,
    String? idempotencyKey,
  }) =>
      client.request<dynamic>(
        'GET',
        '/api/v1/store/branding',
        query: query,
        body: body is JsonModel ? body.toJson() : body,
        headers: headers,
        authenticated: authenticated,
        idempotencyKey: idempotencyKey,
      );

  /// POST /api/v1/locale
  Future<ApiResponse<dynamic>> postApiV1Locale({
    Map<String, dynamic>? query,
    dynamic body,
    Map<String, String>? headers,
    bool authenticated = true,
    String? idempotencyKey,
  }) =>
      client.request<dynamic>(
        'POST',
        '/api/v1/locale',
        query: query,
        body: body is JsonModel ? body.toJson() : body,
        headers: headers,
        authenticated: authenticated,
        idempotencyKey: idempotencyKey,
      );

  /// POST /api/v1/media/delete
  Future<ApiResponse<dynamic>> postApiV1MediaDelete({
    Map<String, dynamic>? query,
    dynamic body,
    Map<String, String>? headers,
    bool authenticated = true,
    String? idempotencyKey,
  }) =>
      client.request<dynamic>(
        'POST',
        '/api/v1/media/delete',
        query: query,
        body: body is JsonModel ? body.toJson() : body,
        headers: headers,
        authenticated: authenticated,
        idempotencyKey: idempotencyKey,
      );

  /// POST /api/v1/media/upload
  Future<ApiResponse<dynamic>> postApiV1MediaUpload({
    Map<String, dynamic>? query,
    dynamic body,
    Map<String, String>? headers,
    bool authenticated = true,
    String? idempotencyKey,
  }) =>
      client.request<dynamic>(
        'POST',
        '/api/v1/media/upload',
        query: query,
        body: body is JsonModel ? body.toJson() : body,
        headers: headers,
        authenticated: authenticated,
        idempotencyKey: idempotencyKey,
      );

  /// GET /api/v1/orders/{id}
  Future<ApiResponse<dynamic>> getApiV1OrdersId({
    required String id,
    Map<String, dynamic>? query,
    dynamic body,
    Map<String, String>? headers,
    bool authenticated = true,
    String? idempotencyKey,
  }) =>
      client.request<dynamic>(
        'GET',
        '/api/v1/orders/${id}',
        query: query,
        body: body is JsonModel ? body.toJson() : body,
        headers: headers,
        authenticated: authenticated,
        idempotencyKey: idempotencyKey,
      );

  /// POST /api/v1/orders
  Future<ApiResponse<dynamic>> postApiV1Orders({
    Map<String, dynamic>? query,
    dynamic body,
    Map<String, String>? headers,
    bool authenticated = true,
    String? idempotencyKey,
  }) =>
      client.request<dynamic>(
        'POST',
        '/api/v1/orders',
        query: query,
        body: body is JsonModel ? body.toJson() : body,
        headers: headers,
        authenticated: authenticated,
        idempotencyKey: idempotencyKey,
      );

  /// GET /api/v1/orders
  Future<ApiResponse<dynamic>> getApiV1Orders({
    Map<String, dynamic>? query,
    dynamic body,
    Map<String, String>? headers,
    bool authenticated = true,
    String? idempotencyKey,
  }) =>
      client.request<dynamic>(
        'GET',
        '/api/v1/orders',
        query: query,
        body: body is JsonModel ? body.toJson() : body,
        headers: headers,
        authenticated: authenticated,
        idempotencyKey: idempotencyKey,
      );

  /// GET /api/v1/payments/paymob/{paymentId}
  Future<ApiResponse<dynamic>> getApiV1PaymentsPaymobPaymentId({
    required String paymentId,
    Map<String, dynamic>? query,
    dynamic body,
    Map<String, String>? headers,
    bool authenticated = true,
    String? idempotencyKey,
  }) =>
      client.request<dynamic>(
        'GET',
        '/api/v1/payments/paymob/${paymentId}',
        query: query,
        body: body is JsonModel ? body.toJson() : body,
        headers: headers,
        authenticated: authenticated,
        idempotencyKey: idempotencyKey,
      );

  /// POST /api/v1/payments/paymob/create
  Future<ApiResponse<dynamic>> postApiV1PaymentsPaymobCreate({
    Map<String, dynamic>? query,
    dynamic body,
    Map<String, String>? headers,
    bool authenticated = true,
    String? idempotencyKey,
  }) =>
      client.request<dynamic>(
        'POST',
        '/api/v1/payments/paymob/create',
        query: query,
        body: body is JsonModel ? body.toJson() : body,
        headers: headers,
        authenticated: authenticated,
        idempotencyKey: idempotencyKey,
      );

  /// GET /api/v1/products/{id}/reviews
  Future<ApiResponse<dynamic>> getApiV1ProductsIdReviews({
    required String id,
    Map<String, dynamic>? query,
    dynamic body,
    Map<String, String>? headers,
    bool authenticated = true,
    String? idempotencyKey,
  }) =>
      client.request<dynamic>(
        'GET',
        '/api/v1/products/${id}/reviews',
        query: query,
        body: body is JsonModel ? body.toJson() : body,
        headers: headers,
        authenticated: authenticated,
        idempotencyKey: idempotencyKey,
      );

  /// POST /api/v1/products/{id}/reviews
  Future<ApiResponse<dynamic>> postApiV1ProductsIdReviews({
    required String id,
    Map<String, dynamic>? query,
    dynamic body,
    Map<String, String>? headers,
    bool authenticated = true,
    String? idempotencyKey,
  }) =>
      client.request<dynamic>(
        'POST',
        '/api/v1/products/${id}/reviews',
        query: query,
        body: body is JsonModel ? body.toJson() : body,
        headers: headers,
        authenticated: authenticated,
        idempotencyKey: idempotencyKey,
      );

  /// GET /api/v1/products/{id}
  Future<ApiResponse<dynamic>> getApiV1ProductsId({
    required String id,
    Map<String, dynamic>? query,
    dynamic body,
    Map<String, String>? headers,
    bool authenticated = true,
    String? idempotencyKey,
  }) =>
      client.request<dynamic>(
        'GET',
        '/api/v1/products/${id}',
        query: query,
        body: body is JsonModel ? body.toJson() : body,
        headers: headers,
        authenticated: authenticated,
        idempotencyKey: idempotencyKey,
      );

  /// GET /api/v1/products
  Future<ApiResponse<dynamic>> getApiV1Products({
    Map<String, dynamic>? query,
    dynamic body,
    Map<String, String>? headers,
    bool authenticated = true,
    String? idempotencyKey,
  }) =>
      client.request<dynamic>(
        'GET',
        '/api/v1/products',
        query: query,
        body: body is JsonModel ? body.toJson() : body,
        headers: headers,
        authenticated: authenticated,
        idempotencyKey: idempotencyKey,
      );

  /// GET /api/v1/shipping/countries/{code}/payment-methods
  Future<ApiResponse<dynamic>> getApiV1ShippingCountriesCodePaymentMethods({
    required String code,
    Map<String, dynamic>? query,
    dynamic body,
    Map<String, String>? headers,
    bool authenticated = true,
    String? idempotencyKey,
  }) =>
      client.request<dynamic>(
        'GET',
        '/api/v1/shipping/countries/${code}/payment-methods',
        query: query,
        body: body is JsonModel ? body.toJson() : body,
        headers: headers,
        authenticated: authenticated,
        idempotencyKey: idempotencyKey,
      );

  /// GET /api/v1/shipping/countries
  Future<ApiResponse<dynamic>> getApiV1ShippingCountries({
    Map<String, dynamic>? query,
    dynamic body,
    Map<String, String>? headers,
    bool authenticated = true,
    String? idempotencyKey,
  }) =>
      client.request<dynamic>(
        'GET',
        '/api/v1/shipping/countries',
        query: query,
        body: body is JsonModel ? body.toJson() : body,
        headers: headers,
        authenticated: authenticated,
        idempotencyKey: idempotencyKey,
      );

  /// GET /api/v1/shipping/governorates
  Future<ApiResponse<dynamic>> getApiV1ShippingGovernorates({
    Map<String, dynamic>? query,
    dynamic body,
    Map<String, String>? headers,
    bool authenticated = true,
    String? idempotencyKey,
  }) =>
      client.request<dynamic>(
        'GET',
        '/api/v1/shipping/governorates',
        query: query,
        body: body is JsonModel ? body.toJson() : body,
        headers: headers,
        authenticated: authenticated,
        idempotencyKey: idempotencyKey,
      );

  /// GET /api/v1/shipping/regions
  Future<ApiResponse<dynamic>> getApiV1ShippingRegions({
    Map<String, dynamic>? query,
    dynamic body,
    Map<String, String>? headers,
    bool authenticated = true,
    String? idempotencyKey,
  }) =>
      client.request<dynamic>(
        'GET',
        '/api/v1/shipping/regions',
        query: query,
        body: body is JsonModel ? body.toJson() : body,
        headers: headers,
        authenticated: authenticated,
        idempotencyKey: idempotencyKey,
      );

  /// GET /api/v1/wallets
  Future<ApiResponse<dynamic>> getApiV1Wallets({
    Map<String, dynamic>? query,
    dynamic body,
    Map<String, String>? headers,
    bool authenticated = true,
    String? idempotencyKey,
  }) =>
      client.request<dynamic>(
        'GET',
        '/api/v1/wallets',
        query: query,
        body: body is JsonModel ? body.toJson() : body,
        headers: headers,
        authenticated: authenticated,
        idempotencyKey: idempotencyKey,
      );

  /// POST /api/v1/webhooks/{provider}
  Future<ApiResponse<dynamic>> postApiV1WebhooksProvider({
    required String provider,
    Map<String, dynamic>? query,
    dynamic body,
    Map<String, String>? headers,
    bool authenticated = true,
    String? idempotencyKey,
  }) =>
      client.request<dynamic>(
        'POST',
        '/api/v1/webhooks/${provider}',
        query: query,
        body: body is JsonModel ? body.toJson() : body,
        headers: headers,
        authenticated: authenticated,
        idempotencyKey: idempotencyKey,
      );

  /// GET /api/v1/wishlist
  Future<ApiResponse<dynamic>> getApiV1Wishlist({
    Map<String, dynamic>? query,
    dynamic body,
    Map<String, String>? headers,
    bool authenticated = true,
    String? idempotencyKey,
  }) =>
      client.request<dynamic>(
        'GET',
        '/api/v1/wishlist',
        query: query,
        body: body is JsonModel ? body.toJson() : body,
        headers: headers,
        authenticated: authenticated,
        idempotencyKey: idempotencyKey,
      );

  /// POST /api/v1/wishlist
  Future<ApiResponse<dynamic>> postApiV1Wishlist({
    Map<String, dynamic>? query,
    dynamic body,
    Map<String, String>? headers,
    bool authenticated = true,
    String? idempotencyKey,
  }) =>
      client.request<dynamic>(
        'POST',
        '/api/v1/wishlist',
        query: query,
        body: body is JsonModel ? body.toJson() : body,
        headers: headers,
        authenticated: authenticated,
        idempotencyKey: idempotencyKey,
      );

  /// DELETE /api/v1/wishlist
  Future<ApiResponse<dynamic>> deleteApiV1Wishlist({
    Map<String, dynamic>? query,
    dynamic body,
    Map<String, String>? headers,
    bool authenticated = true,
    String? idempotencyKey,
  }) =>
      client.request<dynamic>(
        'DELETE',
        '/api/v1/wishlist',
        query: query,
        body: body is JsonModel ? body.toJson() : body,
        headers: headers,
        authenticated: authenticated,
        idempotencyKey: idempotencyKey,
      );

  /// POST /api/v1/admin/orders/{id}/returns
  Future<ApiResponse<dynamic>> postApiV1AdminOrdersIdReturns({
    required String id,
    Map<String, dynamic>? query,
    dynamic body,
    Map<String, String>? headers,
    bool authenticated = true,
    String? idempotencyKey,
  }) =>
      client.request<dynamic>(
        'POST',
        '/api/v1/admin/orders/${id}/returns',
        query: query,
        body: body is JsonModel ? body.toJson() : body,
        headers: headers,
        authenticated: authenticated,
        idempotencyKey: idempotencyKey,
      );

  /// GET /api/v1/admin/commerce/reconciliation
  Future<ApiResponse<dynamic>> getApiV1AdminCommerceReconciliation({
    Map<String, dynamic>? query,
    Map<String, String>? headers,
    bool authenticated = true,
  }) =>
      client.request<dynamic>(
        'GET',
        '/api/v1/admin/commerce/reconciliation',
        query: query,
        headers: headers,
        authenticated: authenticated,
      );
}
