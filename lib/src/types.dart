import 'dart:typed_data';

typedef JsonMap = Map<String, dynamic>;
typedef JsonList = List<dynamic>;

class ApiPagination {
  const ApiPagination({
    this.page,
    this.limit,
    this.total,
    this.totalPages,
    this.hasNextPage,
    this.hasPreviousPage,
  });

  final int? page;
  final int? limit;
  final int? total;
  final int? totalPages;
  final bool? hasNextPage;
  final bool? hasPreviousPage;

  factory ApiPagination.fromJson(JsonMap? json) {
    return ApiPagination(
      page: _asInt(json?['page']),
      limit: _asInt(json?['limit']),
      total: _asInt(json?['total']),
      totalPages: _asInt(json?['totalPages']),
      hasNextPage: json?['hasNextPage'] as bool?,
      hasPreviousPage: json?['hasPreviousPage'] as bool?,
    );
  }

  JsonMap toJson() => {
        if (page != null) 'page': page,
        if (limit != null) 'limit': limit,
        if (total != null) 'total': total,
        if (totalPages != null) 'totalPages': totalPages,
        if (hasNextPage != null) 'hasNextPage': hasNextPage,
        if (hasPreviousPage != null) 'hasPreviousPage': hasPreviousPage,
      };
}

class ApiMeta {
  const ApiMeta({this.message, this.values = const <String, dynamic>{}});

  final String? message;
  final JsonMap values;

  factory ApiMeta.fromJson(dynamic json) {
    if (json is! JsonMap) return const ApiMeta();
    final copy = Map<String, dynamic>.from(json);
    final message = copy.remove('message');
    return ApiMeta(
      message: message is String ? message : null,
      values: copy,
    );
  }

  JsonMap toJson() => {
        ...values,
        if (message != null) 'message': message,
      };
}

class ApiResponse<T> {
  const ApiResponse({
    required this.success,
    this.data,
    this.meta,
    this.pagination,
    this.raw = const <String, dynamic>{},
    this.statusCode,
  });

  final bool success;
  final T? data;
  final ApiMeta? meta;
  final ApiPagination? pagination;
  final JsonMap raw;
  final int? statusCode;

  bool get isSuccess => success;

  ApiResponse<R> map<R>(R Function(T value) transform) {
    return ApiResponse<R>(
      success: success,
      data: data == null ? null : transform(data as T),
      meta: meta,
      pagination: pagination,
      raw: raw,
      statusCode: statusCode,
    );
  }
}

class ApiError {
  const ApiError({
    required this.code,
    required this.message,
    this.details,
    this.statusCode,
  });

  final String code;
  final String message;
  final dynamic details;
  final int? statusCode;

  factory ApiError.fromJson(JsonMap json, {int? statusCode}) {
    final error = json['error'];
    if (error is JsonMap) {
      return ApiError(
        code: error['code']?.toString() ?? 'UNKNOWN_ERROR',
        message: error['message']?.toString() ?? 'Request failed',
        details: error['details'],
        statusCode: statusCode,
      );
    }
    return ApiError(
      code: json['code']?.toString() ?? 'UNKNOWN_ERROR',
      message: json['message']?.toString() ?? 'Request failed',
      details: json['details'],
      statusCode: statusCode,
    );
  }

  @override
  String toString() => '$code: $message';
}

class ApiException implements Exception {
  const ApiException({
    required this.error,
    required this.method,
    required this.path,
  });

  final ApiError error;
  final String method;
  final String path;

  int? get statusCode => error.statusCode;
  String get code => error.code;
  String get message => error.message;

  @override
  String toString() => 'ApiException($method $path): $error';
}

class NetworkApiException implements Exception {
  const NetworkApiException(this.message, {this.uri, this.cause});

  final String message;
  final Uri? uri;
  final Object? cause;

  @override
  String toString() => 'NetworkApiException: $message';
}

abstract interface class AuthTokenProvider {
  Future<String?> readToken();
}

class StaticAuthTokenProvider implements AuthTokenProvider {
  const StaticAuthTokenProvider(this.token);

  final String? token;

  @override
  Future<String?> readToken() async => token;
}

class MultipartPart {
  const MultipartPart({
    required this.field,
    required this.filename,
    required this.bytes,
    this.contentType,
  });

  final String field;
  final String filename;
  final Uint8List bytes;
  final String? contentType;
}

int? _asInt(dynamic value) =>
    value is num ? value.toInt() : int.tryParse('$value');
