import 'admin_models.dart';
import 'api_client.dart';
import 'models.dart';
import 'types.dart';

class LocaleQuery extends QueryModel {
  const LocaleQuery({this.locale});
  final AppLocale? locale;
  @override
  JsonMap toQuery() => {
        if (locale != null) 'locale': locale == AppLocale.ar ? 'ar' : 'en',
      };
}

class ProductReviewsQuery extends QueryModel {
  const ProductReviewsQuery({this.page = 1, this.limit = 10});
  final int page;
  final int limit;
  @override
  JsonMap toQuery() => {'page': page, 'limit': limit};
}

class PublicApiClient {
  const PublicApiClient(this._client);
  final EcommerceApiClient _client;

  Future<ApiResponse<StoreBrandingResponse>> storeBranding() =>
      _client.request<StoreBrandingResponse>(
        'GET',
        '/api/v1/store/branding',
        authenticated: false,
        decoder: StoreBrandingResponse.fromJson,
      );

  Future<ApiResponse<HealthStatus>> health() => _client.request<HealthStatus>(
        'GET',
        '/api/health',
        authenticated: false,
        decoder: HealthStatus.fromJson,
      );
  Future<ApiResponse<HealthStatus>> readiness() =>
      _client.request<HealthStatus>(
        'GET',
        '/api/health/ready',
        authenticated: false,
        decoder: HealthStatus.fromJson,
      );

  Future<ApiResponse<List<CatalogProduct>>> listProducts({
    CatalogQuery query = const CatalogQuery(),
  }) =>
      _client.request<List<CatalogProduct>>(
        'GET',
        '/api/v1/products',
        authenticated: false,
        queryModel: query,
        decoder: (data) => _decodeList(data, CatalogProduct.fromJson),
      );
  Future<ApiResponse<CatalogProduct>> getProduct(
    String idOrSlug, {
    AppLocale? locale,
  }) =>
      _client.request<CatalogProduct>(
        'GET',
        '/api/v1/products/$idOrSlug',
        authenticated: false,
        queryModel: LocaleQuery(locale: locale),
        decoder: CatalogProduct.fromJson,
      );
  Future<ApiResponse<List<CatalogTaxonomy>>> listCategories({
    AppLocale? locale,
  }) =>
      _client.request<List<CatalogTaxonomy>>(
        'GET',
        '/api/v1/categories',
        authenticated: false,
        queryModel: LocaleQuery(locale: locale),
        decoder: (data) => _decodeList(data, CatalogTaxonomy.fromJson),
      );
  Future<ApiResponse<List<CatalogTaxonomy>>> listBrands({AppLocale? locale}) =>
      _client.request<List<CatalogTaxonomy>>(
        'GET',
        '/api/v1/brands',
        authenticated: false,
        queryModel: LocaleQuery(locale: locale),
        decoder: (data) => _decodeList(data, CatalogTaxonomy.fromJson),
      );
  Future<ApiResponse<List<JsonMap>>> hero({AppLocale? locale}) =>
      _client.request<List<JsonMap>>(
        'GET',
        '/api/v1/hero',
        authenticated: false,
        queryModel: LocaleQuery(locale: locale),
        decoder: (data) => _decodeMaps(data),
      );
  Future<ApiResponse<JsonMap>> commerceCountry() => _client.request<JsonMap>(
        'GET',
        '/api/v1/commerce/country',
        authenticated: false,
        decoder: _decodeMap,
      );
  Future<ApiResponse<List<JsonMap>>> shippingCountries() =>
      _client.request<List<JsonMap>>(
        'GET',
        '/api/v1/shipping/countries',
        authenticated: false,
        decoder: (data) => _decodeMaps(data),
      );
  Future<ApiResponse<List<String>>> shippingGovernorates({
    required String country,
  }) =>
      _client.request<List<String>>(
        'GET',
        '/api/v1/shipping/governorates',
        authenticated: false,
        query: {'country': country},
        decoder: (data) => _decodeStrings(data),
      );
  Future<ApiResponse<List<JsonMap>>> shippingRegions({
    required String country,
  }) =>
      _client.request<List<JsonMap>>(
        'GET',
        '/api/v1/shipping/regions',
        authenticated: false,
        query: {'country': country},
        decoder: (data) => _decodeMaps(data),
      );
  Future<ApiResponse<JsonMap>> paymentMethods({required String countryCode}) =>
      _client.request<JsonMap>(
        'GET',
        '/api/v1/shipping/countries/$countryCode/payment-methods',
        authenticated: false,
        decoder: _decodeMap,
      );
  Future<ApiResponse<List<Review>>> productReviews(
    String productId, {
    ProductReviewsQuery query = const ProductReviewsQuery(),
  }) =>
      _client.request<List<Review>>(
        'GET',
        '/api/v1/products/$productId/reviews',
        authenticated: false,
        queryModel: query,
        decoder: (data) => _decodeList(data, Review.fromJson),
      );
}

class AuthApiClient {
  const AuthApiClient(this._client);
  final EcommerceApiClient _client;

  Future<ApiResponse<AuthSession>> signIn(SignInRequest request) =>
      _client.request<AuthSession>(
        'POST',
        '/api/auth/sign-in/email',
        authenticated: false,
        body: request,
        decoder: AuthSession.fromJson,
      );
  Future<ApiResponse<AuthSession>> signInAnonymous() =>
      _client.request<AuthSession>(
        'POST',
        '/api/auth/sign-in/anonymous',
        authenticated: false,
        decoder: AuthSession.fromJson,
      );
  Future<ApiResponse<AuthSession>> signUp(SignUpRequest request) =>
      _client.request<AuthSession>(
        'POST',
        '/api/auth/sign-up/email',
        authenticated: false,
        body: request,
        decoder: AuthSession.fromJson,
      );
  Future<ApiResponse<AuthSession>> session() => _client.request<AuthSession>(
        'GET',
        '/api/auth/get-session',
        decoder: AuthSession.fromJson,
      );
  Future<ApiResponse<dynamic>> signOut() =>
      _client.request<dynamic>('POST', '/api/auth/sign-out');
}

class PaymentsApiClient {
  const PaymentsApiClient(this._client);
  final EcommerceApiClient _client;

  Future<ApiResponse<JsonMap>> createPaymob(PaymobPaymentCreateRequest request) =>
      _client.request<JsonMap>(
        'POST',
        '/api/v1/payments/paymob/create',
        body: request,
        decoder: _decodeMap,
      );

  Future<ApiResponse<JsonMap>> paymobStatus(String paymentId) =>
      _client.request<JsonMap>(
        'GET',
        '/api/v1/payments/paymob/$paymentId',
        decoder: _decodeMap,
      );
}

class CheckoutApiClient {
  const CheckoutApiClient(this._client);
  final EcommerceApiClient _client;

  Future<ApiResponse<CheckoutQuote>> quote(CheckoutQuoteRequest request) =>
      _client.request<CheckoutQuote>(
        'POST',
        '/api/v1/checkout/quote',
        body: request,
        decoder: CheckoutQuote.fromJson,
      );
}

class CartApiClient {
  const CartApiClient(this._client);
  final EcommerceApiClient _client;

  Future<ApiResponse<CartModel>> get({String? cartId}) =>
      _client.request<CartModel>(
        'GET',
        '/api/v1/cart',
        headers: {if (cartId != null) 'x-cart-id': cartId},
        decoder: CartModel.fromJson,
      );
  Future<ApiResponse<CartModel>> add(CartItemInput request, {String? cartId}) =>
      _client.request<CartModel>(
        'POST',
        '/api/v1/cart',
        body: request,
        headers: {if (cartId != null) 'x-cart-id': cartId},
        decoder: CartModel.fromJson,
      );
  Future<ApiResponse<CartModel>> update(
    CartItemInput request, {
    String? cartId,
  }) =>
      _client.request<CartModel>(
        'PATCH',
        '/api/v1/cart',
        body: request,
        headers: {if (cartId != null) 'x-cart-id': cartId},
        decoder: CartModel.fromJson,
      );
  Future<ApiResponse<JsonMap>> clear({String? cartId}) =>
      _client.request<JsonMap>(
        'DELETE',
        '/api/v1/cart',
        headers: {if (cartId != null) 'x-cart-id': cartId},
        decoder: _decodeMap,
      );
  Future<ApiResponse<CartModel>> merge(CartMergeRequest request) =>
      _client.request<CartModel>(
        'POST',
        '/api/v1/cart/merge',
        body: request,
        decoder: CartModel.fromJson,
      );
}

class AccountApiClient {
  const AccountApiClient(this._client);
  final EcommerceApiClient _client;

  Future<ApiResponse<AuthUser>> profile() => _client.request<AuthUser>(
        'GET',
        '/api/v1/account/profile',
        decoder: AuthUser.fromJson,
      );
  Future<ApiResponse<AuthUser>> updateProfile(ProfilePatch request) =>
      _client.request<AuthUser>(
        'PATCH',
        '/api/v1/account/profile',
        body: request,
        decoder: AuthUser.fromJson,
      );
  Future<ApiResponse<JsonMap>> settings(AccountSettingsPatch request) =>
      _client.request<JsonMap>(
        'PATCH',
        '/api/v1/account/settings',
        body: request,
        decoder: _decodeMap,
      );
  Future<ApiResponse<JsonMap>> security(AccountSecurityRequest request) =>
      _client.request<JsonMap>(
        'POST',
        '/api/v1/account/security',
        body: request,
        decoder: _decodeMap,
      );
  Future<ApiResponse<List<SessionSummary>>> sessions() =>
      _client.request<List<SessionSummary>>(
        'GET',
        '/api/v1/account/sessions',
        decoder: (data) => _decodeList(data, SessionSummary.fromJson),
      );
  Future<ApiResponse<JsonMap>> revokeSession(String sessionId) =>
      _client.request<JsonMap>(
        'DELETE',
        '/api/v1/account/sessions',
        body: SessionRevokeRequest(sessionId: sessionId),
        decoder: _decodeMap,
      );
  Future<ApiResponse<List<OrderModel>>> orders({
    PageQuery query = const PageQuery(),
  }) =>
      _client.request<List<OrderModel>>(
        'GET',
        '/api/v1/account/orders',
        queryModel: query,
        decoder: (data) => _decodeList(data, OrderModel.fromJson),
      );
  Future<ApiResponse<OrderModel>> order(String id) =>
      _client.request<OrderModel>(
        'GET',
        '/api/v1/account/orders/$id',
        decoder: OrderModel.fromJson,
      );
  Future<ApiResponse<OrderModel>> cancelOrder(String id, {String? reason}) =>
      _client.request<OrderModel>(
        'POST',
        '/api/v1/account/orders/$id/cancel',
        body: reason == null ? null : OrderCancelRequest(reason: reason),
        decoder: OrderModel.fromJson,
      );
  Future<ApiResponse<List<Review>>> reviews({
    PageQuery query = const PageQuery(),
  }) =>
      _client.request<List<Review>>(
        'GET',
        '/api/v1/account/reviews',
        queryModel: query,
        decoder: (data) => _decodeList(data, Review.fromJson),
      );
  Future<ApiResponse<JsonMap>> receipt(String orderId) =>
      _client.request<JsonMap>(
        'GET',
        '/api/v1/account/orders/$orderId/receipt',
        decoder: _decodeMap,
      );

  Future<ApiResponse<JsonMap>> requestReturn(
    String orderId,
    CustomerReturnRequest request,
  ) =>
      _client.request<JsonMap>(
        'POST',
        '/api/v1/account/orders/$orderId/returns',
        body: request,
        idempotencyKey: request.idempotencyKey,
        decoder: _decodeMap,
      );

  Future<ApiResponse<Review>> createReview(ReviewInput request) =>
      _client.request<Review>(
        'POST',
        '/api/v1/account/reviews',
        body: request,
        decoder: Review.fromJson,
      );
  Future<ApiResponse<Review>> review(String id) => _client.request<Review>(
        'GET',
        '/api/v1/account/reviews/$id',
        decoder: Review.fromJson,
      );
  Future<ApiResponse<JsonMap>> deleteReview(String id) =>
      _client.request<JsonMap>(
        'DELETE',
        '/api/v1/account/reviews/$id',
        decoder: _decodeMap,
      );
}

class AddressesApiClient {
  const AddressesApiClient(this._client);
  final EcommerceApiClient _client;

  Future<ApiResponse<List<Address>>> list({String? id}) =>
      _client.request<List<Address>>(
        'GET',
        '/api/v1/addresses',
        query: {if (id != null) 'id': id},
        decoder: (data) => _decodeList(data, Address.fromJson),
      );
  Future<ApiResponse<Address>> create(AddressCreateRequest request) =>
      _client.request<Address>(
        'POST',
        '/api/v1/addresses',
        body: request,
        decoder: Address.fromJson,
      );
  Future<ApiResponse<Address>> update(
    String id,
    AddressUpdateRequest request,
  ) =>
      _client.request<Address>(
        'PATCH',
        '/api/v1/addresses/$id',
        body: request,
        decoder: Address.fromJson,
      );
  Future<ApiResponse<JsonMap>> delete(String id) => _client.request<JsonMap>(
        'DELETE',
        '/api/v1/addresses/$id',
        decoder: _decodeMap,
      );
  Future<ApiResponse<Address>> setDefault(
    String id,
    DefaultAddressRequest request,
  ) =>
      _client.request<Address>(
        'PATCH',
        '/api/v1/addresses/$id/default',
        body: request,
        decoder: Address.fromJson,
      );
}

class OrdersApiClient {
  const OrdersApiClient(this._client);
  final EcommerceApiClient _client;

  Future<ApiResponse<OrderModel>> create(
    OrderInput request, {
    String? idempotencyKey,
  }) =>
      _client.request<OrderModel>(
        'POST',
        '/api/v1/orders',
        body: request,
        idempotencyKey: idempotencyKey,
        decoder: OrderModel.fromJson,
      );
  Future<ApiResponse<List<OrderModel>>> list({
    PageQuery query = const PageQuery(),
  }) =>
      _client.request<List<OrderModel>>(
        'GET',
        '/api/v1/orders',
        queryModel: query,
        decoder: (data) => _decodeList(data, OrderModel.fromJson),
      );
  Future<ApiResponse<OrderModel>> get(String id) => _client.request<OrderModel>(
        'GET',
        '/api/v1/orders/$id',
        decoder: OrderModel.fromJson,
      );
}

class AdminApiClient {
  const AdminApiClient(this._client);
  final EcommerceApiClient _client;

  Future<ApiResponse<List<CatalogProduct>>> products({
    AdminPageQuery query = const AdminPageQuery(),
  }) =>
      _client.request<List<CatalogProduct>>(
        'GET',
        '/api/v1/admin/products',
        queryModel: query,
        decoder: (data) => _decodeList(data, CatalogProduct.fromJson),
      );
  Future<ApiResponse<CatalogProduct>> createProduct(
    AdminProductCreateRequest request,
  ) =>
      _client.request<CatalogProduct>(
        'POST',
        '/api/v1/admin/products',
        body: request,
        decoder: CatalogProduct.fromJson,
      );
  Future<ApiResponse<CatalogProduct>> updateProduct(
    AdminProductUpdateRequest request,
  ) =>
      _client.request<CatalogProduct>(
        'PATCH',
        '/api/v1/admin/products',
        body: request,
        decoder: CatalogProduct.fromJson,
      );
  Future<ApiResponse<JsonMap>> deleteProduct(String id) =>
      _client.request<JsonMap>(
        'DELETE',
        '/api/v1/admin/products',
        query: {'id': id},
        decoder: _decodeMap,
      );

  Future<ApiResponse<List<CatalogTaxonomy>>> categories({
    AdminPageQuery query = const AdminPageQuery(),
  }) =>
      _client.request<List<CatalogTaxonomy>>(
        'GET',
        '/api/v1/admin/categories',
        queryModel: query,
        decoder: (data) => _decodeList(data, CatalogTaxonomy.fromJson),
      );
  Future<ApiResponse<CatalogTaxonomy>> createCategory(
    TaxonomyCreateRequest request,
  ) =>
      _client.request<CatalogTaxonomy>(
        'POST',
        '/api/v1/admin/categories',
        body: request,
        decoder: CatalogTaxonomy.fromJson,
      );
  Future<ApiResponse<CatalogTaxonomy>> updateCategory(
    String id,
    TaxonomyUpdateRequest request,
  ) =>
      _client.request<CatalogTaxonomy>(
        'PATCH',
        '/api/v1/admin/categories/$id',
        body: request,
        decoder: CatalogTaxonomy.fromJson,
      );
  Future<ApiResponse<JsonMap>> deleteCategory(String id) =>
      _client.request<JsonMap>(
        'DELETE',
        '/api/v1/admin/categories/$id',
        decoder: _decodeMap,
      );

  Future<ApiResponse<List<CatalogTaxonomy>>> brands({
    AdminPageQuery query = const AdminPageQuery(),
  }) =>
      _client.request<List<CatalogTaxonomy>>(
        'GET',
        '/api/v1/admin/brands',
        queryModel: query,
        decoder: (data) => _decodeList(data, CatalogTaxonomy.fromJson),
      );
  Future<ApiResponse<CatalogTaxonomy>> createBrand(
    TaxonomyCreateRequest request,
  ) =>
      _client.request<CatalogTaxonomy>(
        'POST',
        '/api/v1/admin/brands',
        body: request,
        decoder: CatalogTaxonomy.fromJson,
      );
  Future<ApiResponse<CatalogTaxonomy>> updateBrand(
    String id,
    TaxonomyUpdateRequest request,
  ) =>
      _client.request<CatalogTaxonomy>(
        'PATCH',
        '/api/v1/admin/brands/$id',
        body: request,
        decoder: CatalogTaxonomy.fromJson,
      );
  Future<ApiResponse<JsonMap>> deleteBrand(String id) =>
      _client.request<JsonMap>(
        'DELETE',
        '/api/v1/admin/brands/$id',
        decoder: _decodeMap,
      );

  Future<ApiResponse<List<JsonMap>>> coupons({
    AdminPageQuery query = const AdminPageQuery(),
  }) =>
      _client.request<List<JsonMap>>(
        'GET',
        '/api/v1/admin/coupons',
        queryModel: query,
        decoder: (data) => _decodeMaps(data),
      );
  Future<ApiResponse<JsonMap>> createCoupon(CouponRequest request) =>
      _client.request<JsonMap>(
        'POST',
        '/api/v1/admin/coupons',
        body: request,
        decoder: _decodeMap,
      );
  Future<ApiResponse<JsonMap>> updateCoupon(String id, CouponRequest request) =>
      _client.request<JsonMap>(
        'PATCH',
        '/api/v1/admin/coupons/$id',
        body: request,
        decoder: _decodeMap,
      );
  Future<ApiResponse<JsonMap>> deleteCoupon(String id) =>
      _client.request<JsonMap>(
        'DELETE',
        '/api/v1/admin/coupons/$id',
        decoder: _decodeMap,
      );

  Future<ApiResponse<List<JsonMap>>> tags({
    AdminPageQuery query = const AdminPageQuery(),
  }) =>
      _client.request<List<JsonMap>>(
        'GET',
        '/api/v1/admin/tags',
        queryModel: query,
        decoder: (data) => _decodeMaps(data),
      );
  Future<ApiResponse<JsonMap>> createTag(TagRequest request) =>
      _client.request<JsonMap>(
        'POST',
        '/api/v1/admin/tags',
        body: request,
        decoder: _decodeMap,
      );
  Future<ApiResponse<JsonMap>> updateTag(String id, TagRequest request) =>
      _client.request<JsonMap>(
        'PATCH',
        '/api/v1/admin/tags/$id',
        body: request,
        decoder: _decodeMap,
      );
  Future<ApiResponse<JsonMap>> deleteTag(String id) => _client.request<JsonMap>(
        'DELETE',
        '/api/v1/admin/tags/$id',
        decoder: _decodeMap,
      );

  Future<ApiResponse<JsonMap>> adjustInventory(InventoryAdjustment request) =>
      _client.request<JsonMap>(
        'POST',
        '/api/v1/admin/inventory',
        body: request,
        decoder: _decodeMap,
      );
  Future<ApiResponse<JsonMap>> transitionOrder(
    OrderTransitionRequest request,
  ) =>
      _client.request<JsonMap>(
        'PATCH',
        '/api/v1/admin/orders',
        body: request,
        decoder: _decodeMap,
      );
  Future<ApiResponse<JsonMap>> updateShipment(
    String orderId,
    ShipmentUpdateRequest request,
  ) =>
      _client.request<JsonMap>(
        'PATCH',
        '/api/v1/admin/orders/$orderId/shipments',
        body: request,
        decoder: _decodeMap,
      );

  Future<ApiResponse<JsonMap>> transitionOrderById(
    String id,
    OrderTransitionRequest request,
  ) =>
      _client.request<JsonMap>(
        'PATCH',
        '/api/v1/admin/orders/$id',
        body: request,
        decoder: _decodeMap,
      );
  Future<ApiResponse<JsonMap>> createReturnAndRefund(
    String orderId,
    ReturnRefundRequest request,
  ) =>
      _client.request<JsonMap>(
        'POST',
        '/api/v1/admin/orders/$orderId/returns',
        body: request,
        idempotencyKey: request.idempotencyKey,
        decoder: _decodeMap,
      );
  Future<ApiResponse<JsonMap>> reconcileCommerce({String? orderId}) =>
      _client.request<JsonMap>(
        'GET',
        '/api/v1/admin/commerce/reconciliation',
        query: {if (orderId != null) 'orderId': orderId},
        decoder: _decodeMap,
      );
  Future<ApiResponse<JsonMap>> moderateReview(
    ReviewModerationRequest request,
  ) =>
      _client.request<JsonMap>(
        'PATCH',
        '/api/v1/admin/reviews',
        body: request,
        decoder: _decodeMap,
      );
  Future<ApiResponse<JsonMap>> moderateReviewById(String id, String status) =>
      _client.request<JsonMap>(
        'PATCH',
        '/api/v1/admin/reviews/$id',
        body: ReviewModerationRequest(reviewId: id, status: status),
        decoder: _decodeMap,
      );
  Future<ApiResponse<JsonMap>> updateUser(
    String id,
    AdminUserUpdateRequest request,
  ) =>
      _client.request<JsonMap>(
        'PATCH',
        '/api/v1/admin/users/$id',
        body: request,
        decoder: _decodeMap,
      );
  Future<ApiResponse<JsonMap>> createRole(RoleCreateRequest request) =>
      _client.request<JsonMap>(
        'POST',
        '/api/v1/admin/roles',
        body: request,
        decoder: _decodeMap,
      );
  Future<ApiResponse<JsonMap>> paymentProvider(
    PaymentProviderSettingsRequest request,
  ) =>
      _client.request<JsonMap>(
        'PUT',
        '/api/v1/admin/payment-providers',
        body: request,
        decoder: _decodeMap,
      );
  Future<ApiResponse<JsonMap>> updatePaymentProvider(
    String provider,
    PaymentProviderSettingsRequest request,
  ) =>
      _client.request<JsonMap>(
        'PATCH',
        '/api/v1/admin/payment-providers/$provider',
        body: request,
        decoder: _decodeMap,
      );
  Future<ApiResponse<JsonMap>> testPaymentProvider(
    String provider,
    JsonModel request,
  ) =>
      _client.request<JsonMap>(
        'POST',
        '/api/v1/admin/payment-providers/$provider/test',
        body: request,
        decoder: _decodeMap,
      );
  Future<ApiResponse<JsonMap>> createShippingZone(
    ShippingZoneRequest request,
  ) =>
      _client.request<JsonMap>(
        'POST',
        '/api/v1/admin/shipping',
        body: request,
        decoder: _decodeMap,
      );
  Future<ApiResponse<JsonMap>> updateShippingZone(
    String id,
    ShippingZoneRequest request,
  ) =>
      _client.request<JsonMap>(
        'PATCH',
        '/api/v1/admin/shipping/$id',
        body: request,
        decoder: _decodeMap,
      );
  Future<ApiResponse<JsonMap>> createShippingCountry(
    ShippingCountryCreateRequest request,
  ) =>
      _client.request<JsonMap>(
        'POST',
        '/api/v1/admin/shipping-countries',
        body: request,
        decoder: _decodeMap,
      );
  Future<ApiResponse<JsonMap>> createShippingGovernorate(
    ShippingGovernorateCreateRequest request,
  ) =>
      _client.request<JsonMap>(
        'POST',
        '/api/v1/admin/shipping-governorates',
        body: request,
        decoder: _decodeMap,
      );
  Future<ApiResponse<JsonMap>> createHeroSlide(
    HeroSlideCreateRequest request,
  ) =>
      _client.request<JsonMap>(
        'POST',
        '/api/v1/admin/hero-slides',
        body: request,
        decoder: _decodeMap,
      );
  Future<ApiResponse<JsonMap>> reorderHeroSlides(
    HeroSlideReorderRequest request,
  ) =>
      _client.request<JsonMap>(
        'POST',
        '/api/v1/admin/hero-slides/reorder',
        body: request,
        decoder: _decodeMap,
      );
  Future<ApiResponse<JsonMap>> updateContact(
    String id,
    ContactStatusUpdateRequest request,
  ) =>
      _client.request<JsonMap>(
        'PATCH',
        '/api/v1/admin/contact/$id',
        body: request,
        decoder: _decodeMap,
      );
  Future<ApiResponse<JsonMap>> settings(JsonModel request) =>
      _client.request<JsonMap>(
        'PATCH',
        '/api/v1/admin/settings',
        body: request,
        decoder: _decodeMap,
      );
}

class PageQuery extends QueryModel {
  const PageQuery({this.page = 1, this.limit = 10});
  final int page;
  final int limit;
  @override
  JsonMap toQuery() => {'page': page, 'limit': limit};
}

class CartMergeRequest extends JsonModel {
  const CartMergeRequest({this.guestCartId});
  final String? guestCartId;
  @override
  JsonMap toJson() => {if (guestCartId != null) 'guestCartId': guestCartId};
}

class SessionRevokeRequest extends JsonModel {
  const SessionRevokeRequest({required this.sessionId});
  final String sessionId;
  @override
  JsonMap toJson() => {'sessionId': sessionId};
}

class OrderCancelRequest extends JsonModel {
  const OrderCancelRequest({this.reason});
  final String? reason;
  @override
  JsonMap toJson() => {if (reason != null) 'reason': reason};
}

JsonMap _decodeMap(dynamic data) => Map<String, dynamic>.from(data as Map);
List<T> _decodeList<T>(dynamic data, T Function(dynamic) decoder) =>
    (data is List ? data : const <dynamic>[]).map(decoder).toList();
List<JsonMap> _decodeMaps(dynamic data) =>
    (data is List ? data : const <dynamic>[])
        .whereType<Map>()
        .map((item) => Map<String, dynamic>.from(item))
        .toList();
List<String> _decodeStrings(dynamic data) =>
    (data is List ? data : const <dynamic>[]).map((item) => '$item').toList();
