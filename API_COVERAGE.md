# Ecommerce Platform API v1

> هذا هو المرجع الكامل للعقد عند commit `b54db56f66ea6e3db2adcf08cf9e8c512f211801`. يغطي **136 عملية HTTP** عبر **85 ملف route**، بينما يبقى الخادم مصدر الحقيقة النهائي عند اختلاف السلوك الفعلي.

## البداية السريعة

| البند | القيمة |
|---|---|
| OpenAPI | [`openapi.yaml`](./openapi.yaml) |
| Base URL الإنتاجي | `https://ec-swart.vercel.app` |
| المصادقة | Bearer token أو cookie `better-auth.session_token` بحسب route |
| Response envelope | نجاح: `success: true`، خطأ: `success: false` مع `error.code` و`error.message` |
| مصدر التحقق | `ecommerce-platform@b54db56f66ea6e3db2adcf08cf9e8c512f211801` |

## قواعد عامة

تستخدم مسارات API v1 السابقة prefix `/api/v1`. مسارات Better Auth وhealth الموجودة خارج v1 موثقة أيضًا لأن SDK يغطيها ضمن العقد الكامل. استخدم HTTPS في الإنتاج، ولا تسجل tokens أو cookies أو بيانات الدفع. عمليات الكتابة التي تغيّر الحالة يجب أن تستخدم `Idempotency-Key` عندما يطلبها الخادم، ولا يجوز إعادة تنفيذها تلقائيًا إلا بعد ضمان idempotency.

جميع العمليات تعيد envelope موحدًا بحسب نوع الاستجابة. يجب على العميل التعامل مع status code أولًا، ثم قراءة `success`, `data`, `meta`, `pagination` أو `error`. الحقول غير الموجودة في endpoint معين لا ينبغي افتراضها من endpoint آخر؛ ارجع إلى schema العملية في OpenAPI.

## مصفوفة التغطية الكاملة

كل صف أدناه يمثل عملية HTTP مستقلة. تفاصيل parameters وrequest body وresponses موجودة في العملية المقابلة داخل OpenAPI، بينما يوضح عمود المصدر route الفعلي الذي تم التحقق منه.

| Method | Path | Operation ID | Parameters | Body | Responses | Source route |
|---|---|---|---|---|---|---|
| GET | `/api/auth/{auth}` | `getApiAuthCatchAll` | - | none | 200, 400, 401, 403, 404, 409, 500 | `Generated/auth catch-all or contract-only route` |
| POST | `/api/auth/{auth}` | `postApiAuthCatchAll` | - | optional | 200, 400, 401, 403, 404, 409, 500 | `Generated/auth catch-all or contract-only route` |
| GET | `/api/health` | `getApiHealth` | - | none | 200, 400, 401, 403, 404, 409, 500 | `app/api/health/route.ts` |
| GET | `/api/health/ready` | `getApiHealthReady` | - | none | 200, 400, 401, 403, 404, 409, 500 | `app/api/health/ready/route.ts` |
| GET | `/api/v1/account/orders/{id}` | `getApiV1AccountOrdersId` | id | none | 200, 400, 401, 403, 404, 409, 500 | `app/api/v1/account/orders/[id]/route.ts` |
| POST | `/api/v1/account/orders/{id}` | `postApiV1AccountOrdersId` | id | optional | 200, 400, 401, 403, 404, 409, 500 | `app/api/v1/account/orders/[id]/route.ts` |
| POST | `/api/v1/account/orders/{id}/cancel` | `postApiV1AccountOrdersIdCancel` | id | optional | 200, 400, 401, 403, 404, 409, 500 | `app/api/v1/account/orders/[id]/cancel/route.ts` |
| POST | `/api/v1/account/orders/{id}/returns` | `postApiV1AccountOrdersIdReturns` | id | required | 201, 400, 401, 404, 422 | `app/api/v1/account/orders/[id]/returns/route.ts` |
| GET | `/api/v1/account/orders/{id}/receipt` | `getApiV1AccountOrdersIdReceipt` | id | none | 200, 401, 404, 500 | `app/api/v1/account/orders/[id]/receipt/route.ts` |
| GET | `/api/v1/account/profile` | `getApiV1AccountProfile` | - | none | 200, 400, 401, 403, 404, 409, 500 | `app/api/v1/account/profile/route.ts` |
| PATCH | `/api/v1/account/profile` | `patchApiV1AccountProfile` | - | optional | 200, 400, 401, 403, 404, 409, 500 | `app/api/v1/account/profile/route.ts` |
| GET | `/api/v1/account/reviews` | `getApiV1AccountReviews` | - | none | 200, 400, 401, 403, 404, 409, 500 | `app/api/v1/account/reviews/route.ts` |
| POST | `/api/v1/account/reviews` | `postApiV1AccountReviews` | - | optional | 200, 400, 401, 403, 404, 409, 500 | `app/api/v1/account/reviews/route.ts` |
| DELETE | `/api/v1/account/reviews/{id}` | `deleteApiV1AccountReviewsId` | id | optional | 200, 400, 401, 403, 404, 409, 500 | `app/api/v1/account/reviews/[id]/route.ts` |
| GET | `/api/v1/account/reviews/{id}` | `getApiV1AccountReviewsId` | id | none | 200, 400, 401, 403, 404, 409, 500 | `app/api/v1/account/reviews/[id]/route.ts` |
| POST | `/api/v1/account/security` | `postApiV1AccountSecurity` | - | optional | 200, 400, 401, 403, 404, 409, 500 | `app/api/v1/account/security/route.ts` |
| DELETE | `/api/v1/account/sessions` | `deleteApiV1AccountSessions` | - | optional | 200, 400, 401, 403, 404, 409, 500 | `app/api/v1/account/sessions/route.ts` |
| GET | `/api/v1/account/sessions` | `getApiV1AccountSessions` | - | none | 200, 400, 401, 403, 404, 409, 500 | `app/api/v1/account/sessions/route.ts` |
| GET | `/api/v1/account/settings` | `getApiV1AccountSettings` | - | none | 200, 400, 401, 403, 404, 409, 500 | `app/api/v1/account/settings/route.ts` |
| PATCH | `/api/v1/account/settings` | `patchApiV1AccountSettings` | - | optional | 200, 400, 401, 403, 404, 409, 500 | `app/api/v1/account/settings/route.ts` |
| DELETE | `/api/v1/addresses` | `deleteApiV1Addresses` | - | optional | 200, 400, 401, 403, 404, 409, 500 | `app/api/v1/addresses/route.ts` |
| GET | `/api/v1/addresses` | `getApiV1Addresses` | - | none | 200, 400, 401, 403, 404, 409, 500 | `app/api/v1/addresses/route.ts` |
| POST | `/api/v1/addresses` | `postApiV1Addresses` | - | optional | 200, 400, 401, 403, 404, 409, 500 | `app/api/v1/addresses/route.ts` |
| DELETE | `/api/v1/addresses/{id}` | `deleteApiV1AddressesId` | id | optional | 200, 400, 401, 403, 404, 409, 500 | `app/api/v1/addresses/[id]/route.ts` |
| PATCH | `/api/v1/addresses/{id}` | `patchApiV1AddressesId` | id | optional | 200, 400, 401, 403, 404, 409, 500 | `app/api/v1/addresses/[id]/route.ts` |
| PUT | `/api/v1/addresses/{id}/default` | `putApiV1AddressesIdDefault` | id | optional | 200, 400, 401, 403, 404, 409, 500 | `app/api/v1/addresses/[id]/default/route.ts` |
| GET | `/api/v1/admin/audit-logs` | `getApiV1AdminAuditLogs` | - | none | 200, 400, 401, 403, 404, 409, 500 | `app/api/v1/admin/audit-logs/route.ts` |
| GET | `/api/v1/admin/brands` | `getApiV1AdminBrands` | - | none | 200, 400, 401, 403, 404, 409, 500 | `app/api/v1/admin/brands/route.ts` |
| POST | `/api/v1/admin/brands` | `postApiV1AdminBrands` | - | optional | 200, 400, 401, 403, 404, 409, 500 | `app/api/v1/admin/brands/route.ts` |
| DELETE | `/api/v1/admin/brands/{id}` | `deleteApiV1AdminBrandsId` | id | optional | 200, 400, 401, 403, 404, 409, 500 | `app/api/v1/admin/brands/[id]/route.ts` |
| PATCH | `/api/v1/admin/brands/{id}` | `patchApiV1AdminBrandsId` | id | optional | 200, 400, 401, 403, 404, 409, 500 | `app/api/v1/admin/brands/[id]/route.ts` |
| GET | `/api/v1/admin/categories` | `getApiV1AdminCategories` | - | none | 200, 400, 401, 403, 404, 409, 500 | `app/api/v1/admin/categories/route.ts` |
| POST | `/api/v1/admin/categories` | `postApiV1AdminCategories` | - | optional | 200, 400, 401, 403, 404, 409, 500 | `app/api/v1/admin/categories/route.ts` |
| DELETE | `/api/v1/admin/categories/{id}` | `deleteApiV1AdminCategoriesId` | id | optional | 200, 400, 401, 403, 404, 409, 500 | `app/api/v1/admin/categories/[id]/route.ts` |
| PATCH | `/api/v1/admin/categories/{id}` | `patchApiV1AdminCategoriesId` | id | optional | 200, 400, 401, 403, 404, 409, 500 | `app/api/v1/admin/categories/[id]/route.ts` |
| GET | `/api/v1/admin/commerce/reconciliation` | `getApiV1AdminCommerceReconciliation` | orderId | none | 200, 401, 403, 500 | `app/api/v1/admin/commerce/reconciliation/route.ts` |
| GET | `/api/v1/admin/contact` | `getApiV1AdminContact` | - | none | 200, 400, 401, 403, 404, 409, 500 | `app/api/v1/admin/contact/route.ts` |
| PATCH | `/api/v1/admin/contact/{id}` | `patchApiV1AdminContactId` | id | optional | 200, 400, 401, 403, 404, 409, 500 | `app/api/v1/admin/contact/[id]/route.ts` |
| GET | `/api/v1/admin/coupons` | `getApiV1AdminCoupons` | - | none | 200, 400, 401, 403, 404, 409, 500 | `app/api/v1/admin/coupons/route.ts` |
| POST | `/api/v1/admin/coupons` | `postApiV1AdminCoupons` | - | optional | 200, 400, 401, 403, 404, 409, 500 | `app/api/v1/admin/coupons/route.ts` |
| DELETE | `/api/v1/admin/coupons/{id}` | `deleteApiV1AdminCouponsId` | id | optional | 200, 400, 401, 403, 404, 409, 500 | `app/api/v1/admin/coupons/[id]/route.ts` |
| PATCH | `/api/v1/admin/coupons/{id}` | `patchApiV1AdminCouponsId` | id | optional | 200, 400, 401, 403, 404, 409, 500 | `app/api/v1/admin/coupons/[id]/route.ts` |
| POST | `/api/v1/admin/coupons/{id}/reset` | `postApiV1AdminCouponsIdReset` | id | optional | 200, 400, 401, 403, 404, 409, 500 | `app/api/v1/admin/coupons/[id]/reset/route.ts` |
| GET | `/api/v1/admin/customers` | `getApiV1AdminCustomers` | - | none | 200, 400, 401, 403, 404, 409, 500 | `app/api/v1/admin/customers/route.ts` |
| GET | `/api/v1/admin/dashboard` | `getApiV1AdminDashboard` | - | none | 200, 400, 401, 403, 404, 409, 500 | `app/api/v1/admin/dashboard/route.ts` |
| GET | `/api/v1/admin/hero-slides` | `getApiV1AdminHeroSlides` | - | none | 200, 400, 401, 403, 404, 409, 500 | `app/api/v1/admin/hero-slides/route.ts` |
| POST | `/api/v1/admin/hero-slides` | `postApiV1AdminHeroSlides` | - | optional | 200, 400, 401, 403, 404, 409, 500 | `app/api/v1/admin/hero-slides/route.ts` |
| PATCH | `/api/v1/admin/hero-slides/reorder` | `patchApiV1AdminHeroSlidesReorder` | - | optional | 200, 400, 401, 403, 404, 409, 500 | `app/api/v1/admin/hero-slides/reorder/route.ts` |
| DELETE | `/api/v1/admin/hero-slides/{id}` | `deleteApiV1AdminHeroSlidesId` | id | optional | 200, 400, 401, 403, 404, 409, 500 | `app/api/v1/admin/hero-slides/[id]/route.ts` |
| GET | `/api/v1/admin/hero-slides/{id}` | `getApiV1AdminHeroSlidesId` | id | none | 200, 400, 401, 403, 404, 409, 500 | `app/api/v1/admin/hero-slides/[id]/route.ts` |
| PATCH | `/api/v1/admin/hero-slides/{id}` | `patchApiV1AdminHeroSlidesId` | id | optional | 200, 400, 401, 403, 404, 409, 500 | `app/api/v1/admin/hero-slides/[id]/route.ts` |
| POST | `/api/v1/admin/hero-slides/{id}/duplicate` | `postApiV1AdminHeroSlidesIdDuplicate` | id | optional | 200, 400, 401, 403, 404, 409, 500 | `app/api/v1/admin/hero-slides/[id]/duplicate/route.ts` |
| GET | `/api/v1/admin/inventory` | `getApiV1AdminInventory` | - | none | 200, 400, 401, 403, 404, 409, 500 | `app/api/v1/admin/inventory/route.ts` |
| PATCH | `/api/v1/admin/inventory` | `patchApiV1AdminInventory` | - | optional | 200, 400, 401, 403, 404, 409, 500 | `app/api/v1/admin/inventory/route.ts` |
| GET | `/api/v1/admin/orders` | `getApiV1AdminOrders` | - | none | 200, 400, 401, 403, 404, 409, 500 | `app/api/v1/admin/orders/route.ts` |
| PATCH | `/api/v1/admin/orders` | `patchApiV1AdminOrders` | - | optional | 200, 400, 401, 403, 404, 409, 500 | `app/api/v1/admin/orders/route.ts` |
| GET | `/api/v1/admin/orders/{id}` | `getApiV1AdminOrdersId` | id | none | 200, 400, 401, 403, 404, 409, 500 | `app/api/v1/admin/orders/[id]/route.ts` |
| PATCH | `/api/v1/admin/orders/{id}/shipments` | `patchApiV1AdminOrdersIdShipments` | id | required | 200, 400, 401, 403, 404, 422 | `app/api/v1/admin/orders/[id]/shipments/route.ts` |
| PATCH | `/api/v1/admin/orders/{id}` | `patchApiV1AdminOrdersId` | id | optional | 200, 400, 401, 403, 404, 409, 500 | `app/api/v1/admin/orders/[id]/route.ts` |
| POST | `/api/v1/admin/orders/{id}/returns` | `postApiV1AdminOrdersIdReturns` | id | required | 201, 400, 401, 403, 422 | `app/api/v1/admin/orders/[id]/returns/route.ts` |
| GET | `/api/v1/admin/payment-providers` | `getApiV1AdminPaymentProviders` | - | none | 200, 400, 401, 403, 404, 409, 500 | `app/api/v1/admin/payment-providers/route.ts` |
| POST | `/api/v1/admin/payment-providers` | `postApiV1AdminPaymentProviders` | - | optional | 200, 400, 401, 403, 404, 409, 500 | `app/api/v1/admin/payment-providers/route.ts` |
| PATCH | `/api/v1/admin/payment-providers/{provider}` | `patchApiV1AdminPaymentProvidersProvider` | provider | optional | 200, 400, 401, 403, 404, 409, 500 | `app/api/v1/admin/payment-providers/[provider]/route.ts` |
| POST | `/api/v1/admin/payment-providers/{provider}/test` | `postApiV1AdminPaymentProvidersProviderTest` | provider | optional | 200, 400, 401, 403, 404, 409, 500 | `app/api/v1/admin/payment-providers/[provider]/test/route.ts` |
| GET | `/api/v1/admin/payments` | `getApiV1AdminPayments` | - | none | 200, 400, 401, 403, 404, 409, 500 | `app/api/v1/admin/payments/route.ts` |
| GET | `/api/v1/admin/price-lists` | `getApiV1AdminPriceLists` | - | none | 200, 400, 401, 403, 404, 409, 500 | `app/api/v1/admin/price-lists/route.ts` |
| POST | `/api/v1/admin/price-lists` | `postApiV1AdminPriceLists` | - | optional | 200, 400, 401, 403, 404, 409, 500 | `app/api/v1/admin/price-lists/route.ts` |
| DELETE | `/api/v1/admin/price-lists/{id}` | `deleteApiV1AdminPriceListsId` | id | optional | 200, 400, 401, 403, 404, 409, 500 | `app/api/v1/admin/price-lists/[id]/route.ts` |
| PATCH | `/api/v1/admin/price-lists/{id}` | `patchApiV1AdminPriceListsId` | id | optional | 200, 400, 401, 403, 404, 409, 500 | `app/api/v1/admin/price-lists/[id]/route.ts` |
| DELETE | `/api/v1/admin/products` | `deleteApiV1AdminProducts` | - | optional | 200, 400, 401, 403, 404, 409, 500 | `app/api/v1/admin/products/route.ts` |
| GET | `/api/v1/admin/products` | `getApiV1AdminProducts` | - | none | 200, 400, 401, 403, 404, 409, 500 | `app/api/v1/admin/products/route.ts` |
| PATCH | `/api/v1/admin/products` | `patchApiV1AdminProducts` | - | optional | 200, 400, 401, 403, 404, 409, 500 | `app/api/v1/admin/products/route.ts` |
| POST | `/api/v1/admin/products` | `postApiV1AdminProducts` | - | optional | 200, 400, 401, 403, 404, 409, 500 | `app/api/v1/admin/products/route.ts` |
| GET | `/api/v1/admin/reviews` | `getApiV1AdminReviews` | - | none | 200, 400, 401, 403, 404, 409, 500 | `app/api/v1/admin/reviews/route.ts` |
| PATCH | `/api/v1/admin/reviews` | `patchApiV1AdminReviews` | - | optional | 200, 400, 401, 403, 404, 409, 500 | `app/api/v1/admin/reviews/route.ts` |
| DELETE | `/api/v1/admin/reviews/{id}` | `deleteApiV1AdminReviewsId` | id | optional | 200, 400, 401, 403, 404, 409, 500 | `app/api/v1/admin/reviews/[id]/route.ts` |
| PATCH | `/api/v1/admin/reviews/{id}` | `patchApiV1AdminReviewsId` | id | optional | 200, 400, 401, 403, 404, 409, 500 | `app/api/v1/admin/reviews/[id]/route.ts` |
| GET | `/api/v1/admin/roles` | `getApiV1AdminRoles` | - | none | 200, 400, 401, 403, 404, 409, 500 | `app/api/v1/admin/roles/route.ts` |
| POST | `/api/v1/admin/roles` | `postApiV1AdminRoles` | - | optional | 200, 400, 401, 403, 404, 409, 500 | `app/api/v1/admin/roles/route.ts` |
| GET | `/api/v1/admin/settings` | `getApiV1AdminSettings` | - | none | 200, 400, 401, 403, 404, 409, 500 | `app/api/v1/admin/settings/route.ts` |
| POST | `/api/v1/admin/settings` | `postApiV1AdminSettings` | - | optional | 200, 400, 401, 403, 404, 409, 500 | `app/api/v1/admin/settings/route.ts` |
| GET | `/api/v1/admin/shipping` | `getApiV1AdminShipping` | - | none | 200, 400, 401, 403, 404, 409, 500 | `app/api/v1/admin/shipping/route.ts` |
| POST | `/api/v1/admin/shipping` | `postApiV1AdminShipping` | - | optional | 200, 400, 401, 403, 404, 409, 500 | `app/api/v1/admin/shipping/route.ts` |
| GET | `/api/v1/admin/shipping-countries` | `getApiV1AdminShippingCountries` | - | none | 200, 400, 401, 403, 404, 409, 500 | `app/api/v1/admin/shipping-countries/route.ts` |
| POST | `/api/v1/admin/shipping-countries` | `postApiV1AdminShippingCountries` | - | optional | 200, 400, 401, 403, 404, 409, 500 | `app/api/v1/admin/shipping-countries/route.ts` |
| DELETE | `/api/v1/admin/shipping-countries/{id}` | `deleteApiV1AdminShippingCountriesId` | id | optional | 200, 400, 401, 403, 404, 409, 500 | `app/api/v1/admin/shipping-countries/[id]/route.ts` |
| PATCH | `/api/v1/admin/shipping-countries/{id}` | `patchApiV1AdminShippingCountriesId` | id | optional | 200, 400, 401, 403, 404, 409, 500 | `app/api/v1/admin/shipping-countries/[id]/route.ts` |
| GET | `/api/v1/admin/shipping-governorates` | `getApiV1AdminShippingGovernorates` | - | none | 200, 400, 401, 403, 404, 409, 500 | `app/api/v1/admin/shipping-governorates/route.ts` |
| POST | `/api/v1/admin/shipping-governorates` | `postApiV1AdminShippingGovernorates` | - | optional | 200, 400, 401, 403, 404, 409, 500 | `app/api/v1/admin/shipping-governorates/route.ts` |
| DELETE | `/api/v1/admin/shipping-governorates/{id}` | `deleteApiV1AdminShippingGovernoratesId` | id | optional | 200, 400, 401, 403, 404, 409, 500 | `app/api/v1/admin/shipping-governorates/[id]/route.ts` |
| PATCH | `/api/v1/admin/shipping-governorates/{id}` | `patchApiV1AdminShippingGovernoratesId` | id | optional | 200, 400, 401, 403, 404, 409, 500 | `app/api/v1/admin/shipping-governorates/[id]/route.ts` |
| DELETE | `/api/v1/admin/shipping/{id}` | `deleteApiV1AdminShippingId` | id | optional | 200, 400, 401, 403, 404, 409, 500 | `app/api/v1/admin/shipping/[id]/route.ts` |
| PATCH | `/api/v1/admin/shipping/{id}` | `patchApiV1AdminShippingId` | id | optional | 200, 400, 401, 403, 404, 409, 500 | `app/api/v1/admin/shipping/[id]/route.ts` |
| GET | `/api/v1/admin/tags` | `getApiV1AdminTags` | - | none | 200, 400, 401, 403, 404, 409, 500 | `app/api/v1/admin/tags/route.ts` |
| POST | `/api/v1/admin/tags` | `postApiV1AdminTags` | - | optional | 200, 400, 401, 403, 404, 409, 500 | `app/api/v1/admin/tags/route.ts` |
| DELETE | `/api/v1/admin/tags/{id}` | `deleteApiV1AdminTagsId` | id | optional | 200, 400, 401, 403, 404, 409, 500 | `app/api/v1/admin/tags/[id]/route.ts` |
| PATCH | `/api/v1/admin/tags/{id}` | `patchApiV1AdminTagsId` | id | optional | 200, 400, 401, 403, 404, 409, 500 | `app/api/v1/admin/tags/[id]/route.ts` |
| GET | `/api/v1/admin/users` | `getApiV1AdminUsers` | - | none | 200, 400, 401, 403, 404, 409, 500 | `app/api/v1/admin/users/route.ts` |
| GET | `/api/v1/admin/users/{id}` | `getApiV1AdminUsersId` | id | none | 200, 400, 401, 403, 404, 409, 500 | `app/api/v1/admin/users/[id]/route.ts` |
| PATCH | `/api/v1/admin/users/{id}` | `patchApiV1AdminUsersId` | id | optional | 200, 400, 401, 403, 404, 409, 500 | `app/api/v1/admin/users/[id]/route.ts` |
| GET | `/api/v1/auth/{auth}` | `getApiV1AuthCatchAll` | - | none | 200, 400, 401, 403, 404, 409, 500 | `Generated/auth catch-all or contract-only route` |
| POST | `/api/v1/auth/{auth}` | `postApiV1AuthCatchAll` | - | optional | 200, 400, 401, 403, 404, 409, 500 | `Generated/auth catch-all or contract-only route` |
| GET | `/api/v1/brands` | `getApiV1Brands` | - | none | 200, 400, 401, 403, 404, 409, 500 | `app/api/v1/brands/route.ts` |
| DELETE | `/api/v1/cart` | `deleteApiV1Cart` | - | optional | 200, 400, 401, 403, 404, 409, 500 | `app/api/v1/cart/route.ts` |
| GET | `/api/v1/cart` | `getApiV1Cart` | - | none | 200, 400, 401, 403, 404, 409, 500 | `app/api/v1/cart/route.ts` |
| PATCH | `/api/v1/cart` | `patchApiV1Cart` | - | optional | 200, 400, 401, 403, 404, 409, 500 | `app/api/v1/cart/route.ts` |
| POST | `/api/v1/cart` | `postApiV1Cart` | - | optional | 200, 400, 401, 403, 404, 409, 500 | `app/api/v1/cart/route.ts` |
| POST | `/api/v1/cart/merge` | `postApiV1CartMerge` | - | optional | 200, 400, 401, 403, 404, 409, 500 | `app/api/v1/cart/merge/route.ts` |
| GET | `/api/v1/categories` | `getApiV1Categories` | - | none | 200, 400, 401, 403, 404, 409, 500 | `app/api/v1/categories/route.ts` |
| POST | `/api/v1/checkout` | `postApiV1Checkout` | - | optional | 200, 400, 401, 403, 404, 409, 500 | `app/api/v1/checkout/route.ts` |
| POST | `/api/v1/checkout/quote` | `postApiV1CheckoutQuote` | - | optional | 200, 400, 401, 403, 404, 409, 500 | `app/api/v1/checkout/quote/route.ts` |
| GET | `/api/v1/commerce/country` | `getApiV1CommerceCountry` | - | none | 200, 400, 401, 403, 404, 409, 500 | `app/api/v1/commerce/country/route.ts` |
| POST | `/api/v1/commerce/country` | `postApiV1CommerceCountry` | - | optional | 200, 400, 401, 403, 404, 409, 500 | `app/api/v1/commerce/country/route.ts` |
| POST | `/api/v1/contact` | `postApiV1Contact` | - | optional | 200, 400, 401, 403, 404, 409, 500 | `app/api/v1/contact/route.ts` |
| GET | `/api/v1/hero` | `getApiV1Hero` | - | none | 200, 400, 401, 403, 404, 409, 500 | `app/api/v1/hero/route.ts` |
| POST | `/api/v1/locale` | `postApiV1Locale` | - | optional | 200, 400, 401, 403, 404, 409, 500 | `app/api/v1/locale/route.ts` |
| POST | `/api/v1/media/delete` | `postApiV1MediaDelete` | - | optional | 200, 400, 401, 403, 404, 409, 500 | `app/api/v1/media/delete/route.ts` |
| POST | `/api/v1/media/upload` | `postApiV1MediaUpload` | - | optional | 200, 400, 401, 403, 404, 409, 500 | `app/api/v1/media/upload/route.ts` |
| GET | `/api/v1/orders` | `getApiV1Orders` | - | none | 200, 400, 401, 403, 404, 409, 500 | `app/api/v1/orders/route.ts` |
| POST | `/api/v1/orders` | `postApiV1Orders` | - | optional | 200, 400, 401, 403, 404, 409, 500 | `app/api/v1/orders/route.ts` |
| GET | `/api/v1/orders/{id}` | `getApiV1OrdersId` | id | none | 200, 400, 401, 403, 404, 409, 500 | `app/api/v1/orders/[id]/route.ts` |
| POST | `/api/v1/payments/paymob/create` | `postApiV1PaymentsPaymobCreate` | - | optional | 200, 400, 401, 403, 404, 409, 500 | `app/api/v1/payments/paymob/create/route.ts` |
| GET | `/api/v1/payments/paymob/{paymentId}` | `getApiV1PaymentsPaymobPaymentId` | paymentId | none | 200, 400, 401, 403, 404, 409, 500 | `app/api/v1/payments/paymob/[paymentId]/route.ts` |
| GET | `/api/v1/products` | `getApiV1Products` | - | none | 200, 400, 401, 403, 404, 409, 500 | `app/api/v1/products/route.ts` |
| GET | `/api/v1/products/{id}` | `getApiV1ProductsId` | id | none | 200, 400, 401, 403, 404, 409, 500 | `app/api/v1/products/[id]/route.ts` |
| GET | `/api/v1/products/{id}/reviews` | `getApiV1ProductsIdReviews` | id | none | 200, 400, 401, 403, 404, 409, 500 | `app/api/v1/products/[id]/reviews/route.ts` |
| POST | `/api/v1/products/{id}/reviews` | `postApiV1ProductsIdReviews` | id | optional | 200, 400, 401, 403, 404, 409, 500 | `app/api/v1/products/[id]/reviews/route.ts` |
| GET | `/api/v1/shipping/countries` | `getApiV1ShippingCountries` | - | none | 200, 400, 401, 403, 404, 409, 500 | `app/api/v1/shipping/countries/route.ts` |
| GET | `/api/v1/shipping/countries/{code}/payment-methods` | `getApiV1ShippingCountriesCodePaymentMethods` | code | none | 200, 400, 401, 403, 404, 409, 500 | `app/api/v1/shipping/countries/[code]/payment-methods/route.ts` |
| GET | `/api/v1/shipping/governorates` | `getApiV1ShippingGovernorates` | - | none | 200, 400, 401, 403, 404, 409, 500 | `app/api/v1/shipping/governorates/route.ts` |
| GET | `/api/v1/shipping/regions` | `getApiV1ShippingRegions` | - | none | 200, 400, 401, 403, 404, 409, 500 | `app/api/v1/shipping/regions/route.ts` |
| GET | `/api/v1/store/branding` | `getApiV1StoreBranding` | - | none | 200, 500 | `app/api/v1/store/branding/route.ts` |
| POST | `/api/v1/webhooks/{provider}` | `postApiV1WebhooksProvider` | provider | optional | 200, 400, 401, 403, 404, 409, 500 | `app/api/v1/webhooks/[provider]/route.ts` |
| DELETE | `/api/v1/wishlist` | `deleteApiV1Wishlist` | - | optional | 200, 400, 401, 403, 404, 409, 500 | `app/api/v1/wishlist/route.ts` |
| GET | `/api/v1/wishlist` | `getApiV1Wishlist` | - | none | 200, 400, 401, 403, 404, 409, 500 | `app/api/v1/wishlist/route.ts` |
| POST | `/api/v1/wishlist` | `postApiV1Wishlist` | - | optional | 200, 400, 401, 403, 404, 409, 500 | `app/api/v1/wishlist/route.ts` |

## تقسيم حسب المجال

### `account` (16 operations)

`GET /api/v1/account/orders/{id}`، `POST /api/v1/account/orders/{id}`، `POST /api/v1/account/orders/{id}/cancel`، `POST /api/v1/account/orders/{id}/returns`، `GET /api/v1/account/orders/{id}/receipt`، `GET /api/v1/account/profile`، `PATCH /api/v1/account/profile`، `GET /api/v1/account/reviews`، `POST /api/v1/account/reviews`، `DELETE /api/v1/account/reviews/{id}`، `GET /api/v1/account/reviews/{id}`، `POST /api/v1/account/security`، `DELETE /api/v1/account/sessions`، `GET /api/v1/account/sessions`، `GET /api/v1/account/settings`، `PATCH /api/v1/account/settings`

### `addresses` (6 operations)

`DELETE /api/v1/addresses`، `GET /api/v1/addresses`، `POST /api/v1/addresses`، `DELETE /api/v1/addresses/{id}`، `PATCH /api/v1/addresses/{id}`، `PUT /api/v1/addresses/{id}/default`

### `admin` (78 operations)


### `auth` (4 operations)

`GET /api/auth/{auth}`، `POST /api/auth/{auth}`، `GET /api/v1/auth/{auth}`، `POST /api/v1/auth/{auth}`

### `brands` (1 operations)

`GET /api/v1/brands`

### `cart` (5 operations)

`DELETE /api/v1/cart`، `GET /api/v1/cart`، `PATCH /api/v1/cart`، `POST /api/v1/cart`، `POST /api/v1/cart/merge`

### `categories` (1 operations)

`GET /api/v1/categories`

### `checkout` (2 operations)

`POST /api/v1/checkout`، `POST /api/v1/checkout/quote`

### `commerce` (2 operations)

`GET /api/v1/commerce/country`، `POST /api/v1/commerce/country`

### `contact` (1 operations)

`POST /api/v1/contact`

### `health` (2 operations)

`GET /api/health`، `GET /api/health/ready`

### `hero` (1 operations)

`GET /api/v1/hero`

### `locale` (1 operations)

`POST /api/v1/locale`

### `media` (2 operations)

`POST /api/v1/media/delete`، `POST /api/v1/media/upload`

### `orders` (3 operations)

`GET /api/v1/orders`، `POST /api/v1/orders`، `GET /api/v1/orders/{id}`

### `payments` (2 operations)

`POST /api/v1/payments/paymob/create`، `GET /api/v1/payments/paymob/{paymentId}`

### `products` (4 operations)

`GET /api/v1/products`، `GET /api/v1/products/{id}`، `GET /api/v1/products/{id}/reviews`، `POST /api/v1/products/{id}/reviews`

### `shipping` (4 operations)

`GET /api/v1/shipping/countries`، `GET /api/v1/shipping/countries/{code}/payment-methods`، `GET /api/v1/shipping/governorates`، `GET /api/v1/shipping/regions`

### `store` (1 operations)

`GET /api/v1/store/branding`

### `webhooks` (1 operations)

`POST /api/v1/webhooks/{provider}`

### `wishlist` (3 operations)

`DELETE /api/v1/wishlist`، `GET /api/v1/wishlist`، `POST /api/v1/wishlist`

## الأخطاء والتشغيل الإنتاجي

| الحالة | المعالجة |
|---|---|
| `400` | تحقق من body وquery وpath parameters وvalidation rules. |
| `401` | أعد المصادقة أو جدّد token/cookie دون كشف السر في السجلات. |
| `403` | الحساب مصادق لكنه لا يملك الدور أو الصلاحية المطلوبة. |
| `404` | المورد أو route parameter غير موجود. |
| `409` | تعارض حالة أو idempotency؛ لا تعِد الكتابة عشوائيًا. |
| `429` | احترم rate limit وRetry-After عند توفره. |
| `5xx` | سجّل correlation/request id إن توفر، واستخدم retry bounded للقراءات فقط. |

## التحقق ومزامنة SDK

تمت مطابقة route inventory مع `ecommerce-platform-dart-api/lib/src/operation_manifest.dart` و`openapi.yaml`. عند إضافة route جديد، يجب تحديث manifest وgenerated API وOpenAPI والاختبارات وهذا المرجع في التغيير نفسه، ثم تشغيل `dart format`, `dart analyze`, و`dart test` في CI.

