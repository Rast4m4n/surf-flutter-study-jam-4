import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:surf_practice_magic_ball/resources/resources.dart';

void main() {
  test('images assets test', () {
    expect(File(Images.ellipse6).existsSync(), isTrue);
    expect(File(Images.ellipse7).existsSync(), isTrue);
    expect(File(Images.ball).existsSync(), isTrue);
    expect(File(Images.redBall).existsSync(), isTrue);
    expect(File(Images.smallStar).existsSync(), isTrue);
    expect(File(Images.star).existsSync(), isTrue);
  });
}
