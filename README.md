# ecommerce_platform_api

مكتبة Dart typed client للتعامل مع جميع واجهات Ecommerce Platform backend. تم توليد طبقة العمليات من `api_route_inventory.json` في commit المصدر `ca7306ec4faae13979af256cd818723e897b02e4`، وتغطي **135 عملية HTTP** على **83 route files**.

## التثبيت

أضف الحزمة إلى `pubspec.yaml`:

```yaml
dependencies:
  ecommerce_platform_api:
    path: ../path/to/ecommerce_platform/dart/ecommerce_platform_api
```

ثم نفّذ `dart pub get`.

## إنشاء العميل

```dart
import 'package:ecommerce_platform_api/ecommerce_platform_api.dart';

final client = EcommercePlatformClient(
  baseUrl: 'https://your-domain.example',
  authTokenProvider: StaticAuthTokenProvider(accessToken),
);
```

العميل يرسل تلقائيًا `Accept: application/json`، ويضيف `Content-Type: application/json` عند وجود body، ويضيف `Authorization: Bearer <token>` عندما يعيد `AuthTokenProvider` token صالحًا. يمكن تمرير Better Auth cookie عبر `cookie` أو عبر `defaultHeaders`. النقل يطبق timeout افتراضيًا قدره 30 ثانية، ويعيد المحاولة تلقائيًا حتى مرتين لطلبات GET/HEAD/OPTIONS عند أخطاء الشبكة أو `408/425/429/5xx`. يمكن ضبط `requestTimeout`, `maxRetries`, `retryDelay`, أو تفعيل `retryUnsafeRequests` عند الحاجة.

## استدعاء endpoints

كل العمليات المتحققة موجودة داخل `client.api`. أسماء العمليات تتبع method + path بصيغة lowerCamelCase، مثل `getApiV1Products` و`postApiV1Orders` و`patchApiV1AdminProducts` و`getApiV1ShippingCountriesCodePaymentMethods`. توجد أيضًا `ecommercePlatformOperations` و`backendSourceCommit` لاكتشاف كل العمليات والنسخة المصدرية من داخل التطبيق.

```dart
final products = await client.api.getApiV1Products(
  authenticated: false,
  query: {
    'locale': 'en',
    'page': 1,
    'limit': 20,
    'inStockOnly': true,
  },
);

final order = await client.api.postApiV1Orders(
  body: OrderInput(
    items: [CartItemInput(productId: 'product-id', quantity: 2)],
    shippingAddress: ShippingAddressInput(
      fullName: 'Customer Name',
      phone: '+201000000000',
      addressLine1: 'Street 1',
      city: 'Cairo',
      country: 'EG',
    ),
    paymentMethod: 'cod',
  ),
  idempotencyKey: 'order-request-unique-key',
);
```

المسارات التي تحتوي parameters تستخدم named arguments:

```dart
final details = await client.api.getApiV1ProductsId(
  id: 'product-id',
  query: {'locale': 'ar'},
  authenticated: false,
);

final updated = await client.api.patchApiV1AdminProducts(
  body: {
    'id': 'product-id',
    'name': 'Updated product name',
    'basePrice': 100,
  },
);
```

## النماذج والـ responses

توجد نماذج request شائعة مثل `OrderInput`, `CartItemInput`, `ShippingAddressInput`, `Address`, `ReviewInput`, `CheckoutQuoteInput`, `ProfilePatch`, `PaymentProviderConfig`, `InventoryAdjustment`, `HeroSlideInput`, و`ShippingCountryInput`. يمكن أيضًا تمرير `Map<String, dynamic>` مباشرة لأي endpoint؛ هذا يحافظ على التوافق مع DTOs التي يرجعها backend أو الخدمات المفوضة.

كل request يرجع `ApiResponse<T>` ويحتوي على `success`, `data`, `meta`, `pagination`, و`raw`. لأن بعض backend DTOs مفوضة إلى services أو Better Auth، يتم الاحتفاظ بالـ response كاملًا داخل `raw` بدل إسقاط حقول غير معروفة.

## الأخطاء

عند `throwOnApiError: true`، أي HTTP status خارج 2xx أو standard envelope يحتوي `success: false` يرمي `ApiException` مع:

```dart
try {
  await client.api.getApiV1ProductsId(id: 'missing-id', authenticated: false);
} on ApiException catch (error) {
  print(error.statusCode);
  print(error.code); // PRODUCT_NOT_FOUND
  print(error.message);
  print(error.error.details);
}
```

يمكن تعطيل الرمي وقراءة `ApiResponse.success` و`ApiResponse.raw` مباشرة عبر `throwOnApiError: false`.

## الملفات الأساسية

| الملف | المسؤولية |
|---|---|
| `lib/src/api_client.dart` | HTTP transport، auth، cookies، headers، JSON، multipart، errors. |
| `lib/src/generated_api.dart` | جميع العمليات الـ 135 المولدة من route inventory. |
| `lib/src/models.dart` | typed request models وقراءة النماذج الشائعة. |
| `lib/src/types.dart` | envelopes، pagination، errors، auth provider، multipart parts. |
| `lib/ecommerce_platform_api.dart` | public package exports وfacade الرئيسي. |

## اختبار الإنتاج

يوجد smoke test آمن للقراءة فقط في `tool/production_smoke.dart`. شغّله من جذر الحزمة عبر `dart run tool/production_smoke.dart` لاختبار health/readiness/catalog/shipping/payment-methods/guest-cart/auth-guard/reviews وcheckout quote ضد deployment الفعلي. الاختبار لا ينشئ order ولا يغير بيانات الإدارة.

## ملاحظات مهمة

المكتبة لا تنفّذ auth provider داخليًا؛ Better Auth يظل مسؤولًا عن شكل عمليات sign-in/sign-up تحت catch-all routes. مرر token أو cookie الذي حصلت عليه من auth flow إلى العميل. كما أن `POST /api/v1/media/upload` يحتاج `MultipartPart` ويستخدم `client.transport.upload` مباشرة، لأن generated route methods تغطي عمليات JSON بينما upload يحتاج multipart body.

استخدم `client.close()` عند انتهاء عمر التطبيق أو عند التخلص من dependency scope.
