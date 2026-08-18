# ecommerce_platform_api

مكتبة Dart typed SDK شاملة للتعامل مع Ecommerce Platform backend. الإصدار الحالي يحوي **135 عملية HTTP** على **83 route files**، ويقدم طبقة typed سهلة للاستخدام فوق transport عام يغطي كل العمليات التي تم التحقق منها من commit المصدر `ca7306ec4faae13979af256cd818723e897b02e4`.

## الفكرة الأساسية

المستخدم العادي لا يحتاج إلى كتابة أسماء حقول JSON أو query parameters أو path parameters يدويًا. استخدم domain clients وrequest models؛ سيقوم Dart compiler بتحديد الحقول الصحيحة، ويقوم SDK بالتحقق من البيانات قبل إرسالها. توجد طبقة `client.api` كـ compatibility escape hatch لكل العمليات الـ 135، لكنها ليست المسار الموصى به للتطبيقات الجديدة.

## التثبيت

```yaml
dependencies:
  ecommerce_platform_api:
    git:
      url: https://github.com/MohammedAydan/ecommerce-platform-dart-api.git
      ref: main
```

ثم نفّذ `dart pub get`.

## إنشاء العميل وAuth

يدعم backend Better Auth عبر bearer token أو cookies. لا تضع token أو cookie في model prompt أو tool arguments. في تطبيقات Dart server/mobile استخدم provider أو cookie store مناسبًا:

```dart
import 'package:ecommerce_platform_api/ecommerce_platform_api.dart';

final cookieStore = MemoryCookieStore();
final client = EcommercePlatformClient(
  baseUrl: 'https://ec-swart.vercel.app',
  cookieStore: cookieStore,
  requestTimeout: const Duration(seconds: 30),
  maxRetries: 2,
);

final signedIn = await client.auth.signIn(
  const SignInRequest(
    email: 'customer@example.com',
    password: 'strong-password',
  ),
);

final currentSession = await client.auth.session();
```

يمكن بدل ذلك تمرير `StaticAuthTokenProvider` أو provider مخصص يقرأ token من secure storage. يحتفظ `MemoryCookieStore` تلقائيًا بـ `Set-Cookie` الناتج من Better Auth، ويمكن تنفيذ `CookieStore` خاص بالتطبيق لحفظ cookies في secure storage.

## Typed domain clients

| Client | الاستخدام |
|---|---|
| `client.auth` | sign-in، sign-up، session، sign-out. |
| `client.publicApi` | products، categories، brands، hero، commerce country، shipping، payment methods، reviews. |
| `client.checkout` | quote authoritative للتسعير والخصومات والشحن والضرائب. |
| `client.cart` | قراءة وإضافة وتعديل ومسح ودمج guest/authenticated cart. |
| `client.account` | profile، settings، security، sessions، account orders، account reviews. |
| `client.addresses` | list/create/update/delete/set-default. |
| `client.orders` | create/list/get مع idempotency key. |
| `client.admin` | typed product/taxonomy/coupon/wallet/tag/order/review/user/role/payment/shipping/hero operations. |
| `client.api` | طبقة raw المولدة لكل العمليات الـ 135 عند الحاجة إلى route غير موجود في facade. |

## أمثلة typed بدون Map يدوي

### Catalog

```dart
final products = await client.publicApi.listProducts(
  query: const CatalogQuery(
    locale: AppLocale.en,
    search: 'wireless mouse',
    inStockOnly: true,
    page: 1,
    limit: 20,
  ),
);

final product = await client.publicApi.getProduct('test-product');
```

### Checkout quote

`CheckoutQuoteRequest` يتحقق محليًا من وجود item واحد على الأقل، ومن حدود الكمية، ومن product/variant identifiers. لا تحسب الإجماليات في التطبيق؛ استخدم quote الناتج من backend لأنه authoritative للتسعير والعملة والضريبة والشحن.

```dart
final quote = await client.checkout.quote(
  CheckoutQuoteRequest(
    items: [
      const CartItemInput(productId: 'product-id', quantity: 2),
    ],
    shippingAddress: const ShippingAddressInput(
      fullName: 'Customer Name',
      phone: '+201000000000',
      addressLine1: 'Street 1',
      city: 'Cairo',
      country: 'EG',
    ),
    commerceContext: const CommerceContextInput(
      countryCode: 'EG',
      currency: 'EGP',
    ),
  ),
);

final total = quote.data?.total;
final currency = quote.data?.currency;
```

### Orders

```dart
final order = await client.orders.create(
  OrderInput(
    items: [const CartItemInput(productId: 'product-id', quantity: 1)],
    shippingAddress: const ShippingAddressInput(
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

### Admin product

```dart
final product = await client.admin.createProduct(
  const AdminProductCreateRequest(
    name: 'Wireless Mouse',
    sku: 'WM-001',
    basePrice: 500,
    categoryId: 'category-id',
    status: ProductStatus.draft,
    inventoryQuantity: 10,
  ),
);
```

النماذج الإدارية تشمل كذلك `TaxonomyCreateRequest`, `CouponRequest`, `WalletRequest`, `TagRequest`, `InventoryAdjustment`, `OrderTransitionRequest`, `ReviewModerationRequest`, `PaymentProviderSettingsRequest`, `ShippingZoneRequest`, `ShippingCountryCreateRequest`, `ShippingGovernorateCreateRequest`, `HeroSlideCreateRequest`, و`HeroSlideReorderRequest`.

## Response وerrors

كل method typed يرجع `ApiResponse<T>` مع `success`, `data`, `statusCode`, `headers`, `meta`, `pagination`, و`raw`. عند تفعيل `throwOnApiError`، يرمي SDK `ApiException` تحتوي على `statusCode`, `code`, `message`, و`details` عند HTTP errors أو standard error envelope.

```dart
try {
  await client.publicApi.getProduct('missing-product');
} on ApiException catch (error) {
  print('${error.statusCode}: ${error.code} ${error.message}');
}
```

يتم تشغيل `validateOrThrow()` تلقائيًا لأي `JsonModel` قبل الإرسال. ويمكن تشغيل `request.validate()` يدويًا لاكتشاف كل `ValidationIssue` قبل تنفيذ العملية.

## Reliability وheaders

يضيف transport تلقائيًا `Accept: application/json` و`Content-Type` عند JSON bodies و`Authorization: Bearer` عند توفر token، ويحفظ cookies، ويدعم `idempotency-key`، ويعيد المحاولة bounded للطلبات read-only عند أخطاء الشبكة و`408/425/429/5xx`. عمليات POST/PUT/PATCH/DELETE لا تُعاد تلقائيًا إلا عند تفعيل `retryUnsafeRequests` صراحةً.

## كل routes موجودة

`client.api` و`ecommercePlatformOperations` مبنيان من route inventory موثق. كل method مولد له path parameters مسماة typed مثل `id`, `code`, `provider`, و`paymentId`، وجميع العمليات الـ 135 موجودة في `lib/src/generated_api.dart`. ملف `openapi.yaml` يقدم نفس coverage بصيغة OpenAPI 3.1.

## LLM وAI-agent integration

المجلد `ai/` يضم `agent-tools.json` لكل العمليات، و`safe-tools.json` و`openai-tools.json` للأدوات الآمنة، و`system-prompt.md`، و`README.md`. توجد كذلك `llms.txt` في جذر الحزمة للاكتشاف الآلي. السياسة الافتراضية هي أن GET/HEAD/OPTIONS read-only، وأن كل POST/PUT/PATCH/DELETE يحتاج human confirmation، مع إبقاء secrets خارج arguments.

## الاختبار والتوثيق

```bash
dart analyze
dart test
dart run tool/production_smoke.dart
dart pub publish --dry-run
```

`tool/production_smoke.dart` يختبر deployment الحقيقي بعمليات آمنة، و`PRODUCTION_VALIDATION.md` يسجل آخر نتائج الإنتاج وحدود ما تم اختباره. لا ينفذ smoke test إنشاء order أو دفعًا أو تعديلًا إداريًا.

## أهم الملفات

| الملف | المسؤولية |
|---|---|
| `lib/ecommerce_platform_api.dart` | public exports وfacade. |
| `lib/src/typed_clients.dart` | domain clients والـ typed convenience methods. |
| `lib/src/models.dart` | models العامة، catalog، cart، checkout، auth، account، orders. |
| `lib/src/admin_models.dart` | models الإدارية الصارمة. |
| `lib/src/api_client.dart` | HTTP، auth، cookies، retries، headers، decoders، errors. |
| `lib/src/generated_api.dart` | جميع العمليات الـ 135. |
| `openapi.yaml` | contract كامل للـ API. |
| `ai/` و`llms.txt` | تكامل LLMs وAI agents. |

استخدم `client.close()` عند انتهاء عمر التطبيق أو عند التخلص من dependency scope.
