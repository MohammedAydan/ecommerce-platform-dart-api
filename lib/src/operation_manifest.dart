class ApiOperation {
  const ApiOperation({
    required this.method,
    required this.path,
    required this.sourceFile,
  });
  final String method;
  final String path;
  final String sourceFile;
}

const backendSourceCommit = 'a2a201bfc3fffec9ba754fbbfe37996a911e5332';

const ecommercePlatformOperations = <ApiOperation>[
  ApiOperation(
    method: 'GET',
    path: '/api/auth/{...auth}',
    sourceFile: 'app/api/auth/[...auth]/route.ts',
  ),
  ApiOperation(
    method: 'POST',
    path: '/api/auth/{...auth}',
    sourceFile: 'app/api/auth/[...auth]/route.ts',
  ),
  ApiOperation(
    method: 'GET',
    path: '/api/health/ready',
    sourceFile: 'app/api/health/ready/route.ts',
  ),
  ApiOperation(
    method: 'GET',
    path: '/api/health',
    sourceFile: 'app/api/health/route.ts',
  ),
  ApiOperation(
    method: 'POST',
    path: '/api/v1/account/orders/{id}/cancel',
    sourceFile: 'app/api/v1/account/orders/[id]/cancel/route.ts',
  ),
  ApiOperation(
    method: 'GET',
    path: '/api/v1/account/orders/{id}',
    sourceFile: 'app/api/v1/account/orders/[id]/route.ts',
  ),
  ApiOperation(
    method: 'POST',
    path: '/api/v1/account/orders/{id}',
    sourceFile: 'app/api/v1/account/orders/[id]/route.ts',
  ),
  ApiOperation(
    method: 'GET',
    path: '/api/v1/account/profile',
    sourceFile: 'app/api/v1/account/profile/route.ts',
  ),
  ApiOperation(
    method: 'PATCH',
    path: '/api/v1/account/profile',
    sourceFile: 'app/api/v1/account/profile/route.ts',
  ),
  ApiOperation(
    method: 'GET',
    path: '/api/v1/account/reviews/{id}',
    sourceFile: 'app/api/v1/account/reviews/[id]/route.ts',
  ),
  ApiOperation(
    method: 'DELETE',
    path: '/api/v1/account/reviews/{id}',
    sourceFile: 'app/api/v1/account/reviews/[id]/route.ts',
  ),
  ApiOperation(
    method: 'GET',
    path: '/api/v1/account/reviews',
    sourceFile: 'app/api/v1/account/reviews/route.ts',
  ),
  ApiOperation(
    method: 'POST',
    path: '/api/v1/account/reviews',
    sourceFile: 'app/api/v1/account/reviews/route.ts',
  ),
  ApiOperation(
    method: 'POST',
    path: '/api/v1/account/security',
    sourceFile: 'app/api/v1/account/security/route.ts',
  ),
  ApiOperation(
    method: 'GET',
    path: '/api/v1/account/sessions',
    sourceFile: 'app/api/v1/account/sessions/route.ts',
  ),
  ApiOperation(
    method: 'DELETE',
    path: '/api/v1/account/sessions',
    sourceFile: 'app/api/v1/account/sessions/route.ts',
  ),
  ApiOperation(
    method: 'GET',
    path: '/api/v1/account/settings',
    sourceFile: 'app/api/v1/account/settings/route.ts',
  ),
  ApiOperation(
    method: 'PATCH',
    path: '/api/v1/account/settings',
    sourceFile: 'app/api/v1/account/settings/route.ts',
  ),
  ApiOperation(
    method: 'PUT',
    path: '/api/v1/addresses/{id}/default',
    sourceFile: 'app/api/v1/addresses/[id]/default/route.ts',
  ),
  ApiOperation(
    method: 'PATCH',
    path: '/api/v1/addresses/{id}',
    sourceFile: 'app/api/v1/addresses/[id]/route.ts',
  ),
  ApiOperation(
    method: 'DELETE',
    path: '/api/v1/addresses/{id}',
    sourceFile: 'app/api/v1/addresses/[id]/route.ts',
  ),
  ApiOperation(
    method: 'GET',
    path: '/api/v1/addresses',
    sourceFile: 'app/api/v1/addresses/route.ts',
  ),
  ApiOperation(
    method: 'POST',
    path: '/api/v1/addresses',
    sourceFile: 'app/api/v1/addresses/route.ts',
  ),
  ApiOperation(
    method: 'DELETE',
    path: '/api/v1/addresses',
    sourceFile: 'app/api/v1/addresses/route.ts',
  ),
  ApiOperation(
    method: 'GET',
    path: '/api/v1/admin/audit-logs',
    sourceFile: 'app/api/v1/admin/audit-logs/route.ts',
  ),
  ApiOperation(
    method: 'PATCH',
    path: '/api/v1/admin/brands/{id}',
    sourceFile: 'app/api/v1/admin/brands/[id]/route.ts',
  ),
  ApiOperation(
    method: 'DELETE',
    path: '/api/v1/admin/brands/{id}',
    sourceFile: 'app/api/v1/admin/brands/[id]/route.ts',
  ),
  ApiOperation(
    method: 'GET',
    path: '/api/v1/admin/brands',
    sourceFile: 'app/api/v1/admin/brands/route.ts',
  ),
  ApiOperation(
    method: 'POST',
    path: '/api/v1/admin/brands',
    sourceFile: 'app/api/v1/admin/brands/route.ts',
  ),
  ApiOperation(
    method: 'PATCH',
    path: '/api/v1/admin/categories/{id}',
    sourceFile: 'app/api/v1/admin/categories/[id]/route.ts',
  ),
  ApiOperation(
    method: 'DELETE',
    path: '/api/v1/admin/categories/{id}',
    sourceFile: 'app/api/v1/admin/categories/[id]/route.ts',
  ),
  ApiOperation(
    method: 'GET',
    path: '/api/v1/admin/categories',
    sourceFile: 'app/api/v1/admin/categories/route.ts',
  ),
  ApiOperation(
    method: 'POST',
    path: '/api/v1/admin/categories',
    sourceFile: 'app/api/v1/admin/categories/route.ts',
  ),
  ApiOperation(
    method: 'PATCH',
    path: '/api/v1/admin/contact/{id}',
    sourceFile: 'app/api/v1/admin/contact/[id]/route.ts',
  ),
  ApiOperation(
    method: 'GET',
    path: '/api/v1/admin/contact',
    sourceFile: 'app/api/v1/admin/contact/route.ts',
  ),
  ApiOperation(
    method: 'POST',
    path: '/api/v1/admin/coupons/{id}/reset',
    sourceFile: 'app/api/v1/admin/coupons/[id]/reset/route.ts',
  ),
  ApiOperation(
    method: 'PATCH',
    path: '/api/v1/admin/coupons/{id}',
    sourceFile: 'app/api/v1/admin/coupons/[id]/route.ts',
  ),
  ApiOperation(
    method: 'DELETE',
    path: '/api/v1/admin/coupons/{id}',
    sourceFile: 'app/api/v1/admin/coupons/[id]/route.ts',
  ),
  ApiOperation(
    method: 'GET',
    path: '/api/v1/admin/coupons',
    sourceFile: 'app/api/v1/admin/coupons/route.ts',
  ),
  ApiOperation(
    method: 'POST',
    path: '/api/v1/admin/coupons',
    sourceFile: 'app/api/v1/admin/coupons/route.ts',
  ),
  ApiOperation(
    method: 'GET',
    path: '/api/v1/admin/customers',
    sourceFile: 'app/api/v1/admin/customers/route.ts',
  ),
  ApiOperation(
    method: 'GET',
    path: '/api/v1/admin/dashboard',
    sourceFile: 'app/api/v1/admin/dashboard/route.ts',
  ),
  ApiOperation(
    method: 'POST',
    path: '/api/v1/admin/hero-slides/{id}/duplicate',
    sourceFile: 'app/api/v1/admin/hero-slides/[id]/duplicate/route.ts',
  ),
  ApiOperation(
    method: 'GET',
    path: '/api/v1/admin/hero-slides/{id}',
    sourceFile: 'app/api/v1/admin/hero-slides/[id]/route.ts',
  ),
  ApiOperation(
    method: 'PATCH',
    path: '/api/v1/admin/hero-slides/{id}',
    sourceFile: 'app/api/v1/admin/hero-slides/[id]/route.ts',
  ),
  ApiOperation(
    method: 'DELETE',
    path: '/api/v1/admin/hero-slides/{id}',
    sourceFile: 'app/api/v1/admin/hero-slides/[id]/route.ts',
  ),
  ApiOperation(
    method: 'PATCH',
    path: '/api/v1/admin/hero-slides/reorder',
    sourceFile: 'app/api/v1/admin/hero-slides/reorder/route.ts',
  ),
  ApiOperation(
    method: 'GET',
    path: '/api/v1/admin/hero-slides',
    sourceFile: 'app/api/v1/admin/hero-slides/route.ts',
  ),
  ApiOperation(
    method: 'POST',
    path: '/api/v1/admin/hero-slides',
    sourceFile: 'app/api/v1/admin/hero-slides/route.ts',
  ),
  ApiOperation(
    method: 'GET',
    path: '/api/v1/admin/inventory',
    sourceFile: 'app/api/v1/admin/inventory/route.ts',
  ),
  ApiOperation(
    method: 'PATCH',
    path: '/api/v1/admin/inventory',
    sourceFile: 'app/api/v1/admin/inventory/route.ts',
  ),
  ApiOperation(
    method: 'GET',
    path: '/api/v1/admin/orders/{id}',
    sourceFile: 'app/api/v1/admin/orders/[id]/route.ts',
  ),
  ApiOperation(
    method: 'PATCH',
    path: '/api/v1/admin/orders/{id}',
    sourceFile: 'app/api/v1/admin/orders/[id]/route.ts',
  ),
  ApiOperation(
    method: 'POST',
    path: '/api/v1/admin/orders/{id}/returns',
    sourceFile: 'app/api/v1/admin/orders/[id]/returns/route.ts',
  ),
  ApiOperation(
    method: 'GET',
    path: '/api/v1/admin/commerce/reconciliation',
    sourceFile: 'app/api/v1/admin/commerce/reconciliation/route.ts',
  ),
  ApiOperation(
    method: 'GET',
    path: '/api/v1/admin/orders',
    sourceFile: 'app/api/v1/admin/orders/route.ts',
  ),
  ApiOperation(
    method: 'PATCH',
    path: '/api/v1/admin/orders',
    sourceFile: 'app/api/v1/admin/orders/route.ts',
  ),
  ApiOperation(
    method: 'PATCH',
    path: '/api/v1/admin/payment-providers/{provider}',
    sourceFile: 'app/api/v1/admin/payment-providers/[provider]/route.ts',
  ),
  ApiOperation(
    method: 'POST',
    path: '/api/v1/admin/payment-providers/{provider}/test',
    sourceFile: 'app/api/v1/admin/payment-providers/[provider]/test/route.ts',
  ),
  ApiOperation(
    method: 'GET',
    path: '/api/v1/admin/payment-providers',
    sourceFile: 'app/api/v1/admin/payment-providers/route.ts',
  ),
  ApiOperation(
    method: 'POST',
    path: '/api/v1/admin/payment-providers',
    sourceFile: 'app/api/v1/admin/payment-providers/route.ts',
  ),
  ApiOperation(
    method: 'GET',
    path: '/api/v1/admin/payments',
    sourceFile: 'app/api/v1/admin/payments/route.ts',
  ),
  ApiOperation(
    method: 'PATCH',
    path: '/api/v1/admin/price-lists/{id}',
    sourceFile: 'app/api/v1/admin/price-lists/[id]/route.ts',
  ),
  ApiOperation(
    method: 'DELETE',
    path: '/api/v1/admin/price-lists/{id}',
    sourceFile: 'app/api/v1/admin/price-lists/[id]/route.ts',
  ),
  ApiOperation(
    method: 'GET',
    path: '/api/v1/admin/price-lists',
    sourceFile: 'app/api/v1/admin/price-lists/route.ts',
  ),
  ApiOperation(
    method: 'POST',
    path: '/api/v1/admin/price-lists',
    sourceFile: 'app/api/v1/admin/price-lists/route.ts',
  ),
  ApiOperation(
    method: 'GET',
    path: '/api/v1/admin/products',
    sourceFile: 'app/api/v1/admin/products/route.ts',
  ),
  ApiOperation(
    method: 'POST',
    path: '/api/v1/admin/products',
    sourceFile: 'app/api/v1/admin/products/route.ts',
  ),
  ApiOperation(
    method: 'PATCH',
    path: '/api/v1/admin/products',
    sourceFile: 'app/api/v1/admin/products/route.ts',
  ),
  ApiOperation(
    method: 'DELETE',
    path: '/api/v1/admin/products',
    sourceFile: 'app/api/v1/admin/products/route.ts',
  ),
  ApiOperation(
    method: 'PATCH',
    path: '/api/v1/admin/reviews/{id}',
    sourceFile: 'app/api/v1/admin/reviews/[id]/route.ts',
  ),
  ApiOperation(
    method: 'DELETE',
    path: '/api/v1/admin/reviews/{id}',
    sourceFile: 'app/api/v1/admin/reviews/[id]/route.ts',
  ),
  ApiOperation(
    method: 'GET',
    path: '/api/v1/admin/reviews',
    sourceFile: 'app/api/v1/admin/reviews/route.ts',
  ),
  ApiOperation(
    method: 'PATCH',
    path: '/api/v1/admin/reviews',
    sourceFile: 'app/api/v1/admin/reviews/route.ts',
  ),
  ApiOperation(
    method: 'GET',
    path: '/api/v1/admin/roles',
    sourceFile: 'app/api/v1/admin/roles/route.ts',
  ),
  ApiOperation(
    method: 'POST',
    path: '/api/v1/admin/roles',
    sourceFile: 'app/api/v1/admin/roles/route.ts',
  ),
  ApiOperation(
    method: 'GET',
    path: '/api/v1/admin/settings',
    sourceFile: 'app/api/v1/admin/settings/route.ts',
  ),
  ApiOperation(
    method: 'POST',
    path: '/api/v1/admin/settings',
    sourceFile: 'app/api/v1/admin/settings/route.ts',
  ),
  ApiOperation(
    method: 'PATCH',
    path: '/api/v1/admin/shipping/{id}',
    sourceFile: 'app/api/v1/admin/shipping/[id]/route.ts',
  ),
  ApiOperation(
    method: 'DELETE',
    path: '/api/v1/admin/shipping/{id}',
    sourceFile: 'app/api/v1/admin/shipping/[id]/route.ts',
  ),
  ApiOperation(
    method: 'GET',
    path: '/api/v1/admin/shipping',
    sourceFile: 'app/api/v1/admin/shipping/route.ts',
  ),
  ApiOperation(
    method: 'POST',
    path: '/api/v1/admin/shipping',
    sourceFile: 'app/api/v1/admin/shipping/route.ts',
  ),
  ApiOperation(
    method: 'PATCH',
    path: '/api/v1/admin/shipping-countries/{id}',
    sourceFile: 'app/api/v1/admin/shipping-countries/[id]/route.ts',
  ),
  ApiOperation(
    method: 'DELETE',
    path: '/api/v1/admin/shipping-countries/{id}',
    sourceFile: 'app/api/v1/admin/shipping-countries/[id]/route.ts',
  ),
  ApiOperation(
    method: 'GET',
    path: '/api/v1/admin/shipping-countries',
    sourceFile: 'app/api/v1/admin/shipping-countries/route.ts',
  ),
  ApiOperation(
    method: 'POST',
    path: '/api/v1/admin/shipping-countries',
    sourceFile: 'app/api/v1/admin/shipping-countries/route.ts',
  ),
  ApiOperation(
    method: 'PATCH',
    path: '/api/v1/admin/shipping-governorates/{id}',
    sourceFile: 'app/api/v1/admin/shipping-governorates/[id]/route.ts',
  ),
  ApiOperation(
    method: 'DELETE',
    path: '/api/v1/admin/shipping-governorates/{id}',
    sourceFile: 'app/api/v1/admin/shipping-governorates/[id]/route.ts',
  ),
  ApiOperation(
    method: 'GET',
    path: '/api/v1/admin/shipping-governorates',
    sourceFile: 'app/api/v1/admin/shipping-governorates/route.ts',
  ),
  ApiOperation(
    method: 'POST',
    path: '/api/v1/admin/shipping-governorates',
    sourceFile: 'app/api/v1/admin/shipping-governorates/route.ts',
  ),
  ApiOperation(
    method: 'PATCH',
    path: '/api/v1/admin/tags/{id}',
    sourceFile: 'app/api/v1/admin/tags/[id]/route.ts',
  ),
  ApiOperation(
    method: 'DELETE',
    path: '/api/v1/admin/tags/{id}',
    sourceFile: 'app/api/v1/admin/tags/[id]/route.ts',
  ),
  ApiOperation(
    method: 'GET',
    path: '/api/v1/admin/tags',
    sourceFile: 'app/api/v1/admin/tags/route.ts',
  ),
  ApiOperation(
    method: 'POST',
    path: '/api/v1/admin/tags',
    sourceFile: 'app/api/v1/admin/tags/route.ts',
  ),
  ApiOperation(
    method: 'GET',
    path: '/api/v1/admin/users/{id}',
    sourceFile: 'app/api/v1/admin/users/[id]/route.ts',
  ),
  ApiOperation(
    method: 'PATCH',
    path: '/api/v1/admin/users/{id}',
    sourceFile: 'app/api/v1/admin/users/[id]/route.ts',
  ),
  ApiOperation(
    method: 'GET',
    path: '/api/v1/admin/users',
    sourceFile: 'app/api/v1/admin/users/route.ts',
  ),
  ApiOperation(
    method: 'PATCH',
    path: '/api/v1/admin/wallets/{id}',
    sourceFile: 'app/api/v1/admin/wallets/[id]/route.ts',
  ),
  ApiOperation(
    method: 'DELETE',
    path: '/api/v1/admin/wallets/{id}',
    sourceFile: 'app/api/v1/admin/wallets/[id]/route.ts',
  ),
  ApiOperation(
    method: 'GET',
    path: '/api/v1/admin/wallets',
    sourceFile: 'app/api/v1/admin/wallets/route.ts',
  ),
  ApiOperation(
    method: 'POST',
    path: '/api/v1/admin/wallets',
    sourceFile: 'app/api/v1/admin/wallets/route.ts',
  ),
  ApiOperation(
    method: 'GET',
    path: '/api/v1/auth/{...auth}',
    sourceFile: 'app/api/v1/auth/[...auth]/route.ts',
  ),
  ApiOperation(
    method: 'POST',
    path: '/api/v1/auth/{...auth}',
    sourceFile: 'app/api/v1/auth/[...auth]/route.ts',
  ),
  ApiOperation(
    method: 'GET',
    path: '/api/v1/brands',
    sourceFile: 'app/api/v1/brands/route.ts',
  ),
  ApiOperation(
    method: 'POST',
    path: '/api/v1/cart/merge',
    sourceFile: 'app/api/v1/cart/merge/route.ts',
  ),
  ApiOperation(
    method: 'GET',
    path: '/api/v1/cart',
    sourceFile: 'app/api/v1/cart/route.ts',
  ),
  ApiOperation(
    method: 'POST',
    path: '/api/v1/cart',
    sourceFile: 'app/api/v1/cart/route.ts',
  ),
  ApiOperation(
    method: 'PATCH',
    path: '/api/v1/cart',
    sourceFile: 'app/api/v1/cart/route.ts',
  ),
  ApiOperation(
    method: 'DELETE',
    path: '/api/v1/cart',
    sourceFile: 'app/api/v1/cart/route.ts',
  ),
  ApiOperation(
    method: 'GET',
    path: '/api/v1/categories',
    sourceFile: 'app/api/v1/categories/route.ts',
  ),
  ApiOperation(
    method: 'POST',
    path: '/api/v1/checkout/quote',
    sourceFile: 'app/api/v1/checkout/quote/route.ts',
  ),
  ApiOperation(
    method: 'POST',
    path: '/api/v1/checkout',
    sourceFile: 'app/api/v1/checkout/route.ts',
  ),
  ApiOperation(
    method: 'GET',
    path: '/api/v1/commerce/country',
    sourceFile: 'app/api/v1/commerce/country/route.ts',
  ),
  ApiOperation(
    method: 'POST',
    path: '/api/v1/commerce/country',
    sourceFile: 'app/api/v1/commerce/country/route.ts',
  ),
  ApiOperation(
    method: 'POST',
    path: '/api/v1/contact',
    sourceFile: 'app/api/v1/contact/route.ts',
  ),
  ApiOperation(
    method: 'GET',
    path: '/api/v1/hero',
    sourceFile: 'app/api/v1/hero/route.ts',
  ),
  ApiOperation(
    method: 'POST',
    path: '/api/v1/locale',
    sourceFile: 'app/api/v1/locale/route.ts',
  ),
  ApiOperation(
    method: 'POST',
    path: '/api/v1/media/delete',
    sourceFile: 'app/api/v1/media/delete/route.ts',
  ),
  ApiOperation(
    method: 'POST',
    path: '/api/v1/media/upload',
    sourceFile: 'app/api/v1/media/upload/route.ts',
  ),
  ApiOperation(
    method: 'GET',
    path: '/api/v1/orders/{id}',
    sourceFile: 'app/api/v1/orders/[id]/route.ts',
  ),
  ApiOperation(
    method: 'POST',
    path: '/api/v1/orders',
    sourceFile: 'app/api/v1/orders/route.ts',
  ),
  ApiOperation(
    method: 'GET',
    path: '/api/v1/orders',
    sourceFile: 'app/api/v1/orders/route.ts',
  ),
  ApiOperation(
    method: 'GET',
    path: '/api/v1/payments/paymob/{paymentId}',
    sourceFile: 'app/api/v1/payments/paymob/[paymentId]/route.ts',
  ),
  ApiOperation(
    method: 'POST',
    path: '/api/v1/payments/paymob/create',
    sourceFile: 'app/api/v1/payments/paymob/create/route.ts',
  ),
  ApiOperation(
    method: 'GET',
    path: '/api/v1/products/{id}/reviews',
    sourceFile: 'app/api/v1/products/[id]/reviews/route.ts',
  ),
  ApiOperation(
    method: 'POST',
    path: '/api/v1/products/{id}/reviews',
    sourceFile: 'app/api/v1/products/[id]/reviews/route.ts',
  ),
  ApiOperation(
    method: 'GET',
    path: '/api/v1/products/{id}',
    sourceFile: 'app/api/v1/products/[id]/route.ts',
  ),
  ApiOperation(
    method: 'GET',
    path: '/api/v1/products',
    sourceFile: 'app/api/v1/products/route.ts',
  ),
  ApiOperation(
    method: 'GET',
    path: '/api/v1/shipping/countries/{code}/payment-methods',
    sourceFile: 'app/api/v1/shipping/countries/[code]/payment-methods/route.ts',
  ),
  ApiOperation(
    method: 'GET',
    path: '/api/v1/shipping/countries',
    sourceFile: 'app/api/v1/shipping/countries/route.ts',
  ),
  ApiOperation(
    method: 'GET',
    path: '/api/v1/shipping/governorates',
    sourceFile: 'app/api/v1/shipping/governorates/route.ts',
  ),
  ApiOperation(
    method: 'GET',
    path: '/api/v1/shipping/regions',
    sourceFile: 'app/api/v1/shipping/regions/route.ts',
  ),
  ApiOperation(
    method: 'GET',
    path: '/api/v1/wallets',
    sourceFile: 'app/api/v1/wallets/route.ts',
  ),
  ApiOperation(
    method: 'POST',
    path: '/api/v1/webhooks/{provider}',
    sourceFile: 'app/api/v1/webhooks/[provider]/route.ts',
  ),
  ApiOperation(
    method: 'GET',
    path: '/api/v1/wishlist',
    sourceFile: 'app/api/v1/wishlist/route.ts',
  ),
  ApiOperation(
    method: 'POST',
    path: '/api/v1/wishlist',
    sourceFile: 'app/api/v1/wishlist/route.ts',
  ),
  ApiOperation(
    method: 'DELETE',
    path: '/api/v1/wishlist',
    sourceFile: 'app/api/v1/wishlist/route.ts',
  ),
];
