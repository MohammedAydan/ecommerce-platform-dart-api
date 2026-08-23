import 'types.dart';

abstract class JsonModel {
  const JsonModel();
  JsonMap toJson();

  List<ValidationIssue> validate() => const <ValidationIssue>[];

  void validateOrThrow() {
    final issues = validate();
    if (issues.isNotEmpty) {
      throw ModelValidationException(runtimeType.toString(), issues);
    }
  }
}

class Address extends JsonModel {
  const Address({
    this.id,
    this.fullName,
    this.phone,
    this.addressLine1,
    this.addressLine2,
    this.city,
    this.state,
    this.postalCode,
    this.country,
    this.label,
    this.isDefaultShipping,
    this.isDefaultBilling,
    this.extra = const {},
  });

  final String? id;
  final String? fullName;
  final String? phone;
  final String? addressLine1;
  final String? addressLine2;
  final String? city;
  final String? state;
  final String? postalCode;
  final String? country;
  final String? label;
  final bool? isDefaultShipping;
  final bool? isDefaultBilling;
  final JsonMap extra;

  factory Address.fromJson(dynamic value) {
    final json = _map(value);
    return Address(
      id: _string(json['id']),
      fullName: _string(json['fullName']),
      phone: _string(json['phone']),
      addressLine1: _string(json['addressLine1']),
      addressLine2: _string(json['addressLine2']),
      city: _string(json['city']),
      state: _string(json['state']),
      postalCode: _string(json['postalCode']),
      country: _string(json['country']),
      label: _string(json['label']),
      isDefaultShipping: json['isDefaultShipping'] as bool?,
      isDefaultBilling: json['isDefaultBilling'] as bool?,
      extra: json,
    );
  }

  @override
  JsonMap toJson() => {
        if (id != null) 'id': id,
        if (fullName != null) 'fullName': fullName,
        if (phone != null) 'phone': phone,
        if (addressLine1 != null) 'addressLine1': addressLine1,
        if (addressLine2 != null) 'addressLine2': addressLine2,
        if (city != null) 'city': city,
        if (state != null) 'state': state,
        if (postalCode != null) 'postalCode': postalCode,
        if (country != null) 'country': country,
        if (label != null) 'label': label,
        if (isDefaultShipping != null) 'isDefaultShipping': isDefaultShipping,
        if (isDefaultBilling != null) 'isDefaultBilling': isDefaultBilling,
      };
}

class ProfilePatch extends JsonModel {
  const ProfilePatch({this.firstName, this.lastName, this.phone, this.image});

  final String? firstName;
  final String? lastName;
  final String? phone;
  final String? image;

  @override
  JsonMap toJson() => {
        if (firstName != null) 'firstName': firstName,
        if (lastName != null) 'lastName': lastName,
        if (phone != null) 'phone': phone,
        if (image != null) 'image': image,
      };
}

class AccountSettingsPatch extends JsonModel {
  const AccountSettingsPatch({
    this.emailNotifications,
    this.smsNotifications,
    this.language,
  });

  final bool? emailNotifications;
  final bool? smsNotifications;
  final String? language;

  @override
  JsonMap toJson() => {
        if (emailNotifications != null)
          'emailNotifications': emailNotifications,
        if (smsNotifications != null) 'smsNotifications': smsNotifications,
        if (language != null) 'language': language,
      };
}

class ReviewInput extends JsonModel {
  const ReviewInput({
    required this.rating,
    this.title,
    this.comment,
    this.productId,
  });

  final num rating;
  final String? title;
  final String? comment;
  final String? productId;

  @override
  JsonMap toJson() => {
        if (productId != null) 'productId': productId,
        'rating': rating,
        if (title != null) 'title': title,
        if (comment != null) 'comment': comment,
      };
}

class CartItemInput extends JsonModel {
  const CartItemInput({
    required this.productId,
    required this.quantity,
    this.variantId,
  });

  final String productId;
  final num quantity;
  final String? variantId;

  @override
  JsonMap toJson() => {
        'productId': productId,
        'quantity': quantity,
        if (variantId != null) 'variantId': variantId,
      };
}

class ShippingAddressInput extends JsonModel {
  const ShippingAddressInput({
    required this.fullName,
    required this.phone,
    required this.addressLine1,
    required this.city,
    required this.country,
    this.addressLine2,
    this.state,
    this.postalCode,
    this.email,
  });

  final String fullName;
  final String phone;
  final String addressLine1;
  final String city;
  final String country;
  final String? addressLine2;
  final String? state;
  final String? postalCode;
  final String? email;

  @override
  JsonMap toJson() => {
        'fullName': fullName,
        'phone': phone,
        'addressLine1': addressLine1,
        'city': city,
        'country': country,
        if (addressLine2 != null) 'addressLine2': addressLine2,
        if (state != null) 'state': state,
        if (postalCode != null) 'postalCode': postalCode,
        if (email != null) 'email': email,
      };
}

class OrderInput extends JsonModel {
  const OrderInput({
    required this.items,
    required this.shippingAddress,
    this.billingAddress,
    this.couponCode,
    this.shippingMethodId,
    this.paymentMethod,
  });

  final List<CartItemInput> items;
  final ShippingAddressInput shippingAddress;
  final ShippingAddressInput? billingAddress;
  final String? couponCode;
  final String? shippingMethodId;
  final PaymentMethodCode? paymentMethod;

  @override
  JsonMap toJson() => {
        'items': items.map((item) => item.toJson()).toList(),
        'shippingAddress': shippingAddress.toJson(),
        if (billingAddress != null) 'billingAddress': billingAddress!.toJson(),
        if (couponCode != null) 'couponCode': couponCode,
        if (shippingMethodId != null) 'shippingMethodId': shippingMethodId,
        if (paymentMethod != null) 'paymentMethod': _paymentMethodValue(paymentMethod!),
      };
}

class CheckoutQuoteInput extends JsonModel {
  const CheckoutQuoteInput({
    required this.items,
    this.shippingAddress,
    this.shippingMethodId,
    this.couponCode,
  });

  final List<CartItemInput> items;
  final ShippingAddressInput? shippingAddress;
  final String? shippingMethodId;
  final String? couponCode;

  @override
  JsonMap toJson() => {
        'items': items.map((item) => item.toJson()).toList(),
        if (shippingAddress != null)
          'shippingAddress': shippingAddress!.toJson(),
        if (shippingMethodId != null) 'shippingMethodId': shippingMethodId,
        if (couponCode != null) 'couponCode': couponCode,
      };
}

class Product extends JsonModel {
  const Product({
    this.id,
    this.slug,
    this.name,
    this.price,
    this.currency,
    this.extra = const {},
  });

  final String? id;
  final String? slug;
  final String? name;
  final num? price;
  final String? currency;
  final JsonMap extra;

  factory Product.fromJson(dynamic value) {
    final json = _map(value);
    return Product(
      id: _string(json['id']),
      slug: _string(json['slug']),
      name: _string(json['name']),
      price: json['price'] is num
          ? json['price'] as num
          : num.tryParse('${json['price']}'),
      currency: _string(json['currency']),
      extra: json,
    );
  }

  @override
  JsonMap toJson() => {
        ...extra,
        if (id != null) 'id': id,
        if (slug != null) 'slug': slug,
        if (name != null) 'name': name,
        if (price != null) 'price': price,
        if (currency != null) 'currency': currency,
      };
}

class Review extends JsonModel {
  const Review({
    this.id,
    this.productId,
    this.rating,
    this.title,
    this.comment,
    this.status,
    this.extra = const {},
  });

  final String? id;
  final String? productId;
  final num? rating;
  final String? title;
  final String? comment;
  final String? status;
  final JsonMap extra;

  factory Review.fromJson(dynamic value) {
    final json = _map(value);
    return Review(
      id: _string(json['id']),
      productId: _string(json['productId']),
      rating: json['rating'] is num
          ? json['rating'] as num
          : num.tryParse('${json['rating']}'),
      title: _string(json['title']),
      comment: _string(json['comment']),
      status: _string(json['status']),
      extra: json,
    );
  }

  @override
  JsonMap toJson() => {...extra};
}

class StoreBrandingResponse extends JsonModel {
  const StoreBrandingResponse({
    required this.name,
    this.logoUrl,
  });

  final String name;
  final String? logoUrl;

  factory StoreBrandingResponse.fromJson(dynamic value) {
    final json = _map(value);
    return StoreBrandingResponse(
      name: _string(json['name']) ?? '',
      logoUrl: _string(json['logoUrl']),
    );
  }

  @override
  JsonMap toJson() => {
        'name': name,
        if (logoUrl != null) 'logoUrl': logoUrl,
      };
}

class HealthStatus {
  const HealthStatus(this.value);
  final JsonMap value;
  String? get status => _string(value['status']);
  bool get isReady => status == 'ready' || status == 'ok';
  factory HealthStatus.fromJson(dynamic json) => HealthStatus(_map(json));
}

class PaymentProviderConfig extends JsonModel {
  const PaymentProviderConfig({
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

class InventoryAdjustment extends JsonModel {
  const InventoryAdjustment({
    required this.inventoryItemId,
    required this.adjustmentQty,
    this.reason,
    this.locationId,
  });

  final String inventoryItemId;
  final num adjustmentQty;
  final String? reason;
  final String? locationId;

  @override
  JsonMap toJson() => {
        'inventoryItemId': inventoryItemId,
        'adjustmentQty': adjustmentQty,
        if (reason != null) 'reason': reason,
        if (locationId != null) 'locationId': locationId,
      };
}

class HeroSlideInput extends JsonModel {
  const HeroSlideInput({
    required this.title,
    this.badge,
    this.highlightedTitle,
    this.subtitle,
    this.description,
    this.desktopImage,
    this.mobileImage,
    this.imageAlt,
    this.contentAlignment,
    this.imagePosition,
    this.overlay,
    this.sortOrder,
    this.isActive,
    this.startAt,
    this.endAt,
    this.buttons,
  });

  final String title;
  final String? badge;
  final String? highlightedTitle;
  final String? subtitle;
  final String? description;
  final String? desktopImage;
  final String? mobileImage;
  final String? imageAlt;
  final String? contentAlignment;
  final String? imagePosition;
  final String? overlay;
  final num? sortOrder;
  final bool? isActive;
  final DateTime? startAt;
  final DateTime? endAt;
  final List<JsonMap>? buttons;

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
        if (contentAlignment != null) 'contentAlignment': contentAlignment,
        if (imagePosition != null) 'imagePosition': imagePosition,
        if (overlay != null) 'overlay': overlay,
        if (sortOrder != null) 'sortOrder': sortOrder,
        if (isActive != null) 'isActive': isActive,
        if (startAt != null) 'startAt': startAt!.toIso8601String(),
        if (endAt != null) 'endAt': endAt!.toIso8601String(),
        if (buttons != null) 'buttons': buttons,
      };
}

class ShippingCountryInput extends JsonModel {
  const ShippingCountryInput({
    required this.code,
    required this.name,
    this.sortOrder,
    this.taxRate,
    this.paymentMethods,
    this.isActive,
    this.taxInclusive,
    this.roundingMode,
    this.isStorefrontEnabled,
    this.isSaleEnabled,
    this.isDefault,
  });

  final String code;
  final String name;
  final int? sortOrder;
  final num? taxRate;
  final JsonMap? paymentMethods;
  final bool? isActive;
  final bool? taxInclusive;
  final String? roundingMode;
  final bool? isStorefrontEnabled;
  final bool? isSaleEnabled;
  final bool? isDefault;

  @override
  JsonMap toJson() => {
        'code': code,
        'name': name,
        if (sortOrder != null) 'sortOrder': sortOrder,
        if (taxRate != null) 'taxRate': taxRate,
        if (paymentMethods != null) 'paymentMethods': paymentMethods,
        if (isActive != null) 'isActive': isActive,
        if (taxInclusive != null) 'taxInclusive': taxInclusive,
        if (roundingMode != null) 'roundingMode': roundingMode,
        if (isStorefrontEnabled != null)
          'isStorefrontEnabled': isStorefrontEnabled,
        if (isSaleEnabled != null) 'isSaleEnabled': isSaleEnabled,
        if (isDefault != null) 'isDefault': isDefault,
      };
}

class JsonBody extends JsonModel {
  const JsonBody(this.value);
  final JsonMap value;
  @override
  JsonMap toJson() => value;
}

JsonMap _map(dynamic value) =>
    value is JsonMap ? Map<String, dynamic>.from(value) : <String, dynamic>{};
String? _string(dynamic value) => value == null ? null : '$value';

// ---------------------------------------------------------------------------
// Strict SDK contracts
// ---------------------------------------------------------------------------

enum AppLocale { en, ar }

enum ProductStatus { draft, active, archived }

enum ProductPriceSource {
  variantCountryPrice,
  productCountryPrice,
  variantBasePrice,
  productBasePrice,
}

enum PaymentMethodCode { cod, paymob }

enum PaymentStatus {
  pending,
  authorized,
  paid,
  failed,
  cancelled,
  refunded,
  partiallyRefunded,
}

enum OrderStatus {
  pending,
  confirmed,
  processing,
  shipped,
  delivered,
  cancelled,
  returned,
}

enum CouponType { percentage, fixed }

enum CouponScope { all, product, category }

enum CurrencyRoundingMode { halfEven, halfUp }

enum HeroContentAlignment { left, center, right }

enum HeroImagePosition { left, center, right, top, bottom }

enum HeroOverlay { none, light, dark }

enum HeroButtonVariant { primary, secondary, outline, ghost }

enum UserRole { customer, admin, superAdmin }

enum AccountSecurityAction { changePassword, revokeAllSessions }

String _priceSourceValue(ProductPriceSource value) => switch (value) {
      ProductPriceSource.variantCountryPrice => 'VARIANT_COUNTRY_PRICE',
      ProductPriceSource.productCountryPrice => 'PRODUCT_COUNTRY_PRICE',
      ProductPriceSource.variantBasePrice => 'VARIANT_BASE_PRICE',
      ProductPriceSource.productBasePrice => 'PRODUCT_BASE_PRICE',
    };
String _paymentMethodValue(PaymentMethodCode value) => value.name.toUpperCase();
String _paymentStatusValue(PaymentStatus value) => value.name.toUpperCase();
String _orderStatusValue(OrderStatus value) => value.name.toUpperCase();

class CatalogQuery extends QueryModel {
  const CatalogQuery({
    this.locale,
    this.category,
    this.brand,
    this.minPrice,
    this.maxPrice,
    this.inStockOnly,
    this.search,
    this.sort,
    this.page = 1,
    this.limit = 10,
  });

  final AppLocale? locale;
  final String? category;
  final String? brand;
  final num? minPrice;
  final num? maxPrice;
  final bool? inStockOnly;
  final String? search;
  final String? sort;
  final int page;
  final int limit;

  @override
  JsonMap toQuery() => {
        if (locale != null) 'locale': _appLocaleValue(locale!),
        if (category != null) 'category': category,
        if (brand != null) 'brand': brand,
        if (minPrice != null) 'minPrice': minPrice,
        if (maxPrice != null) 'maxPrice': maxPrice,
        if (inStockOnly != null) 'inStockOnly': inStockOnly,
        if (search != null) 'search': search,
        if (sort != null) 'sort': sort,
        'page': page,
        'limit': limit,
      };

  List<ValidationIssue> validate() => [
        if (page < 1)
          const ValidationIssue(field: 'page', message: 'Must be at least 1'),
        if (limit < 1 || limit > 100)
          const ValidationIssue(
            field: 'limit',
            message: 'Must be between 1 and 100',
          ),
        if (minPrice != null && minPrice! < 0)
          const ValidationIssue(
              field: 'minPrice', message: 'Cannot be negative'),
        if (maxPrice != null && maxPrice! < 0)
          const ValidationIssue(
              field: 'maxPrice', message: 'Cannot be negative'),
        if (minPrice != null && maxPrice != null && minPrice! > maxPrice!)
          const ValidationIssue(
            field: 'price',
            message: 'minPrice cannot exceed maxPrice',
          ),
      ];
}

class AdminPageQuery extends QueryModel {
  const AdminPageQuery({
    this.page = 1,
    this.limit = 20,
    this.search,
    this.query,
    this.active,
    this.status,
    this.country,
    this.includeTranslations = false,
  });

  final int page;
  final int limit;
  final String? search;
  final String? query;
  final bool? active;
  final String? status;
  final String? country;
  final bool includeTranslations;

  @override
  JsonMap toQuery() => {
        'page': page,
        'limit': limit,
        if (search != null) 'search': search,
        if (query != null) 'q': query,
        if (active != null) 'active': active,
        if (status != null) 'status': status,
        if (country != null) 'country': country,
        if (includeTranslations) 'includeTranslations': true,
      };

  List<ValidationIssue> validate() => [
        if (page < 1)
          const ValidationIssue(field: 'page', message: 'Must be at least 1'),
        if (limit < 1 || limit > 100)
          const ValidationIssue(
            field: 'limit',
            message: 'Must be between 1 and 100',
          ),
      ];
}

class ProductVariantModel extends JsonModel {
  const ProductVariantModel({
    this.id,
    this.sku,
    this.name,
    this.price,
    this.compareAtPrice,
    this.currency,
    this.priceSource,
    this.stock,
    this.attributes = const {},
  });

  final String? id;
  final String? sku;
  final String? name;
  final num? price;
  final num? compareAtPrice;
  final String? currency;
  final ProductPriceSource? priceSource;
  final int? stock;
  final Map<String, String> attributes;

  factory ProductVariantModel.fromJson(dynamic value) {
    final json = _map(value);
    return ProductVariantModel(
      id: _string(json['id']),
      sku: _string(json['sku']),
      name: _string(json['name'] ?? json['title']),
      price: json['price'] as num?,
      compareAtPrice: json['compareAtPrice'] as num?,
      currency: _string(json['currency']),
      stock: json['stock'] is num ? (json['stock'] as num).toInt() : null,
      attributes: (json['attributes'] is Map)
          ? Map<String, String>.from(json['attributes'] as Map)
          : const {},
    );
  }

  @override
  JsonMap toJson() => {
        if (id != null) 'id': id,
        if (sku != null) 'sku': sku,
        if (name != null) 'name': name,
        if (price != null) 'price': price,
        if (compareAtPrice != null) 'compareAtPrice': compareAtPrice,
        if (currency != null) 'currency': currency,
        if (priceSource != null) 'priceSource': _priceSourceValue(priceSource!),
        if (stock != null) 'stock': stock,
        'attributes': attributes,
      };
}

class CatalogProduct extends JsonModel {
  const CatalogProduct({
    this.id,
    this.name,
    this.slug,
    this.description,
    this.price,
    this.compareAtPrice,
    this.currency,
    this.priceSource,
    this.category,
    this.brand,
    this.images = const [],
    this.tags = const [],
    this.variants = const [],
    this.stock,
    this.isAvailable,
    this.rating,
    this.reviewCount,
    this.createdAt,
    this.extra = const {},
  });

  final String? id;
  final String? name;
  final String? slug;
  final String? description;
  final num? price;
  final num? compareAtPrice;
  final String? currency;
  final ProductPriceSource? priceSource;
  final CatalogTaxonomy? category;
  final CatalogTaxonomy? brand;
  final List<String> images;
  final List<String> tags;
  final List<ProductVariantModel> variants;
  final int? stock;
  final bool? isAvailable;
  final num? rating;
  final int? reviewCount;
  final DateTime? createdAt;
  final JsonMap extra;

  factory CatalogProduct.fromJson(dynamic value) {
    final json = _map(value);
    return CatalogProduct(
      id: _string(json['id']),
      name: _string(json['name']),
      slug: _string(json['slug']),
      description: _string(json['description']),
      price: json['price'] as num?,
      compareAtPrice: json['compareAtPrice'] as num?,
      currency: _string(json['currency']),
      category: json['category'] == null
          ? null
          : CatalogTaxonomy.fromJson(json['category']),
      brand: json['brand'] == null
          ? null
          : CatalogTaxonomy.fromJson(json['brand']),
      images: _stringList(json['images']),
      tags: _stringList(json['tags']),
      variants:
          _list(json['variants']).map(ProductVariantModel.fromJson).toList(),
      stock: json['stock'] is num ? (json['stock'] as num).toInt() : null,
      isAvailable: json['isAvailable'] as bool?,
      rating: json['rating'] as num?,
      reviewCount: json['reviewCount'] is num
          ? (json['reviewCount'] as num).toInt()
          : null,
      createdAt: _date(json['createdAt']),
      extra: json,
    );
  }

  @override
  JsonMap toJson() => {
        ...extra,
        if (id != null) 'id': id,
        if (name != null) 'name': name,
        if (slug != null) 'slug': slug,
        if (description != null) 'description': description,
        if (price != null) 'price': price,
        if (compareAtPrice != null) 'compareAtPrice': compareAtPrice,
        if (currency != null) 'currency': currency,
        if (category != null) 'category': category!.toJson(),
        if (brand != null) 'brand': brand!.toJson(),
        'images': images,
        'tags': tags,
        'variants': variants.map((item) => item.toJson()).toList(),
        if (stock != null) 'stock': stock,
        if (isAvailable != null) 'isAvailable': isAvailable,
        if (rating != null) 'rating': rating,
        if (reviewCount != null) 'reviewCount': reviewCount,
        if (createdAt != null) 'createdAt': createdAt!.toIso8601String(),
      };
}

class CatalogTaxonomy extends JsonModel {
  const CatalogTaxonomy({
    this.id,
    this.name,
    this.slug,
    this.imageUrl,
    this.logoUrl,
    this.productCount,
  });

  final String? id;
  final String? name;
  final String? slug;
  final String? imageUrl;
  final String? logoUrl;
  final int? productCount;

  factory CatalogTaxonomy.fromJson(dynamic value) {
    final json = _map(value);
    final count = json['_count'];
    return CatalogTaxonomy(
      id: _string(json['id']),
      name: _string(json['name']),
      slug: _string(json['slug']),
      imageUrl: _string(json['imageUrl']),
      logoUrl: _string(json['logoUrl']),
      productCount: count is JsonMap && count['products'] is num
          ? (count['products'] as num).toInt()
          : null,
    );
  }

  @override
  JsonMap toJson() => {
        if (id != null) 'id': id,
        if (name != null) 'name': name,
        if (slug != null) 'slug': slug,
        if (imageUrl != null) 'imageUrl': imageUrl,
        if (logoUrl != null) 'logoUrl': logoUrl,
        if (productCount != null) '_count': {'products': productCount},
      };
}

class CommerceContextInput extends JsonModel {
  const CommerceContextInput({
    required this.countryCode,
    required this.currency,
    this.locale,
    this.taxInclusive,
  });

  final String countryCode;
  final String currency;
  final AppLocale? locale;
  final bool? taxInclusive;

  @override
  JsonMap toJson() => {
        'countryCode': countryCode,
        'currency': currency,
        if (locale != null) 'locale': _appLocaleValue(locale!),
        if (taxInclusive != null) 'taxInclusive': taxInclusive,
      };

  @override
  List<ValidationIssue> validate() => [
        if (countryCode.trim().length != 2)
          const ValidationIssue(
            field: 'countryCode',
            message: 'Must be a two-letter country code',
          ),
        if (currency.trim().isEmpty)
          const ValidationIssue(field: 'currency', message: 'Cannot be empty'),
      ];
}

class CheckoutQuoteRequest extends JsonModel {
  const CheckoutQuoteRequest({
    required this.items,
    this.couponCode,
    this.userId,
    this.shippingAddress,
    this.shippingMethodId,
    this.commerceContext,
  });

  final List<CartItemInput> items;
  final String? couponCode;
  final String? userId;
  final ShippingAddressInput? shippingAddress;
  final String? shippingMethodId;
  final CommerceContextInput? commerceContext;

  @override
  JsonMap toJson() => {
        'items': items.map((item) => item.toJson()).toList(),
        if (couponCode != null) 'couponCode': couponCode,
        if (userId != null) 'userId': userId,
        if (shippingAddress != null)
          'shippingAddress': shippingAddress!.toJson(),
        if (shippingMethodId != null) 'shippingMethodId': shippingMethodId,
        if (commerceContext != null)
          'commerceContext': commerceContext!.toJson(),
      };

  @override
  List<ValidationIssue> validate() => [
        if (items.isEmpty || items.length > 100)
          const ValidationIssue(
            field: 'items',
            message: 'Must contain between 1 and 100 items',
          ),
        ...items.expand((item) => item.validate()),
      ];
}

class CheckoutQuoteItem extends JsonModel {
  const CheckoutQuoteItem({
    this.productId,
    this.variantId,
    this.categoryId,
    this.unitPrice,
    this.originalUnitPrice,
    this.productDiscountType,
    this.productDiscountValue,
    this.productDiscountAmount,
    this.couponDiscountAmount,
    this.unitCost,
    this.quantity,
    this.name,
    this.variantTitle,
    this.sku,
    this.price,
    this.total,
    this.image,
    this.currency,
    this.priceSource,
  });

  final String? productId;
  final String? variantId;
  final String? categoryId;
  final num? unitPrice;
  final num? originalUnitPrice;
  final String? productDiscountType;
  final num? productDiscountValue;
  final num? productDiscountAmount;
  final num? couponDiscountAmount;
  final num? unitCost;
  final int? quantity;
  final String? name;
  final String? variantTitle;
  final String? sku;
  final num? price;
  final num? total;
  final String? image;
  final String? currency;
  final String? priceSource;

  factory CheckoutQuoteItem.fromJson(dynamic value) {
    final json = _map(value);
    return CheckoutQuoteItem(
      productId: _string(json['productId']),
      variantId: _string(json['variantId']),
      categoryId: _string(json['categoryId']),
      unitPrice: json['unitPrice'] as num?,
      originalUnitPrice: json['originalUnitPrice'] as num?,
      productDiscountType: _string(json['productDiscountType']),
      productDiscountValue: json['productDiscountValue'] as num?,
      productDiscountAmount: json['productDiscountAmount'] as num?,
      couponDiscountAmount: json['couponDiscountAmount'] as num?,
      unitCost: json['unitCost'] as num?,
      quantity:
          json['quantity'] is num ? (json['quantity'] as num).toInt() : null,
      name: _string(json['name']),
      variantTitle: _string(json['variantTitle']),
      sku: _string(json['sku']),
      price: json['price'] as num?,
      total: json['total'] as num?,
      image: _string(json['image']),
      currency: _string(json['currency']),
      priceSource: _string(json['priceSource']),
    );
  }

  @override
  JsonMap toJson() => {
        if (productId != null) 'productId': productId,
        if (variantId != null) 'variantId': variantId,
        if (categoryId != null) 'categoryId': categoryId,
        if (unitPrice != null) 'unitPrice': unitPrice,
        if (originalUnitPrice != null) 'originalUnitPrice': originalUnitPrice,
        if (productDiscountType != null)
          'productDiscountType': productDiscountType,
        if (productDiscountValue != null)
          'productDiscountValue': productDiscountValue,
        if (productDiscountAmount != null)
          'productDiscountAmount': productDiscountAmount,
        if (couponDiscountAmount != null)
          'couponDiscountAmount': couponDiscountAmount,
        if (unitCost != null) 'unitCost': unitCost,
        if (quantity != null) 'quantity': quantity,
        if (name != null) 'name': name,
        if (variantTitle != null) 'variantTitle': variantTitle,
        if (sku != null) 'sku': sku,
        if (price != null) 'price': price,
        if (total != null) 'total': total,
        if (image != null) 'image': image,
        if (currency != null) 'currency': currency,
        if (priceSource != null) 'priceSource': priceSource,
      };
}

class ShippingOptionModel extends JsonModel {
  const ShippingOptionModel({
    this.id,
    this.name,
    this.cost,
    this.minDeliveryDays,
    this.maxDeliveryDays,
    this.isCodAllowed,
    this.currency,
  });

  final String? id;
  final String? name;
  final num? cost;
  final int? minDeliveryDays;
  final int? maxDeliveryDays;
  final bool? isCodAllowed;
  final String? currency;

  factory ShippingOptionModel.fromJson(dynamic value) {
    final json = _map(value);
    return ShippingOptionModel(
      id: _string(json['id']),
      name: _string(json['name']),
      cost: json['cost'] as num? ?? json['shippingFee'] as num?,
      minDeliveryDays: json['minDeliveryDays'] is num
          ? (json['minDeliveryDays'] as num).toInt()
          : null,
      maxDeliveryDays: json['maxDeliveryDays'] is num
          ? (json['maxDeliveryDays'] as num).toInt()
          : null,
      isCodAllowed: json['isCodAllowed'] as bool?,
      currency: _string(json['currency']),
    );
  }

  @override
  JsonMap toJson() => {
        if (id != null) 'id': id,
        if (name != null) 'name': name,
        if (cost != null) 'cost': cost,
        if (minDeliveryDays != null) 'minDeliveryDays': minDeliveryDays,
        if (maxDeliveryDays != null) 'maxDeliveryDays': maxDeliveryDays,
        if (isCodAllowed != null) 'isCodAllowed': isCodAllowed,
        if (currency != null) 'currency': currency,
      };
}

class CheckoutQuote extends JsonModel {
  const CheckoutQuote({
    this.items = const [],
    this.subtotal,
    this.shipping,
    this.discount,
    this.tax,
    this.taxRate,
    this.total,
    this.currency,
    this.countryCode,
    this.isFreeShipping,
    this.couponDiscount,
    this.couponError,
    this.shippingMethodId,
    this.shippingMethodName,
    this.deliveryMinDays,
    this.deliveryMaxDays,
    this.shippingIsCodAllowed,
    this.availableShippingMethods = const [],
  });

  final List<CheckoutQuoteItem> items;
  final num? subtotal;
  final num? shipping;
  final num? discount;
  final num? tax;
  final num? taxRate;
  final num? total;
  final String? currency;
  final String? countryCode;
  final bool? isFreeShipping;
  final num? couponDiscount;
  final String? couponError;
  final String? shippingMethodId;
  final String? shippingMethodName;
  final int? deliveryMinDays;
  final int? deliveryMaxDays;
  final bool? shippingIsCodAllowed;
  final List<ShippingOptionModel> availableShippingMethods;

  factory CheckoutQuote.fromJson(dynamic value) {
    final json = _map(value);
    return CheckoutQuote(
      items: _list(json['items']).map(CheckoutQuoteItem.fromJson).toList(),
      subtotal: json['subtotal'] as num?,
      shipping: json['shipping'] as num?,
      discount: json['discount'] as num?,
      tax: json['tax'] as num?,
      taxRate: json['taxRate'] as num?,
      total: json['total'] as num?,
      currency: _string(json['currency']),
      countryCode: _string(json['countryCode']),
      isFreeShipping: json['isFreeShipping'] as bool?,
      couponDiscount: json['couponDiscount'] as num?,
      couponError: _string(json['couponError']),
      shippingMethodId: _string(json['shippingMethodId']),
      shippingMethodName: _string(json['shippingMethodName']),
      deliveryMinDays: json['deliveryMinDays'] is num
          ? (json['deliveryMinDays'] as num).toInt()
          : null,
      deliveryMaxDays: json['deliveryMaxDays'] is num
          ? (json['deliveryMaxDays'] as num).toInt()
          : null,
      shippingIsCodAllowed: json['shippingIsCodAllowed'] as bool?,
      availableShippingMethods: _list(json['availableShippingMethods'])
          .map(ShippingOptionModel.fromJson)
          .toList(),
    );
  }

  @override
  JsonMap toJson() => {
        'items': items.map((item) => item.toJson()).toList(),
        if (subtotal != null) 'subtotal': subtotal,
        if (shipping != null) 'shipping': shipping,
        if (discount != null) 'discount': discount,
        if (tax != null) 'tax': tax,
        if (taxRate != null) 'taxRate': taxRate,
        if (total != null) 'total': total,
        if (currency != null) 'currency': currency,
        if (countryCode != null) 'countryCode': countryCode,
        if (isFreeShipping != null) 'isFreeShipping': isFreeShipping,
        if (couponDiscount != null) 'couponDiscount': couponDiscount,
        if (couponError != null) 'couponError': couponError,
        if (shippingMethodId != null) 'shippingMethodId': shippingMethodId,
        if (shippingMethodName != null)
          'shippingMethodName': shippingMethodName,
        if (deliveryMinDays != null) 'deliveryMinDays': deliveryMinDays,
        if (deliveryMaxDays != null) 'deliveryMaxDays': deliveryMaxDays,
        if (shippingIsCodAllowed != null)
          'shippingIsCodAllowed': shippingIsCodAllowed,
        'availableShippingMethods':
            availableShippingMethods.map((item) => item.toJson()).toList(),
      };
}

class SignInRequest extends JsonModel {
  const SignInRequest({required this.email, required this.password});
  final String email;
  final String password;
  @override
  JsonMap toJson() => {'email': email, 'password': password};
  @override
  List<ValidationIssue> validate() => [
        if (!email.contains('@'))
          const ValidationIssue(
              field: 'email', message: 'Must be a valid email'),
        if (password.isEmpty)
          const ValidationIssue(field: 'password', message: 'Cannot be empty'),
      ];
}

class SignUpRequest extends JsonModel {
  const SignUpRequest({
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
  });
  final String email;
  final String password;
  final String firstName;
  final String lastName;
  @override
  JsonMap toJson() => {
        'email': email,
        'password': password,
        'name': '${firstName.trim()} ${lastName.trim()}'.trim(),
      };
  @override
  List<ValidationIssue> validate() => [
        if (!email.contains('@'))
          const ValidationIssue(
              field: 'email', message: 'Must be a valid email'),
        if (password.length < 8)
          const ValidationIssue(
            field: 'password',
            message: 'Must contain at least 8 characters',
          ),
        if (firstName.trim().isEmpty)
          const ValidationIssue(field: 'firstName', message: 'Cannot be empty'),
        if (lastName.trim().isEmpty)
          const ValidationIssue(field: 'lastName', message: 'Cannot be empty'),
      ];
}

class AuthUser extends JsonModel {
  const AuthUser({
    this.id,
    this.name,
    this.email,
    this.image,
    this.role,
    this.status,
    this.isAnonymous,
    this.firstName,
    this.lastName,
  });
  final String? id;
  final String? name;
  final String? email;
  final String? image;
  final UserRole? role;
  final String? status;
  final bool? isAnonymous;
  final String? firstName;
  final String? lastName;
  factory AuthUser.fromJson(dynamic value) {
    final json = _map(value);
    return AuthUser(
      id: _string(json['id']),
      name: _string(json['name']),
      email: _string(json['email']),
      image: _string(json['image']),
      status: _string(json['status']),
      isAnonymous: json['isAnonymous'] is bool ? json['isAnonymous'] as bool : null,
      firstName: _string(json['firstName']),
      lastName: _string(json['lastName']),
    );
  }
  @override
  JsonMap toJson() => {
        if (id != null) 'id': id,
        if (name != null) 'name': name,
        if (email != null) 'email': email,
        if (image != null) 'image': image,
        if (status != null) 'status': status,
        if (isAnonymous != null) 'isAnonymous': isAnonymous,
        if (firstName != null) 'firstName': firstName,
        if (lastName != null) 'lastName': lastName,
      };
}

class AuthSession extends JsonModel {
  const AuthSession({this.user, this.session, this.token});
  final AuthUser? user;
  final SessionSummary? session;
  final String? token;
  factory AuthSession.fromJson(dynamic value) {
    final json = _map(value);
    return AuthSession(
      user: json['user'] == null ? null : AuthUser.fromJson(json['user']),
      session: json['session'] == null
          ? null
          : SessionSummary.fromJson(json['session']),
      token: _string(json['token']),
    );
  }
  @override
  JsonMap toJson() => {
        if (user != null) 'user': user!.toJson(),
        if (session != null) 'session': session!.toJson(),
        if (token != null) 'token': token,
      };
}

class SessionSummary extends JsonModel {
  const SessionSummary({
    this.id,
    this.createdAt,
    this.expiresAt,
    this.ipAddress,
    this.userAgent,
    this.browser,
    this.os,
    this.device,
    this.isCurrent,
  });
  final String? id;
  final DateTime? createdAt;
  final DateTime? expiresAt;
  final String? ipAddress;
  final String? userAgent;
  final String? browser;
  final String? os;
  final String? device;
  final bool? isCurrent;
  factory SessionSummary.fromJson(dynamic value) {
    final json = _map(value);
    return SessionSummary(
      id: _string(json['id']),
      createdAt: _date(json['createdAt']),
      expiresAt: _date(json['expiresAt']),
      ipAddress: _string(json['ipAddress']),
      userAgent: _string(json['userAgent']),
      browser: _string(json['browser']),
      os: _string(json['os']),
      device: _string(json['device']),
      isCurrent: json['isCurrent'] as bool?,
    );
  }
  @override
  JsonMap toJson() => {
        if (id != null) 'id': id,
        if (createdAt != null) 'createdAt': createdAt!.toIso8601String(),
        if (expiresAt != null) 'expiresAt': expiresAt!.toIso8601String(),
        if (ipAddress != null) 'ipAddress': ipAddress,
        if (userAgent != null) 'userAgent': userAgent,
        if (browser != null) 'browser': browser,
        if (os != null) 'os': os,
        if (device != null) 'device': device,
        if (isCurrent != null) 'isCurrent': isCurrent,
      };
}

class AddressCreateRequest extends JsonModel {
  const AddressCreateRequest({
    required this.fullName,
    required this.phone,
    required this.addressLine1,
    required this.city,
    required this.country,
    this.addressLine2,
    this.state,
    this.postalCode,
    this.label,
    this.isDefaultShipping,
    this.isDefaultBilling,
  });
  final String fullName;
  final String phone;
  final String addressLine1;
  final String city;
  final String country;
  final String? addressLine2;
  final String? state;
  final String? postalCode;
  final String? label;
  final bool? isDefaultShipping;
  final bool? isDefaultBilling;
  @override
  JsonMap toJson() => {
        'fullName': fullName,
        'phone': phone,
        'addressLine1': addressLine1,
        if (addressLine2 != null) 'addressLine2': addressLine2,
        'city': city,
        if (state != null) 'state': state,
        if (postalCode != null) 'postalCode': postalCode,
        'country': country,
        if (label != null) 'label': label,
        if (isDefaultShipping != null) 'isDefaultShipping': isDefaultShipping,
        if (isDefaultBilling != null) 'isDefaultBilling': isDefaultBilling,
      };
  @override
  List<ValidationIssue> validate() => [
        if (fullName.trim().isEmpty)
          const ValidationIssue(field: 'fullName', message: 'Cannot be empty'),
        if (phone.trim().isEmpty)
          const ValidationIssue(field: 'phone', message: 'Cannot be empty'),
        if (addressLine1.trim().isEmpty)
          const ValidationIssue(
              field: 'addressLine1', message: 'Cannot be empty'),
        if (city.trim().isEmpty)
          const ValidationIssue(field: 'city', message: 'Cannot be empty'),
        if (country.trim().isEmpty)
          const ValidationIssue(field: 'country', message: 'Cannot be empty'),
      ];
}

class AddressUpdateRequest extends JsonModel {
  const AddressUpdateRequest({
    this.fullName,
    this.phone,
    this.addressLine1,
    this.addressLine2,
    this.city,
    this.state,
    this.postalCode,
    this.country,
    this.label,
    this.isDefaultShipping,
    this.isDefaultBilling,
  });

  final String? fullName;
  final String? phone;
  final String? addressLine1;
  final String? addressLine2;
  final String? city;
  final String? state;
  final String? postalCode;
  final String? country;
  final String? label;
  final bool? isDefaultShipping;
  final bool? isDefaultBilling;

  @override
  JsonMap toJson() => {
        if (fullName != null) 'fullName': fullName,
        if (phone != null) 'phone': phone,
        if (addressLine1 != null) 'addressLine1': addressLine1,
        if (addressLine2 != null) 'addressLine2': addressLine2,
        if (city != null) 'city': city,
        if (state != null) 'state': state,
        if (postalCode != null) 'postalCode': postalCode,
        if (country != null) 'country': country,
        if (label != null) 'label': label,
        if (isDefaultShipping != null) 'isDefaultShipping': isDefaultShipping,
        if (isDefaultBilling != null) 'isDefaultBilling': isDefaultBilling,
      };
}

String _appLocaleValue(AppLocale value) => value == AppLocale.ar ? 'ar' : 'en';
DateTime? _date(dynamic value) =>
    value is String ? DateTime.tryParse(value) : null;
List<dynamic> _list(dynamic value) => value is List ? value : const <dynamic>[];
List<String> _stringList(dynamic value) =>
    _list(value).whereType<String>().toList();

class CartProductSnapshot extends JsonModel {
  const CartProductSnapshot({
    this.id,
    this.slug,
    this.name,
    this.image,
    this.price,
    this.stock,
  });
  final String? id;
  final String? slug;
  final String? name;
  final String? image;
  final num? price;
  final int? stock;
  factory CartProductSnapshot.fromJson(dynamic value) {
    final json = _map(value);
    return CartProductSnapshot(
      id: _string(json['id']),
      slug: _string(json['slug']),
      name: _string(json['name']),
      image: _string(json['image']),
      price: json['price'] as num?,
      stock: json['stock'] is num ? (json['stock'] as num).toInt() : null,
    );
  }
  @override
  JsonMap toJson() => {
        if (id != null) 'id': id,
        if (slug != null) 'slug': slug,
        if (name != null) 'name': name,
        if (image != null) 'image': image,
        if (price != null) 'price': price,
        if (stock != null) 'stock': stock,
      };
}

class CartLine extends JsonModel {
  const CartLine({
    this.productId,
    this.variantId,
    this.quantity,
    this.price,
    this.currency,
    this.priceAvailable,
    this.variantTitle,
    this.product,
  });
  final String? productId;
  final String? variantId;
  final int? quantity;
  final num? price;
  final String? currency;
  final bool? priceAvailable;
  final String? variantTitle;
  final CartProductSnapshot? product;
  factory CartLine.fromJson(dynamic value) {
    final json = _map(value);
    return CartLine(
      productId: _string(json['productId']),
      variantId: _string(json['variantId']),
      quantity:
          json['quantity'] is num ? (json['quantity'] as num).toInt() : null,
      price: json['price'] as num?,
      currency: _string(json['currency']),
      priceAvailable: json['priceAvailable'] as bool?,
      variantTitle: _string(json['variantTitle']),
      product: json['product'] == null
          ? null
          : CartProductSnapshot.fromJson(json['product']),
    );
  }
  @override
  JsonMap toJson() => {
        if (productId != null) 'productId': productId,
        if (variantId != null) 'variantId': variantId,
        if (quantity != null) 'quantity': quantity,
        if (price != null) 'price': price,
        if (currency != null) 'currency': currency,
        if (priceAvailable != null) 'priceAvailable': priceAvailable,
        if (variantTitle != null) 'variantTitle': variantTitle,
        if (product != null) 'product': product!.toJson(),
      };
}

class CartModel extends JsonModel {
  const CartModel({
    this.id,
    this.items = const [],
    this.subtotal,
    this.updatedAt,
  });
  final String? id;
  final List<CartLine> items;
  final num? subtotal;
  final DateTime? updatedAt;
  factory CartModel.fromJson(dynamic value) {
    final json = _map(value);
    return CartModel(
      id: _string(json['id']),
      items: _list(json['items']).map(CartLine.fromJson).toList(),
      subtotal: json['subtotal'] as num?,
      updatedAt: _date(json['updatedAt']),
    );
  }
  @override
  JsonMap toJson() => {
        if (id != null) 'id': id,
        'items': items.map((item) => item.toJson()).toList(),
        if (subtotal != null) 'subtotal': subtotal,
        if (updatedAt != null) 'updatedAt': updatedAt!.toIso8601String(),
      };
}

class OrderModel extends JsonModel {
  const OrderModel({
    this.id,
    this.orderNumber,
    this.status,
    this.paymentStatus,
    this.paymentMethod,
    this.total,
    this.subtotal,
    this.shipping,
    this.tax,
    this.discount,
    this.productDiscountTotal,
    this.couponDiscountTotal,
    this.otherDiscountTotal,
    this.shippingDiscount,
    this.taxRate,
    this.grandTotal,
    this.recognizedRevenue,
    this.paidAmount,
    this.collectedAmount,
    this.refundedAmount,
    this.outstandingAmount,
    this.totalCogs,
    this.totalGrossProfit,
    this.currency,
    this.customerName,
    this.customerEmail,
    this.items = const [],
    this.createdAt,
    this.updatedAt,
    this.cancellationReason,
    this.paymentRecognizedAt,
    this.deliveredAt,
    this.extra = const {},
  });
  final String? id;
  final String? orderNumber;
  final OrderStatus? status;
  final PaymentStatus? paymentStatus;
  final PaymentMethodCode? paymentMethod;
  final num? total;
  final num? subtotal;
  final num? shipping;
  final num? tax;
  final num? discount;
  final num? productDiscountTotal;
  final num? couponDiscountTotal;
  final num? otherDiscountTotal;
  final num? shippingDiscount;
  final num? taxRate;
  final num? grandTotal;
  final num? recognizedRevenue;
  final num? paidAmount;
  final num? collectedAmount;
  final num? refundedAmount;
  final num? outstandingAmount;
  final num? totalCogs;
  final num? totalGrossProfit;
  final String? currency;
  final String? customerName;
  final String? customerEmail;
  final List<JsonMap> items;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? cancellationReason;
  final DateTime? paymentRecognizedAt;
  final DateTime? deliveredAt;
  final JsonMap extra;

  factory OrderModel.fromJson(dynamic value) {
    final json = _map(value);
    return OrderModel(
      id: _string(json['id']),
      orderNumber: _string(json['orderNumber']),
      status: _parseEnum(json['status'], OrderStatus.values, _orderStatusValue),
      paymentStatus: _parseEnum(
        json['paymentStatus'],
        PaymentStatus.values,
        _paymentStatusValue,
      ),
      paymentMethod: _parseEnum(
        json['paymentMethod'],
        PaymentMethodCode.values,
        _paymentMethodValue,
      ),
      total: json['total'] as num?,
      subtotal: json['subtotal'] as num?,
      shipping: json['shipping'] as num? ?? json['shippingFee'] as num?,
      tax: json['tax'] as num?,
      discount: json['discount'] as num?,
      productDiscountTotal: json['productDiscountTotal'] as num?,
      couponDiscountTotal: json['couponDiscountTotal'] as num?,
      otherDiscountTotal: json['otherDiscountTotal'] as num?,
      shippingDiscount: json['shippingDiscount'] as num?,
      taxRate: json['taxRate'] as num?,
      grandTotal: json['grandTotal'] as num?,
      recognizedRevenue: json['recognizedRevenue'] as num?,
      paidAmount: json['paidAmount'] as num?,
      collectedAmount: json['collectedAmount'] as num?,
      refundedAmount: json['refundedAmount'] as num?,
      outstandingAmount: json['outstandingAmount'] as num?,
      totalCogs: json['totalCogs'] as num?,
      totalGrossProfit: json['totalGrossProfit'] as num?,
      currency: _string(json['currency']),
      customerName: _string(json['customerName']),
      customerEmail: _string(json['customerEmail']),
      items: _list(json['items'])
          .whereType<Map>()
          .map((item) => Map<String, dynamic>.from(item))
          .toList(),
      createdAt: _date(json['createdAt']),
      updatedAt: _date(json['updatedAt']),
      cancellationReason: _string(json['cancellationReason']),
      paymentRecognizedAt: _date(json['paymentRecognizedAt']),
      deliveredAt: _date(json['deliveredAt']),
      extra: json,
    );
  }

  @override
  JsonMap toJson() => {
        ...extra,
        if (id != null) 'id': id,
        if (orderNumber != null) 'orderNumber': orderNumber,
        if (status != null) 'status': _orderStatusValue(status!),
        if (paymentStatus != null)
          'paymentStatus': _paymentStatusValue(paymentStatus!),
        if (paymentMethod != null)
          'paymentMethod': _paymentMethodValue(paymentMethod!),
        if (total != null) 'total': total,
        if (subtotal != null) 'subtotal': subtotal,
        if (shipping != null) 'shipping': shipping,
        if (tax != null) 'tax': tax,
        if (discount != null) 'discount': discount,
        if (productDiscountTotal != null)
          'productDiscountTotal': productDiscountTotal,
        if (couponDiscountTotal != null)
          'couponDiscountTotal': couponDiscountTotal,
        if (otherDiscountTotal != null)
          'otherDiscountTotal': otherDiscountTotal,
        if (shippingDiscount != null) 'shippingDiscount': shippingDiscount,
        if (taxRate != null) 'taxRate': taxRate,
        if (grandTotal != null) 'grandTotal': grandTotal,
        if (recognizedRevenue != null) 'recognizedRevenue': recognizedRevenue,
        if (paidAmount != null) 'paidAmount': paidAmount,
        if (collectedAmount != null) 'collectedAmount': collectedAmount,
        if (refundedAmount != null) 'refundedAmount': refundedAmount,
        if (outstandingAmount != null) 'outstandingAmount': outstandingAmount,
        if (totalCogs != null) 'totalCogs': totalCogs,
        if (totalGrossProfit != null) 'totalGrossProfit': totalGrossProfit,
        if (currency != null) 'currency': currency,
        if (customerName != null) 'customerName': customerName,
        if (customerEmail != null) 'customerEmail': customerEmail,
        'items': items,
        if (createdAt != null) 'createdAt': createdAt!.toIso8601String(),
        if (updatedAt != null) 'updatedAt': updatedAt!.toIso8601String(),
        if (cancellationReason != null)
          'cancellationReason': cancellationReason,
        if (paymentRecognizedAt != null)
          'paymentRecognizedAt': paymentRecognizedAt!.toIso8601String(),
        if (deliveredAt != null) 'deliveredAt': deliveredAt!.toIso8601String(),
      };
}

T? _parseEnum<T>(dynamic value, List<T> values, String Function(T) wire) {
  if (value == null) return null;
  final normalized = '$value'.toUpperCase();
  for (final candidate in values) {
    if (wire(candidate).toUpperCase() == normalized) return candidate;
  }
  return null;
}

class DefaultAddressRequest extends JsonModel {
  const DefaultAddressRequest({
    this.isDefaultShipping = true,
    this.isDefaultBilling = true,
  });
  final bool isDefaultShipping;
  final bool isDefaultBilling;
  @override
  JsonMap toJson() => {
        'isDefaultShipping': isDefaultShipping,
        'isDefaultBilling': isDefaultBilling,
      };
}
