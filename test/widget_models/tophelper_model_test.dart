import 'package:flutter_test/flutter_test.dart';
import 'package:billboard/app/app.locator.dart';

import '../helpers/test_helpers.dart';

void main() {
  group('TophelperModel Tests -', () {
    setUp(() => registerServices());
    tearDown(() => locator.reset());
  });
}
