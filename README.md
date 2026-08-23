# ecommerce_platform_api

مكتبة Dart typed SDK شاملة للتعامل مع Ecommerce Platform backend. الإصدار الحالي يحوي **136 عملية HTTP** على **85 route files**، ويقدم طبقة typed سهلة للاستخدام فوق transport عام. كل استدعاءات `/api/v1` تتطلب App-Key صالحًا يتحقق منه الخادم؛ أما عمليات storefront المصنفة public فتعمل بلا Better Auth session، بينما تبقى عمليات الحساب والسلة والطلب والدفع والإدارة محمية بجلسة المستخدم والصلاحيات.

## الفكرة الأساسية

المستخدم العادي لا يحتاج إلى كتابة أسماء حقول JSON أو query parameters أو path parameters يدويًا. استخدم domain clients وrequest models؛ سيقوم Dart compiler بتحديد الحقول الصحيحة، ويقوم SDK بالتحقق من البيانات قبل إرسالها. توجد طبقة `client.api` كـ compatibility escape hatch للعمليات المولدة الأساسية، بينما أضيفت عمليات post-purchase الجديدة عبر typed domain clients؛ وهي ليست المسار الموصى به للتطبيقات الجديدة.

## التثبيت

```yaml
dependencies:
  ecommerce_platform_api:
    git:
      url: https://github.com/MohammedAydan/ecommerce-platform-dart-api.git
      ref: main
```

ثم نفّذ `dart pub get`.

## إنشاء العميل وApp-Key وAuth

يجب تمرير `AppKeyProvider` إلى العميل. يقرأ provider المفتاح من secret manager في server-to-server، أو من secure configuration في تطبيق mobile. لا تضع المفتاح داخل SDK نفسه أو source control، ولا تسجله في logs. يحقن transport تلقائيًا `X-API-Key` و`X-API-Client` في كل request ويزيل أي محاولة override من headers الخاصة بالعملية:

```dart
final client = EcommercePlatformClient(
  baseUrl: 'https://ec-swart.vercel.app',
  appKeyProvider: () async => loadFromSecretManager(),
  appClientKind: ApiClientKind.web,
);
```

في Flutter استخدم provider مبنيًا على إعداد secure dotenv الموضح في مستودع mobile، مع تذكر أن مفتاحًا موجودًا داخل APK/IPA قابل للاستخراج وإعادة الاستخدام؛ لذلك هو **app identifier/abuse-control credential** وليس سرًا حقيقيًا. لا تعتمد عليه بدل Better Auth أو rate limits أو device attestation عند الحاجة.

يدعم backend Better Auth عبر bearer token أو cookies. لا تضع token أو cookie في model prompt أو tool arguments. في تطبيقات Dart server/mobile استخدم provider أو cookie store مناسبًا:

```dart
import 'package:ecommerce_platform_api/ecommerce_platform_api.dart';

final cookieStore = MemoryCookieStore();
final client = EcommercePlatformClient(
  baseUrl: 'https://ec-swart.vercel.app',
  appKeyProvider: () async => loadFromSecretManager(),
  appClientKind: ApiClientKind.web,
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

// Public catalog reads do not require this session; App-Key is still mandatory.
final products = await client.publicApi.listProducts();

final currentSession = await client.auth.session();
```

يمكن بدل ذلك تمرير `StaticAuthTokenProvider` أو provider مخصص يقرأ token من secure storage. يحتفظ `MemoryCookieStore` تلقائيًا بـ `Set-Cookie` الناتج من Better Auth، ويمكن تنفيذ `CookieStore` خاص بالتطبيق لحفظ cookies في secure storage. لا تضع API key أو token ثابتًا في package أو source repository؛ public reads لا تحتاج anonymous session، لكن App-Key يبقى إلزاميًا.

## Transport security

يفرض transport استخدام `https://` افتراضيًا، ويرفض credentials أو fragments داخل `baseUrl`. لا تستخدم `allowInsecureHttp: true` إلا مع endpoint محلي تحت سيطرة المطور أثناء debug؛ هذا الخيار غير مناسب للإنتاج لأن bearer tokens وcookies ستنتقل عبر اتصال غير مشفر. لا تطبع request headers أو tokens أو cookie values في logs، ولا تضع الأسرار داخل arguments الخاصة بأدوات AI.

## Typed domain clients

| Client | الاستخدام |
|---|---|
| `client.auth` | sign-in، sign-up، session، sign-out. |
| `client.publicApi` | products، categories، brands، hero، commerce country، shipping، payment methods، reviews؛ هذه قراءات storefront public وظيفيًا، ولا تحتاج user session، لكن App-Key إلزامي. |
| `client.checkout` | quote authoritative للتسعير والخصومات والشحن والضرائب. |
| `client.cart` | قراءة وإضافة وتعديل ومسح ودمج guest/authenticated cart. |
| `client.account` | profile، settings، security، sessions، account orders، account reviews، customer returns، receipts. |
| `client.addresses` | list/create/update/delete/set-default. |
| `client.orders` | create/list/get مع idempotency key. |
| `client.admin` | typed product/taxonomy/coupon/tag/order/review/user/role/payment/shipping/hero operations، وإدارة returns/refunds وshipments وfinancial reconciliation. |
| `client.api` | طبقة raw المولدة للعمليات الأساسية؛ استخدم typed clients للـ returns وreceipts وshipments وPaymob. |

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
    // لا يظهر سعر الشحن قبل اختيار طريقة متاحة للعنوان.
    shippingMethodId: 'selected-shipping-method-id',
    commerceContext: const CommerceContextInput(
      countryCode: 'EG',
      currency: 'EGP',
    ),
  ),
);

final total = quote.data?.total;
final currency = quote.data?.currency;
```

استخدم `availableShippingMethods` من الـ quote نفسه لعرض طرق الشحن المؤهلة، ثم أعد طلب quote مع `shippingMethodId` الذي اختاره العميل. لا تحسب شحنًا مجانيًا أو رسومًا افتراضية داخل التطبيق.

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

النماذج الإدارية تشمل كذلك `TaxonomyCreateRequest`, `CouponRequest`, `TagRequest`, `InventoryAdjustment`, `OrderTransitionRequest`, `ReturnLineRequest`, `ReturnRefundRequest`, `ReviewModerationRequest`, `PaymentProviderSettingsRequest`, `ShippingZoneRequest`, `ShippingCountryCreateRequest`, `ShippingGovernorateCreateRequest`, `HeroSlideCreateRequest`, و`HeroSlideReorderRequest`.

### Admin returns, refunds, and reconciliation

عمليات الاسترجاع تستعمل order-item snapshots الموجودة في الخادم. لا تعيد حساب السعر أو التكلفة من catalog الحالي. أرسل فقط الكميات المقبولة لكل line مع idempotency key فريد، ثم استخدم تقرير reconciliation لمراجعة إسقاطات الدفع والإيراد وCOGS.

```dart
final refund = await client.admin.createReturnAndRefund(
  'order-id',
  const ReturnRefundRequest(
    items: [ReturnLineRequest(orderItemId: 'order-item-id', quantity: 1)],
    reason: 'Damaged on delivery',
    idempotencyKey: 'return-2026-00000001',
  ),
);

final reconciliation = await client.admin.reconcileCommerce(
  orderId: 'order-id',
);
```

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

يضيف transport تلقائيًا `Accept: application/json` و`Content-Type` عند JSON bodies و`X-API-Key` و`X-API-Client` من provider، و`Authorization: Bearer` عند توفر token، ويحفظ cookies، ويدعم `idempotency-key`، ويعيد المحاولة bounded للطلبات read-only عند أخطاء الشبكة و`408/425/429/5xx`. إذا أعاد provider قيمة فارغة يرمي `ApiConfigurationException` قبل فتح network request. عمليات POST/PUT/PATCH/DELETE لا تُعاد تلقائيًا إلا عند تفعيل `retryUnsafeRequests` صراحةً.

## كل routes موجودة

`client.api` و`ecommercePlatformOperations` مبنيان من route inventory موثق. كل method مولد له path parameters مسماة typed مثل `id`, `code`, `provider`, و`paymentId`. ملف `openapi.yaml` يقدم coverage كاملة بصيغة OpenAPI 3.1، بينما توفر typed domain clients العمليات الجديدة الخاصة بـ returns وreceipts وshipments وPaymob؛ App-Key مطلوب لكل `/api/v1` request، وBetter Auth session/authorization مطلوبة فقط للعمليات الحساسة، مع استثناءات auth bootstrap وhealth وsigned webhooks. راجع [`API_COVERAGE.md`](./API_COVERAGE.md) للحصول على جدول كل العمليات وتفاصيل parameters وresponses ومصدر route.

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
| `lib/src/generated_api.dart` | العمليات المولدة الأساسية؛ العمليات الجديدة متاحة أيضاً عبر typed domain clients. |
| `openapi.yaml` | contract كامل للـ API. |
| `ai/` و`llms.txt` | تكامل LLMs وAI agents. |

استخدم `client.close()` عند انتهاء عمر التطبيق أو عند التخلص من dependency scope.
