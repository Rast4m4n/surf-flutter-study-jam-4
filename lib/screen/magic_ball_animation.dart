import 'package:flutter/material.dart';
import 'package:surf_practice_magic_ball/screen/magic_ball_screen.dart';
import 'package:surf_practice_magic_ball/screen/magic_ball_vm.dart';

abstract class IMagicBallAnimationModel with ChangeNotifier {
  IMagicBallAnimationModel({
    required this.vm,
    required this.magicBallWidget,
  });

  final EightBallWidgetState magicBallWidget;
  final IMagicBallViewModel vm;
  late AnimationController controllerRotation;
  late CurvedAnimation animationRotation = CurvedAnimation(
    parent: controllerRotation,
    curve: Curves.linear,
  );
  Duration durationAnimation = const Duration(seconds: 1);

  void disposeAnimation();
  void flyBall();

  bool isDown = false;
}

class MagicBallAnimationModel
    with ChangeNotifier
    implements IMagicBallAnimationModel {
  MagicBallAnimationModel({
    required this.vm,
    required this.magicBallWidget,
  });

  @override
  final EightBallWidgetState magicBallWidget;

  @override
  late CurvedAnimation animationRotation = CurvedAnimation(
    parent: controllerRotation,
    curve: Curves.linear,
  );

  @override
  late AnimationController controllerRotation = AnimationController(
    vsync: magicBallWidget,
    duration: const Duration(seconds: 15),
  )..repeat();

  @override
  Duration durationAnimation = const Duration(seconds: 1);

  @override
  bool isDown = false;

  @override
  final IMagicBallViewModel vm;

  @override
  void disposeAnimation() => animationRotation.dispose();

  @override
  void flyBall() {
    if (!vm.isHiddenStars) {
      isDown = !isDown;
      Future.delayed(durationAnimation, () {
        flyBall();
        notifyListeners();
      });
    }
  }
}
