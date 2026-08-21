# تقرير استخدام Ecommerce Platform Dart SDK وNative APIs

**الإصدار الموثق:** `0.3.0`  
**مرجع العقد:** backend commit `b54db56f66ea6e3db2adcf08cf9e8c512f211801`
**نطاق التقرير:** Dart SDK، REST/Native APIs، وتحديثات التسعير والشحن والمالية الأخيرة.

## الملخص التنفيذي

توفّر الحزمة واجهة Dart typed فوق Ecommerce Platform API، بحيث يتعامل التطبيق مع domain clients وrequest models بدل بناء مسارات HTTP أو JSON يدويًا. يغطي الإصدار `0.3.0` عدد **138 عملية**، بما في ذلك عمليتا الاسترجاع/الرد المالي (`POST /api/v1/admin/orders/{id}/returns`) والتسوية المالية (`GET /api/v1/admin/commerce/reconciliation`). كما تعرض نماذج quote وorder الآن حقول snapshot المالية الضرورية لعرض الخصومات، الإيراد المعترف به، المبالغ المدفوعة والمستردة، COGS، والربح الإجمالي دون الرجوع إلى catalog الحالي.

> **قاعدة التشغيل:** يكون الخادم هو مصدر الحقيقة للسعر والشحن والضريبة والحالة المالية. لا ينبغي للتطبيق حساب الإجمالي أو تطبيق قاعدة شحن مجاني محلية.

## متى تستخدم SDK ومتى تستخدم Native API

| الخيار | الأنسب له | الميزة | ملاحظة تشغيلية |
|---|---|---|---|
| Dart SDK typed clients | Flutter/Dart mobile وserver apps | نماذج typed، أخطاء موحّدة، cookies، bearer token، retries محدودة | المسار المفضّل لمعظم التكاملات. |
| `client.api` | route غير مغطى بواجهة domain مريحة | تغطية كاملة للعمليات مع path parameters مسماة | استخدمه مؤقتًا ثم أضف facade typed عند تكرار الاستخدام. |
| Native REST API | iOS/Android native، web، integrations غير Dart | لا يعتمد على runtime Dart | طبّق envelope وauth وidempotency نفسها. |

## مسار التطبيق الموصى به

| المرحلة | SDK | Native API | قاعدة الصحة |
|---|---|---|---|
| المصادقة | `client.auth.signIn()` أو cookie store | Better Auth endpoints | لا تسجل tokens أو cookies. |
| catalog | `client.publicApi.listProducts()` | `GET /api/v1/products` | السعر المعروض تمهيدي فقط. |
| الشحن والـ quote | `client.checkout.quote()` | `POST /api/v1/checkout/quote` | اختر الدولة والعنوان ثم طريقة من `availableShippingMethods`. |
| الطلب | `client.orders.create()` | `POST /api/v1/orders` | استخدم `idempotency-key` فريدًا. |
| الإلغاء المبكر | `client.account.cancelOrder()` | `POST /api/v1/account/orders/{id}/cancel` | الخادم يعالج المخزون والحالة المالية. |
| استرجاع بعد التسليم | `client.admin.createReturnAndRefund()` | `POST /api/v1/admin/orders/{id}/returns` | أرسل `orderItemId` وكمية لا تتجاوز المتاح. |
| مراجعة الدقة | `client.admin.reconcileCommerce()` | `GET /api/v1/admin/commerce/reconciliation` | افحص report قبل معالجة أي discrepancy يدويًا. |

## مثال Dart: Quote ثم اختيار الشحن

```dart
final initialQuote = await client.checkout.quote(
  CheckoutQuoteRequest(
    items: [const CartItemInput(productId: 'product-id', quantity: 1)],
    shippingAddress: const ShippingAddressInput(
      fullName: 'Customer Name',
      phone: '+201000000000',
      addressLine1: 'Street 1',
      city: 'Cairo',
      country: 'EG',
    ),
  ),
);

final method = initialQuote.data!.availableShippingMethods.first;
final finalQuote = await client.checkout.quote(
  CheckoutQuoteRequest(
    items: [const CartItemInput(productId: 'product-id', quantity: 1)],
    shippingAddress: const ShippingAddressInput(
      fullName: 'Customer Name',
      phone: '+201000000000',
      addressLine1: 'Street 1',
      city: 'Cairo',
      country: 'EG',
    ),
    shippingMethodId: method.id,
  ),
);
```

## مثال Native API: استرجاع وردّ مالي

```http
POST /api/v1/admin/orders/order-id/returns HTTP/1.1
Authorization: Bearer <admin-token>
Idempotency-Key: return-2026-00000001
Content-Type: application/json

{
  "items": [{"orderItemId": "order-item-id", "quantity": 1}],
  "reason": "Damaged on delivery",
  "idempotencyKey": "return-2026-00000001"
}
```

تُنشئ العملية سجلات return/refund وpayment transaction وfinancial events داخل الخادم. لا تُنشئ refund محليًا ولا تغيّر stock من تطبيق العميل.

## اعتبارات الاعتمادية والأمان

يطلب transport استخدام HTTPS افتراضيًا، ويحفظ cookies عند استخدام Better Auth، ويضيف authorization وidempotency headers عند الحاجة. يعيد المحاولات تلقائيًا للقراءات فقط، بينما عمليات الكتابة مثل order وrefund لا يعاد تنفيذها إلا إذا تم تفعيل ذلك صراحةً. بالنسبة لعمليات الإدارة والاسترجاع، يجب أن يبقى قرار التنفيذ في يد مستخدم مخوّل مع confirmation واضح في واجهة التطبيق.

## التحقق المنفذ

تمت مطابقة inventory الخادم مع manifest وOpenAPI الخاصين بالـ SDK: **138 عملية HTTP** عبر **85 ملف route**. يلزم تشغيل `dart format lib test` و`dart analyze lib test` و`dart test` في CI أو بيئة Dart قبل الدمج؛ لم تكن أداة Dart مثبتة في بيئة التنفيذ الحالية، لذلك لا أدرج نتيجة اختبار غير منفذة.

## مراجع

[1]: https://github.com/MohammedAydan/ecommerce-platform-dart-api — مستودع Dart SDK
[2]: https://github.com/MohammedAydan/ecommerce-platform — مستودع Ecommerce Platform backend
