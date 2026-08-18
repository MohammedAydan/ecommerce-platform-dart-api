# AI and Agent Integration

هذه الملفات تجعل مكتبة Ecommerce Platform قابلة للاستخدام من LLMs وAI agents بدون تخمين أسماء الحقول أو المسارات. مصدر الحقيقة هو `openapi.yaml` و`agent-tools.json`، وكلاهما مولد من route inventory المثبت في commit `ca7306ec4faae13979af256cd818723e897b02e4`.

## الملفات

| الملف | الاستخدام |
|---|---|
| `agent-tools.json` | كتالوج كامل لـ 135 عملية مع method وpath وparameters وDart method وقرار read-only/confirmation. |
| `safe-tools.json` | كتالوج الأدوات الآمنة غير المدمرة المناسبة افتراضيًا للـ agents. |
| `openai-tools.json` | تعريفات function-calling بصيغة OpenAI-compatible للأدوات الآمنة. |
| `system-prompt.md` | تعليمات تشغيل جاهزة للـ agent مع قواعد auth والخصوصية والتأكيد. |
| `../openapi.yaml` | عقد OpenAPI كامل قابل للتحميل في أدوات API clients وagent frameworks. |

## سياسة التنفيذ

الـ agent يجب أن يبدأ بأدوات القراءة فقط. أي عملية POST أو PUT أو PATCH أو DELETE تعتبر mutation حتى لو كان أثرها محدودًا، ويجب عرض ملخص العملية وطلب تأكيد بشري صريح قبل التنفيذ. لا يجوز للـ agent إنشاء order أو بدء payment أو تعديل admin resources أو رفع media دون هذا التأكيد.

لا يجب أبدًا إرسال access tokens أو session cookies أو payment secrets إلى model prompt. يتم حقنها داخل `EcommercePlatformClient` من خلال `AuthTokenProvider` أو `CookieStore`، وتبقى خارج tool arguments.

## الاستخدام من Dart

```dart
final cookieStore = MemoryCookieStore();
final sdk = EcommercePlatformClient(
  baseUrl: 'https://ec-swart.vercel.app',
  cookieStore: cookieStore,
);

final products = await sdk.publicApi.listProducts(
  query: const CatalogQuery(search: 'wireless mouse', page: 1, limit: 10),
);

final quote = await sdk.checkout.quote(
  CheckoutQuoteRequest(
    items: [const CartItemInput(productId: 'product-id', quantity: 1)],
  ),
);
```

يوفر `sdk.api` طبقة raw متوافقة مع كل 135 عملية، بينما توفر `sdk.publicApi`, `sdk.auth`, `sdk.checkout`, `sdk.cart`, `sdk.account`, `sdk.addresses`, `sdk.orders`, و`sdk.admin` methods typed بأسماء واضحة وrequest models محددة.

## Tool calling

يستطيع agent تحميل `agent-tools.json` ثم اختيار أداة من خلال `name`. يتم تحويل arguments إلى request model المطابق داخل adapter الخاص بالتطبيق. لا يُسمح باستخدام `additionalProperties` لإضافة حقول غير موثقة في الأدوات الآمنة. عند الحاجة إلى endpoint غير موجود في safe catalog، يجب استخدام `openapi.yaml` ومراجعة `requiresHumanConfirmation` قبل التنفيذ.
