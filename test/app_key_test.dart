import 'package:ecommerce_platform_api/ecommerce_platform_api.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:test/test.dart';

void main() {
  test('injects mobile app-key headers without exposing them in API errors', () async {
    late http.Request captured;
    final client = EcommerceApiClient(
      baseUrl: 'https://api.example.test',
      appKeyProvider: () async => 'mobile-test-key',
      appClientKind: ApiClientKind.mobile,
      httpClient: MockClient((request) async {
        captured = request;
        return http.Response(
          '{"success":true,"data":{"ok":true}}',
          200,
          headers: {'content-type': 'application/json'},
        );
      }),
    );

    await client.request<dynamic>(
      'GET',
      '/api/v1/products',
      authenticated: false,
      headers: const {
        'X-API-Key': 'spoofed-key',
        'X-API-Client': 'web',
      },
    );

    expect(captured.headers['x-api-key'], 'mobile-test-key');
    expect(captured.headers['x-api-client'], 'mobile');
    expect(captured.headers['authorization'], isNull);
    client.close();
  });

  test('supports server-side web client identity', () async {
    late http.Request captured;
    final client = EcommerceApiClient(
      baseUrl: 'https://api.example.test',
      appKeyProvider: () async => 'web-server-test-key',
      appClientKind: ApiClientKind.web,
      httpClient: MockClient((request) async {
        captured = request;
        return http.Response(
          '{"success":true}',
          200,
          headers: {'content-type': 'application/json'},
        );
      }),
    );

    await client.request<dynamic>('GET', '/api/v1/products', authenticated: false);

    expect(captured.headers['x-api-key'], 'web-server-test-key');
    expect(captured.headers['x-api-client'], 'web');
    client.close();
  });

  test('fails closed when app-key provider returns no key', () async {
    var requests = 0;
    final client = EcommerceApiClient(
      baseUrl: 'https://api.example.test',
      appKeyProvider: () async => null,
      httpClient: MockClient((request) async {
        requests++;
        return http.Response('{}', 200);
      }),
    );

    await expectLater(
      client.request<dynamic>('GET', '/api/v1/products', authenticated: false),
      throwsA(isA<ApiConfigurationException>()),
    );
    expect(requests, 0);
    client.close();
  });

  test('does not include app-key material in configuration exception text', () async {
    const secret = 'do-not-print-this-key';
    final client = EcommerceApiClient(
      baseUrl: 'https://api.example.test',
      appKeyProvider: () async => '',
      httpClient: MockClient((request) async {
        fail('network must not be reached');
      }),
    );

    try {
      await client.request<dynamic>('GET', '/api/v1/products', authenticated: false);
      fail('expected ApiConfigurationException');
    } on ApiConfigurationException catch (error) {
      expect(error.toString(), isNot(contains(secret)));
    } finally {
      client.close();
    }
  });
}
