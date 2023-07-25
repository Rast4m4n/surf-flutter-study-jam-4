import 'package:flutter/material.dart';
import 'package:surf_practice_magic_ball/data/api/services/eight_ball_api.dart';
import 'package:surf_practice_magic_ball/domain/model/eight_ball_model.dart';
import 'package:surf_practice_magic_ball/resources/resources.dart';

abstract class IMagicBallViewModel implements ChangeNotifier {
  String imagePath = Images.ball;
  late EightBallModel model;
  late EightBallApi api;
  bool isHiddenStars = false;
  void ballResponse() {}

  void clearResponse() {}
}

class MagicBallViewModel extends ChangeNotifier implements IMagicBallViewModel {
  MagicBallViewModel({
    required this.model,
    required this.api,
  });

  @override
  String imagePath = Images.ball;

  @override
  bool isHiddenStars = false;

  @override
  EightBallModel model;

  @override
  EightBallApi api;

  @override
  Future<void> ballResponse() async {
    clearResponse();
    final data = await api.getEightBallData();
    model = model.copyWith(data.reading);
    isHiddenStars = true;
    notifyListeners();
  }

  @override
  void clearResponse() {
    isHiddenStars = false;
    model = model.copyWith('');
    notifyListeners();
  }
}

class MockMagicBallViewModel extends ChangeNotifier
    implements IMagicBallViewModel {
  MockMagicBallViewModel({
    required this.model,
    required this.api,
  });
  @override
  String imagePath = Images.ball;

  @override
  void ballResponse() {
    clearResponse();
    isHiddenStars = true;
    model = model.copyWith('Ответ');
    notifyListeners();
  }

  @override
  void clearResponse() {
    model = model.copyWith('');
    isHiddenStars = false;
  }

  @override
  bool isHiddenStars = false;

  @override
  EightBallModel model;

  @override
  EightBallApi api;
}
