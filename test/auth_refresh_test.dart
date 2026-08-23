import 'dart:convert';

import 'package:ecommerce_platform_api/ecommerce_platform_api.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:test/test.dart';

void main() {
  test('refreshes a protected request once after 401', () async {
    var calls = 0;
    final transport = EcommerceApiClient(
      appKeyProvider: () async => 'test-only-key',
      baseUrl: 'https://api.example.test',
      authTokenProvider: const StaticAuthTokenProvider('expired-token'),
      authTokenRefresher: () async => 'fresh-token',
      httpClient: MockClient((request) async {
        calls++;
        if (calls == 1) {
          expect(request.headers['authorization'], 'Bearer expired-token');
          return http.Response(
            jsonEncode({
              'success': false,
              'error': {'code': 'UNAUTHORIZED', 'message': 'Expired'},
            }),
            401,
            headers: {'content-type': 'application/json'},
          );
        }
        expect(request.headers['authorization'], 'Bearer fresh-token');
        return http.Response(
          jsonEncode({'success': true, 'data': {'ok': true}}),
          200,
          headers: {'content-type': 'application/json'},
        );
      }),
    );

    final response = await transport.request<dynamic>('GET', '/api/v1/products');
    expect(response.success, isTrue);
    expect(calls, 2);
    transport.close();
  });
}
