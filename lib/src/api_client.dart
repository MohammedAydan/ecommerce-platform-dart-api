import 'dart:convert';

import 'package:http/http.dart' as http;

import 'models.dart';
import 'types.dart';

typedef JsonDecoder<T> = T Function(dynamic value);

class EcommerceApiClient {
  EcommerceApiClient({
    required String baseUrl,
    http.Client? httpClient,
    this.authTokenProvider,
    Map<String, String>? defaultHeaders,
    this.cookie,
    this.cookieStore,
    this.throwOnApiError = true,
    this.requestTimeout = const Duration(seconds: 30),
    this.maxRetries = 2,
    this.retryDelay = const Duration(milliseconds: 250),
    this.retryUnsafeRequests = false,
  })  : baseUrl = baseUrl.replaceFirst(RegExp(r'/+$'), ''),
        _httpClient = httpClient ?? http.Client(),
        _defaultHeaders = Map.unmodifiable(defaultHeaders ?? const {});

  final String baseUrl;
  final http.Client _httpClient;
  final AuthTokenProvider? authTokenProvider;
  final Map<String, String> _defaultHeaders;
  final String? cookie;
  final CookieStore? cookieStore;
  final bool throwOnApiError;
  final Duration requestTimeout;
  final int maxRetries;
  final Duration retryDelay;
  final bool retryUnsafeRequests;

  void close() => _httpClient.close();

  Future<ApiResponse<T>> request<T>(
    String method,
    String path, {
    Map<String, dynamic>? query,
    QueryModel? queryModel,
    dynamic body,
    Map<String, String>? headers,
    JsonDecoder<T>? decoder,
    bool authenticated = true,
    String? idempotencyKey,
  }) async {
    queryModel?.validateOrThrow();
    final mergedQuery = <String, dynamic>{
      ...?query,
      ...?queryModel?.toQuery(),
    };
    final uri = _buildUri(path, mergedQuery.isEmpty ? null : mergedQuery);
    final normalizedMethod = method.toUpperCase();
    final encodedBody = _encodeBody(body);
    Object? lastNetworkError;

    for (var attempt = 0; attempt <= maxRetries; attempt++) {
      final request = http.Request(normalizedMethod, uri);
      request.headers.addAll(await _headers(
        headers,
        authenticated: authenticated,
        hasJsonBody: encodedBody != null,
        idempotencyKey: idempotencyKey,
      ));
      if (encodedBody != null) request.body = encodedBody;

      try {
        final response =
            await _httpClient.send(request).timeout(requestTimeout);
        if (_shouldRetry(normalizedMethod, response.statusCode, attempt)) {
          await response.stream.drain<void>();
          await _waitBeforeRetry(attempt);
          continue;
        }
        await _saveResponseCookies(response.headers);
        final bytes = await response.stream.toBytes();
        return _parseResponse<T>(
          method: normalizedMethod,
          path: path,
          statusCode: response.statusCode,
          bytes: bytes,
          contentType: response.headers['content-type'],
          headers: response.headers,
          decoder: decoder,
        );
      } catch (error) {
        lastNetworkError = error;
        if (!_shouldRetryNetwork(normalizedMethod, attempt)) rethrow;
        await _waitBeforeRetry(attempt);
      }
    }

    throw NetworkApiException(
      'Unable to reach the Ecommerce Platform API after retries',
      uri: uri,
      cause: lastNetworkError,
    );
  }

  Future<ApiResponse<T>> upload<T>(
    String path, {
    required List<MultipartPart> files,
    Map<String, String>? fields,
    Map<String, dynamic>? query,
    QueryModel? queryModel,
    Map<String, String>? headers,
    JsonDecoder<T>? decoder,
    bool authenticated = true,
  }) async {
    queryModel?.validateOrThrow();
    final mergedQuery = <String, dynamic>{
      ...?query,
      ...?queryModel?.toQuery(),
    };
    final uri = _buildUri(path, mergedQuery.isEmpty ? null : mergedQuery);
    final request = http.MultipartRequest('POST', uri);
    request.headers.addAll(await _headers(
      headers,
      authenticated: authenticated,
      hasJsonBody: false,
    ));
    request.fields.addAll(fields ?? const {});
    for (final file in files) {
      request.files.add(http.MultipartFile.fromBytes(
        file.field,
        file.bytes,
        filename: file.filename,
      ));
    }

    try {
      final response = await _httpClient.send(request).timeout(requestTimeout);
      await _saveResponseCookies(response.headers);
      final bytes = await response.stream.toBytes();
      return _parseResponse<T>(
        method: 'POST',
        path: path,
        statusCode: response.statusCode,
        bytes: bytes,
        contentType: response.headers['content-type'],
        headers: response.headers,
        decoder: decoder,
      );
    } catch (error) {
      if (error is ApiException) rethrow;
      throw NetworkApiException(
        'Unable to reach the Ecommerce Platform API',
        uri: uri,
        cause: error,
      );
    }
  }

  String? _encodeBody(dynamic body) {
    if (body == null) return null;
    if (body is JsonModel) {
      body.validateOrThrow();
      return jsonEncode(body.toJson());
    }
    return jsonEncode(body);
  }

  Uri _buildUri(String path, Map<String, dynamic>? query) {
    final rawPath = path.startsWith('/') ? path : '/$path';
    final base = Uri.parse('$baseUrl$rawPath');
    if (query == null || query.isEmpty) return base;
    final parameters = <String, String>{
      ...base.queryParameters,
      for (final entry in query.entries)
        if (entry.value != null) entry.key: '${entry.value}',
    };
    return base.replace(queryParameters: parameters);
  }

  Future<Map<String, String>> _headers(
    Map<String, String>? headers, {
    required bool authenticated,
    required bool hasJsonBody,
    String? idempotencyKey,
  }) async {
    final result = <String, String>{
      'Accept': 'application/json',
      ..._defaultHeaders,
      ...?headers,
    };
    if (hasJsonBody)
      result.putIfAbsent('Content-Type', () => 'application/json');
    final storedCookie = await cookieStore?.read();
    final requestCookie = cookie ?? storedCookie;
    if (requestCookie != null && requestCookie.isNotEmpty) {
      result.putIfAbsent('Cookie', () => requestCookie);
    }
    if (authenticated && !result.containsKey('Authorization')) {
      final token = await authTokenProvider?.readToken();
      if (token != null && token.isNotEmpty) {
        result['Authorization'] = 'Bearer $token';
      }
    }
    if (idempotencyKey != null && idempotencyKey.isNotEmpty) {
      result['idempotency-key'] = idempotencyKey;
    }
    return result;
  }

  Future<void> _saveResponseCookies(Map<String, String> headers) async {
    final raw = headers['set-cookie'];
    if (raw == null || raw.isEmpty) return;
    await cookieStore
        ?.writeSetCookieHeaders(raw.split(RegExp(r',\s*(?=[^;=,]+=[^;=,]+)')));
  }

  bool _shouldRetry(String method, int statusCode, int attempt) {
    if (attempt >= maxRetries) return false;
    if (!_isRetryableMethod(method)) return false;
    return const {408, 425, 429, 500, 502, 503, 504}.contains(statusCode);
  }

  bool _shouldRetryNetwork(String method, int attempt) {
    return attempt < maxRetries && _isRetryableMethod(method);
  }

  bool _isRetryableMethod(String method) {
    if (const {'GET', 'HEAD', 'OPTIONS'}.contains(method)) return true;
    return retryUnsafeRequests;
  }

  Future<void> _waitBeforeRetry(int attempt) async {
    if (retryDelay <= Duration.zero) return;
    final multiplier = 1 << attempt;
    await Future<void>.delayed(retryDelay * multiplier);
  }

  ApiResponse<T> _parseResponse<T>({
    required String method,
    required String path,
    required int statusCode,
    required List<int> bytes,
    required String? contentType,
    required Map<String, String> headers,
    required JsonDecoder<T>? decoder,
  }) {
    final text = utf8.decode(bytes, allowMalformed: true);
    dynamic decoded;
    if (text.trim().isNotEmpty && (contentType?.contains('json') ?? true)) {
      try {
        decoded = jsonDecode(text);
      } catch (_) {
        decoded = null;
      }
    }
    final raw = decoded is JsonMap
        ? Map<String, dynamic>.from(decoded)
        : <String, dynamic>{'data': decoded ?? text};
    final success =
        statusCode >= 200 && statusCode < 300 && raw['success'] != false;
    final error =
        success ? null : ApiError.fromJson(raw, statusCode: statusCode);
    if (error != null && throwOnApiError) {
      throw ApiException(error: error, method: method, path: path);
    }
    final rawData = raw['data'];
    return ApiResponse<T>(
      success: success,
      data:
          decoder == null || rawData == null ? rawData as T? : decoder(rawData),
      meta: raw['meta'] == null ? null : ApiMeta.fromJson(raw['meta']),
      pagination: raw['pagination'] is JsonMap
          ? ApiPagination.fromJson(raw['pagination'] as JsonMap)
          : null,
      raw: raw,
      statusCode: statusCode,
      headers: headers,
    );
  }
}
