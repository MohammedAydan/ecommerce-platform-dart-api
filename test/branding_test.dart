import 'dart:convert';
import 'package:ecommerce_platform_api/ecommerce_platform_api.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:test/test.dart';

void main() {
  test('PublicApiClient.storeBranding returns typed response', () async {
    final transport = EcommerceApiClient(
      appKeyProvider: () async => 'test-only-key',
      baseUrl: 'https://api.example.test',
      httpClient: MockClient((request) async {
        return http.Response(
          jsonEncode({
            'success': true,
            'data': {
              'name': 'Aydan Store',
              'logoUrl': 'https://example.com/logo.png'
            }
          }),
          200,
          headers: {'content-type': 'application/json'},
        );
      }),
    );
    final api = PublicApiClient(transport);
    final response = await api.storeBranding();
    expect(response.success, isTrue);
    expect(response.data?.name, 'Aydan Store');
    expect(response.data?.logoUrl, 'https://example.com/logo.png');
    transport.close();
  });
}
