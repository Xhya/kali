import 'package:flutter_test/flutter_test.dart';
import 'package:kali/core/actions/checkAppVersion.actions.dart';

void main() {
  test('isLowerVersion', () async {
    expect(isVersionLower("1.8.1", "1.8.0"), false);
    expect(isVersionLower("1.8.0", "1.8.1"), true);
  });
}
