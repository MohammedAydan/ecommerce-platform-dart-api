import 'models.dart';
import 'types.dart';

class TaxonomyTranslations extends JsonModel {
  const TaxonomyTranslations(this.values);
  final Map<String, JsonMap> values;
  @override
  JsonMap toJson() => values;
}

class TaxonomyCreateRequest extends JsonModel {
  const TaxonomyCreateRequest({
    required this.name,
    this.slug,
    this.description,
    this.imageUrl,
    this.logoUrl,
    this.parentId,
    this.translations,
  });
  final String name;
  final String? slug;
  final String? description;
  final String? imageUrl;
  final String? logoUrl;
  final String? parentId;
  final TaxonomyTranslations? translations;
  @override
  JsonMap toJson() => {
        'name': name,
        if (slug != null) 'slug': slug,
        if (description != null) 'description': description,
        if (imageUrl != null) 'imageUrl': imageUrl,
        if (logoUrl != null) 'logoUrl': logoUrl,
        if (parentId != null) 'parentId': parentId,
        if (translations != null) 'translations': translations!.toJson(),
      };
  @override
  List<ValidationIssue> validate() => [
        if (name.trim().isEmpty)
          const ValidationIssue(field: 'name', message: 'Cannot be empty'),
      ];
}

class TaxonomyUpdateRequest extends JsonModel {
  const TaxonomyUpdateRequest({
    this.name,
    this.slug,
    this.description,
    this.imageUrl,
    this.logoUrl,
    this.parentId,
    this.isActive,
    this.translations,
  });
  final String? name;
  final String? slug;
  final String? description;
  final String? imageUrl;
  final String? logoUrl;
  final String? parentId;
  final bool? isActive;
  final TaxonomyTranslations? translations;
  @override
  JsonMap toJson() => {
        if (name != null) 'name': name,
        if (slug != null) 'slug': slug,
        if (description != null) 'description': description,
        if (imageUrl != null) 'imageUrl': imageUrl,
        if (logoUrl != null) 'logoUrl': logoUrl,
        if (parentId != null) 'parentId': parentId,
        if (isActive != null) 'isActive': isActive,
        if (translations != null) 'translations': translations!.toJson(),
      };
}

class ProductImageInput extends JsonModel {
  const ProductImageInput({
    required this.url,
    this.altText,
    this.isPrimary,
    this.sortOrder,
  });
  final String url;
  final String? altText;
  final bool? isPrimary;
  final int? sortOrder;
  @override
  JsonMap toJson() => {
        'url': url,
        if (altText != null) 'altText': altText,
        if (isPrimary != null) 'isPrimary': isPrimary,
        if (sortOrder != null) 'sortOrder': sortOrder,
      };
}

class ProductContentTranslation extends JsonModel {
  const ProductContentTranslation({
    required this.locale,
    required this.name,
    required this.description,
    this.shortDescription,
  });
  final AppLocale locale;
  final String name;
  final String description;
  final String? shortDescription;
  @override
  JsonMap toJson() => {
        'locale': locale == AppLocale.ar ? 'ar' : 'en',
        'name': name,
        'description': description,
        if (shortDescription != null) 'shortDescription': shortDescription,
      };
}

class AdminProductCreateRequest extends JsonModel {
  const AdminProductCreateRequest({
    required this.name,
    required this.sku,
    required this.basePrice,
    required this.categoryId,
    this.slug,
    this.description,
    this.shortDescription,
    this.compareAtPrice,
    this.costPrice,
    this.brandId,
    this.status,
    this.isFeatured = false,
    this.imageUrl,
    this.images = const [],
    this.inventoryQuantity,
    this.reorderPoint,
    this.tagIds = const [],
    this.translations = const [],
  });
  final String name;
  final String sku;
  final num basePrice;
  final String categoryId;
  final String? slug;
  final String? description;
  final String? shortDescription;
  final num? compareAtPrice;
  final num? costPrice;
  final String? brandId;
  final ProductStatus? status;
  final bool isFeatured;
  final String? imageUrl;
  final List<ProductImageInput> images;
  final int? inventoryQuantity;
  final int? reorderPoint;
  final List<String> tagIds;
  final List<ProductContentTranslation> translations;
  @override
  JsonMap toJson() => {
        'name': name,
        if (slug != null) 'slug': slug,
        if (description != null) 'description': description,
        if (shortDescription != null) 'shortDescription': shortDescription,
        'sku': sku,
        'basePrice': basePrice,
        if (compareAtPrice != null) 'compareAtPrice': compareAtPrice,
        if (costPrice != null) 'costPrice': costPrice,
        'categoryId': categoryId,
        if (brandId != null) 'brandId': brandId,
        if (status != null) 'status': _adminProductStatusValue(status!),
        'isFeatured': isFeatured,
        if (imageUrl != null) 'imageUrl': imageUrl,
        if (images.isNotEmpty)
          'images': images.map((item) => item.toJson()).toList(),
        if (inventoryQuantity != null) 'inventoryQuantity': inventoryQuantity,
        if (reorderPoint != null) 'reorderPoint': reorderPoint,
        'tagIds': tagIds,
        if (translations.isNotEmpty)
          'translations': translations.map((item) => item.toJson()).toList(),
      };
  @override
  List<ValidationIssue> validate() => [
        if (name.trim().isEmpty)
          const ValidationIssue(field: 'name', message: 'Cannot be empty'),
        if (sku.trim().isEmpty)
          const ValidationIssue(field: 'sku', message: 'Cannot be empty'),
        if (basePrice < 0)
          const ValidationIssue(
              field: 'basePrice', message: 'Cannot be negative'),
        if (categoryId.trim().isEmpty)
          const ValidationIssue(
              field: 'categoryId', message: 'Cannot be empty'),
        if (inventoryQuantity != null && inventoryQuantity! < 0)
          const ValidationIssue(
            field: 'inventoryQuantity',
            message: 'Cannot be negative',
          ),
        if (reorderPoint != null && reorderPoint! < 0)
          const ValidationIssue(
            field: 'reorderPoint',
            message: 'Cannot be negative',
          ),
      ];
}

class AdminProductUpdateRequest extends JsonModel {
  const AdminProductUpdateRequest({
    required this.id,
    this.name,
    this.slug,
    this.description,
    this.shortDescription,
    this.sku,
    this.basePrice,
    this.compareAtPrice,
    this.costPrice,
    this.categoryId,
    this.brandId,
    this.status,
    this.isFeatured,
    this.images,
    this.inventoryQuantity,
    this.reorderPoint,
    this.tagIds,
    this.translations,
  });
  final String id;
  final String? name;
  final String? slug;
  final String? description;
  final String? shortDescription;
  final String? sku;
  final num? basePrice;
  final num? compareAtPrice;
  final num? costPrice;
  final String? categoryId;
  final String? brandId;
  final ProductStatus? status;
  final bool? isFeatured;
  final List<ProductImageInput>? images;
  final int? inventoryQuantity;
  final int? reorderPoint;
  final List<String>? tagIds;
  final List<ProductContentTranslation>? translations;
  @override
  JsonMap toJson() => {
        'id': id,
        if (name != null) 'name': name,
        if (slug != null) 'slug': slug,
        if (description != null) 'description': description,
        if (shortDescription != null) 'shortDescription': shortDescription,
        if (sku != null) 'sku': sku,
        if (basePrice != null) 'basePrice': basePrice,
        if (compareAtPrice != null) 'compareAtPrice': compareAtPrice,
        if (costPrice != null) 'costPrice': costPrice,
        if (categoryId != null) 'categoryId': categoryId,
        if (brandId != null) 'brandId': brandId,
        if (status != null) 'status': _adminProductStatusValue(status!),
        if (isFeatured != null) 'isFeatured': isFeatured,
        if (images != null)
          'images': images!.map((item) => item.toJson()).toList(),
        if (inventoryQuantity != null) 'inventoryQuantity': inventoryQuantity,
        if (reorderPoint != null) 'reorderPoint': reorderPoint,
        if (tagIds != null) 'tagIds': tagIds,
        if (translations != null)
          'translations': translations!.map((item) => item.toJson()).toList(),
      };
  @override
  List<ValidationIssue> validate() => [
        if (id.trim().isEmpty)
          const ValidationIssue(field: 'id', message: 'Cannot be empty'),
        if (basePrice != null && basePrice! < 0)
          const ValidationIssue(
              field: 'basePrice', message: 'Cannot be negative'),
      ];
}

class CouponRequest extends JsonModel {
  const CouponRequest({
    this.code,
    this.type,
    this.value,
    this.minOrderAmount,
    this.maxDiscountAmount,
    this.usageLimit,
    this.perUserUsageLimit,
    this.startsAt,
    this.expiresAt,
    this.scope,
    this.applicableProductIds = const [],
    this.applicableCategoryIds = const [],
    this.isFreeShipping,
    this.isActive,
  });
  final String? code;
  final CouponType? type;
  final num? value;
  final num? minOrderAmount;
  final num? maxDiscountAmount;
  final int? usageLimit;
  final int? perUserUsageLimit;
  final DateTime? startsAt;
  final DateTime? expiresAt;
  final CouponScope? scope;
  final List<String> applicableProductIds;
  final List<String> applicableCategoryIds;
  final bool? isFreeShipping;
  final bool? isActive;
  @override
  JsonMap toJson() => {
        if (code != null) 'code': code,
        if (type != null) 'type': _adminCouponTypeValue(type!),
        if (value != null) 'value': value,
        if (minOrderAmount != null) 'minOrderAmount': minOrderAmount,
        if (maxDiscountAmount != null) 'maxDiscountAmount': maxDiscountAmount,
        if (usageLimit != null) 'usageLimit': usageLimit,
        if (perUserUsageLimit != null) 'perUserUsageLimit': perUserUsageLimit,
        if (startsAt != null) 'startsAt': startsAt!.toIso8601String(),
        if (expiresAt != null) 'expiresAt': expiresAt!.toIso8601String(),
        if (scope != null) 'scope': _adminCouponScopeValue(scope!),
        'applicableProductIds': applicableProductIds,
        'applicableCategoryIds': applicableCategoryIds,
        if (isFreeShipping != null) 'isFreeShipping': isFreeShipping,
        if (isActive != null) 'isActive': isActive,
      };
}

class TagRequest extends JsonModel {
  const TagRequest({this.name, this.slug, this.isActive});
  final String? name;
  final String? slug;
  final bool? isActive;
  @override
  JsonMap toJson() => {
        if (name != null) 'name': name,
        if (slug != null) 'slug': slug,
        if (isActive != null) 'isActive': isActive,
      };
}

class OrderTransitionRequest extends JsonModel {
  const OrderTransitionRequest({
    required this.orderId,
    required this.status,
    this.reason,
  });
  final String orderId;
  final OrderStatus status;
  final String? reason;
  @override
  JsonMap toJson() => {
        'orderId': orderId,
        'status': _adminOrderStatusValue(status),
        if (reason != null) 'reason': reason,
      };
}

/// A historical order-line quantity being returned by an administrator.
class ReturnLineRequest extends JsonModel {
  const ReturnLineRequest({required this.orderItemId, required this.quantity});
  final String orderItemId;
  final int quantity;
  @override
  JsonMap toJson() => {'orderItemId': orderItemId, 'quantity': quantity};
}

enum ReturnDecision { approve, reject, receive, inspect, refund }

String _returnDecisionValue(ReturnDecision decision) => decision.name.toUpperCase();

/// Advances the same Return entity through the admin review lifecycle.
class ReturnRefundRequest extends JsonModel {
  const ReturnRefundRequest({
    this.returnId,
    this.items = const [],
    this.reason,
    this.idempotencyKey,
    this.decision = ReturnDecision.approve,
  });
  final String? returnId;
  final List<ReturnLineRequest> items;
  final String? reason;
  final String? idempotencyKey;
  final ReturnDecision decision;
  @override
  JsonMap toJson() => {
        if (returnId != null) 'returnId': returnId,
        if (items.isNotEmpty) 'items': items.map((item) => item.toJson()).toList(),
        if (reason != null) 'reason': reason,
        if (idempotencyKey != null) 'idempotencyKey': idempotencyKey,
        'decision': _returnDecisionValue(decision),
      };
}

class ReviewModerationRequest extends JsonModel {
  const ReviewModerationRequest({required this.reviewId, required this.status});
  final String reviewId;
  final String status;
  @override
  JsonMap toJson() => {'reviewId': reviewId, 'status': status};
}

class AdminUserUpdateRequest extends JsonModel {
  const AdminUserUpdateRequest({required this.name, required this.role});
  final String name;
  final UserRole role;
  @override
  JsonMap toJson() => {'name': name, 'role': _adminRoleValue(role)};
}

class RoleCreateRequest extends JsonModel {
  const RoleCreateRequest({
    required this.name,
    this.description,
    this.permissions = const [],
  });
  final String name;
  final String? description;
  final List<String> permissions;
  @override
  JsonMap toJson() => {
        'name': name,
        if (description != null) 'description': description,
        'permissions': permissions,
      };
}

class PaymentProviderSettingsRequest extends JsonModel {
  const PaymentProviderSettingsRequest({
    required this.provider,
    required this.environment,
    this.isEnabled,
    this.publicKey,
    this.integrationId,
    this.iframeId,
    this.secretKey,
    this.hmacSecret,
  });
  final String provider;
  final String environment;
  final bool? isEnabled;
  final String? publicKey;
  final String? integrationId;
  final String? iframeId;
  final String? secretKey;
  final String? hmacSecret;
  @override
  JsonMap toJson() => {
        'provider': provider,
        'environment': environment,
        if (isEnabled != null) 'isEnabled': isEnabled,
        if (publicKey != null) 'publicKey': publicKey,
        if (integrationId != null) 'integrationId': integrationId,
        if (iframeId != null) 'iframeId': iframeId,
        if (secretKey != null) 'secretKey': secretKey,
        if (hmacSecret != null) 'hmacSecret': hmacSecret,
      };
}

class ShippingRuleInput extends JsonModel {
  const ShippingRuleInput({
    required this.country,
    this.stateProvince,
    this.city,
  });
  final String country;
  final String? stateProvince;
  final String? city;
  @override
  JsonMap toJson() => {
        'country': country,
        if (stateProvince != null) 'stateProvince': stateProvince,
        if (city != null) 'city': city,
      };
}

class ShippingMethodInput extends JsonModel {
  const ShippingMethodInput({
    required this.name,
    required this.cost,
    this.currency = 'EGP',
    this.minDeliveryDays = 1,
    this.maxDeliveryDays = 3,
    this.isCodAllowed = true,
  });
  final String name;
  final num cost;
  final String currency;
  final int minDeliveryDays;
  final int maxDeliveryDays;
  final bool isCodAllowed;
  @override
  JsonMap toJson() => {
        'name': name,
        'cost': cost,
        'currency': currency,
        'minDeliveryDays': minDeliveryDays,
        'maxDeliveryDays': maxDeliveryDays,
        'isCodAllowed': isCodAllowed,
      };
}

class ShippingZoneRequest extends JsonModel {
  const ShippingZoneRequest({
    required this.name,
    this.description,
    this.isActive = true,
    this.country,
    this.stateProvince,
    this.city,
    this.cost,
    this.currency = 'EGP',
    this.minDeliveryDays = 1,
    this.maxDeliveryDays = 3,
    this.rules = const [],
    this.methods = const [],
  });
  final String name;
  final String? description;
  final bool isActive;
  final String? country;
  final String? stateProvince;
  final String? city;
  final num? cost;
  final String currency;
  final int minDeliveryDays;
  final int maxDeliveryDays;
  final List<ShippingRuleInput> rules;
  final List<ShippingMethodInput> methods;
  @override
  JsonMap toJson() => {
        'name': name,
        if (description != null) 'description': description,
        'isActive': isActive,
        if (country != null) 'country': country,
        if (stateProvince != null) 'stateProvince': stateProvince,
        if (city != null) 'city': city,
        if (cost != null) 'cost': cost,
        'currency': currency,
        'minDeliveryDays': minDeliveryDays,
        'maxDeliveryDays': maxDeliveryDays,
        'rules': rules.map((item) => item.toJson()).toList(),
        'methods': methods.map((item) => item.toJson()).toList(),
      };
}

class ShippingCountryCreateRequest extends JsonModel {
  const ShippingCountryCreateRequest({
    required this.code,
    required this.name,
    this.sortOrder = 0,
    this.taxRate = 0,
    this.paymentMethods,
    this.isActive = true,
    this.taxInclusive = false,
    this.roundingMode = CurrencyRoundingMode.halfEven,
    this.isStorefrontEnabled = true,
    this.isSaleEnabled = true,
    this.isDefault = false,
  });
  final String code;
  final String name;
  final int sortOrder;
  final num taxRate;
  final JsonMap? paymentMethods;
  final bool isActive;
  final bool taxInclusive;
  final CurrencyRoundingMode roundingMode;
  final bool isStorefrontEnabled;
  final bool isSaleEnabled;
  final bool isDefault;
  @override
  JsonMap toJson() => {
        'code': code,
        'name': name,
        'sortOrder': sortOrder,
        'taxRate': taxRate,
        if (paymentMethods != null) 'paymentMethods': paymentMethods,
        'isActive': isActive,
        'taxInclusive': taxInclusive,
        'roundingMode': _adminRoundingValue(roundingMode),
        'isStorefrontEnabled': isStorefrontEnabled,
        'isSaleEnabled': isSaleEnabled,
        'isDefault': isDefault,
      };
}

class ShippingGovernorateCreateRequest extends JsonModel {
  const ShippingGovernorateCreateRequest({
    required this.countryCode,
    required this.name,
    this.sortOrder = 0,
    this.isActive = true,
  });
  final String countryCode;
  final String name;
  final int sortOrder;
  final bool isActive;
  @override
  JsonMap toJson() => {
        'countryCode': countryCode,
        'name': name,
        'sortOrder': sortOrder,
        'isActive': isActive,
      };
}

class HeroButtonInput extends JsonModel {
  const HeroButtonInput({
    required this.label,
    required this.href,
    this.variant = HeroButtonVariant.primary,
    this.target = '_self',
  });
  final String label;
  final String href;
  final HeroButtonVariant variant;
  final String target;
  @override
  JsonMap toJson() => {
        'label': label,
        'href': href,
        'variant': _adminHeroVariantValue(variant),
        'target': target,
      };
}

class HeroSlideCreateRequest extends JsonModel {
  const HeroSlideCreateRequest({
    required this.title,
    this.badge,
    this.highlightedTitle,
    this.subtitle,
    this.description,
    this.desktopImage,
    this.mobileImage,
    this.imageAlt,
    this.contentAlignment = HeroContentAlignment.left,
    this.imagePosition = HeroImagePosition.center,
    this.overlay = HeroOverlay.dark,
    this.sortOrder = 0,
    this.isActive = true,
    this.startAt,
    this.endAt,
    this.buttons = const [],
  });
  final String title;
  final String? badge;
  final String? highlightedTitle;
  final String? subtitle;
  final String? description;
  final String? desktopImage;
  final String? mobileImage;
  final String? imageAlt;
  final HeroContentAlignment contentAlignment;
  final HeroImagePosition imagePosition;
  final HeroOverlay overlay;
  final int sortOrder;
  final bool isActive;
  final DateTime? startAt;
  final DateTime? endAt;
  final List<HeroButtonInput> buttons;
  @override
  JsonMap toJson() => {
        'title': title,
        if (badge != null) 'badge': badge,
        if (highlightedTitle != null) 'highlightedTitle': highlightedTitle,
        if (subtitle != null) 'subtitle': subtitle,
        if (description != null) 'description': description,
        if (desktopImage != null) 'desktopImage': desktopImage,
        if (mobileImage != null) 'mobileImage': mobileImage,
        if (imageAlt != null) 'imageAlt': imageAlt,
        'contentAlignment': _adminHeroAlignmentValue(contentAlignment),
        'imagePosition': _adminHeroPositionValue(imagePosition),
        'overlay': _adminHeroOverlayValue(overlay),
        'sortOrder': sortOrder,
        'isActive': isActive,
        if (startAt != null) 'startAt': startAt!.toIso8601String(),
        if (endAt != null) 'endAt': endAt!.toIso8601String(),
        'buttons': buttons.map((item) => item.toJson()).toList(),
      };
}

class HeroSlideReorderRequest extends JsonModel {
  const HeroSlideReorderRequest({required this.ids});
  final List<String> ids;
  @override
  JsonMap toJson() => {'ids': ids};
}

class ContactStatusUpdateRequest extends JsonModel {
  const ContactStatusUpdateRequest({required this.status});
  final String status;
  @override
  JsonMap toJson() => {'status': status};
}

class AccountSecurityRequest extends JsonModel {
  const AccountSecurityRequest({
    required this.action,
    this.currentPassword,
    this.newPassword,
  });
  final AccountSecurityAction action;
  final String? currentPassword;
  final String? newPassword;
  @override
  JsonMap toJson() => {
        'action': action == AccountSecurityAction.changePassword
            ? 'changePassword'
            : 'revokeAllSessions',
        if (currentPassword != null) 'currentPassword': currentPassword,
        if (newPassword != null) 'newPassword': newPassword,
      };
}

String _adminProductStatusValue(ProductStatus value) =>
    value.name.toUpperCase();
String _adminCouponTypeValue(CouponType value) => value.name.toUpperCase();
String _adminCouponScopeValue(CouponScope value) => value.name.toUpperCase();
String _adminOrderStatusValue(OrderStatus value) => value.name.toUpperCase();
String _adminRoleValue(UserRole value) =>
    value == UserRole.superAdmin ? 'SUPER_ADMIN' : value.name.toUpperCase();
String _adminRoundingValue(CurrencyRoundingMode value) =>
    value == CurrencyRoundingMode.halfUp ? 'HALF_UP' : 'HALF_EVEN';
String _adminHeroVariantValue(HeroButtonVariant value) =>
    value.name.toUpperCase();
String _adminHeroAlignmentValue(HeroContentAlignment value) =>
    value.name.toUpperCase();
String _adminHeroPositionValue(HeroImagePosition value) =>
    value.name.toUpperCase();
String _adminHeroOverlayValue(HeroOverlay value) => value.name.toUpperCase();
