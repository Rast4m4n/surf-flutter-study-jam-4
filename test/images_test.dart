import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:surf_practice_magic_ball/resources/resources.dart';

void main() {
  test('images assets test', () {
    expect(File(Images.ball).existsSync(), isTrue);
    expect(File(Images.bigShadowBlue).existsSync(), isTrue);
    expect(File(Images.bigShadowRed).existsSync(), isTrue);
    expect(File(Images.redBall).existsSync(), isTrue);
    expect(File(Images.smallShadowBlue).existsSync(), isTrue);
    expect(File(Images.smallShadowRed).existsSync(), isTrue);
    expect(File(Images.smallStar).existsSync(), isTrue);
    expect(File(Images.star).existsSync(), isTrue);
  });
}
