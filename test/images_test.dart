import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:surf_practice_magic_ball/resources/resources.dart';

void main() {
  test('images assets test', () {
    expect(File(Images.error).existsSync(), isTrue);
    expect(File(Images.loading).existsSync(), isTrue);
    expect(File(Images.notActive).existsSync(), isTrue);
    expect(File(Images.success).existsSync(), isTrue);
  });
}
