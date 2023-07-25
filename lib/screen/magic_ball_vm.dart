import 'package:flutter/material.dart';
import 'package:surf_practice_magic_ball/resources/resources.dart';

abstract class IMagicBallViewModel implements ChangeNotifier {
  String imagePath = Images.ball;
  String text = '';
  bool isHiddenStars = false;
  void ballResponse() {}

  void clearResponse() {}
}

class MagicBallViewModel extends ChangeNotifier implements IMagicBallViewModel {
  MagicBallViewModel();

  @override
  String imagePath = Images.ball;

  @override
  String text = '';

  @override
  void ballResponse() {
    clearResponse();
    text = 'Ответ';
    isHiddenStars = true;
    notifyListeners();
  }

  @override
  void clearResponse() {
    text = '';
    isHiddenStars = false;
    notifyListeners();
  }

  @override
  bool isHiddenStars = false;
}

class MockMagicBallViewModel extends ChangeNotifier
    implements IMagicBallViewModel {
  @override
  String imagePath = Images.ball;

  @override
  String text = '';

  @override
  void ballResponse() {
    clearResponse();
    text = 'Ответ';
    isHiddenStars = true;
    notifyListeners();
  }

  @override
  void clearResponse() {
    isHiddenStars = false;
    text = '';
  }

  @override
  bool isHiddenStars = false;
}
