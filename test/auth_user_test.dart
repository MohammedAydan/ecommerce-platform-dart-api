import 'package:ecommerce_platform_api/ecommerce_platform_api.dart';
import 'package:test/test.dart';

void main() {
  test('preserves Better Auth isAnonymous field', () {
    final user = AuthUser.fromJson({
      'id': 'anonymous-user',
      'email': 'temp@example.test',
      'name': 'Guest',
      'isAnonymous': true,
    });

    expect(user.isAnonymous, isTrue);
    expect(user.toJson()['isAnonymous'], isTrue);
  });
}
