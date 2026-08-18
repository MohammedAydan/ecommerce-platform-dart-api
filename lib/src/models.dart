import 'types.dart';

abstract class JsonModel {
  const JsonModel();
  JsonMap toJson();
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
  const AccountSettingsPatch(
      {this.emailNotifications, this.smsNotifications, this.language});

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
  const ReviewInput(
      {required this.rating, this.title, this.comment, this.productId});

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
  const CartItemInput(
      {required this.productId, required this.quantity, this.variantId});

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
    this.walletMethodId,
  });

  final List<CartItemInput> items;
  final ShippingAddressInput shippingAddress;
  final ShippingAddressInput? billingAddress;
  final String? couponCode;
  final String? shippingMethodId;
  final String? paymentMethod;
  final String? walletMethodId;

  @override
  JsonMap toJson() => {
        'items': items.map((item) => item.toJson()).toList(),
        'shippingAddress': shippingAddress.toJson(),
        if (billingAddress != null) 'billingAddress': billingAddress!.toJson(),
        if (couponCode != null) 'couponCode': couponCode,
        if (shippingMethodId != null) 'shippingMethodId': shippingMethodId,
        if (paymentMethod != null) 'paymentMethod': paymentMethod,
        if (walletMethodId != null) 'walletMethodId': walletMethodId,
      };
}

class CheckoutQuoteInput extends JsonModel {
  const CheckoutQuoteInput(
      {required this.items,
      this.shippingAddress,
      this.shippingMethodId,
      this.couponCode});

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
  const Product(
      {this.id,
      this.slug,
      this.name,
      this.price,
      this.currency,
      this.extra = const {}});

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
        if (currency != null) 'currency': currency
      };
}

class Review extends JsonModel {
  const Review(
      {this.id,
      this.productId,
      this.rating,
      this.title,
      this.comment,
      this.status,
      this.extra = const {}});

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
  const InventoryAdjustment(
      {required this.inventoryItemId,
      required this.adjustmentQty,
      this.reason,
      this.locationId});

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
