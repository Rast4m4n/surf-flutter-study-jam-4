import 'package:flutter/material.dart';
import 'package:surf_practice_magic_ball/data/api/config/state_request.dart';
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
    switch (StateRequest.state) {
      case StateRequestEnum.success:
        model = model.copyWith(data!.reading);
        isHiddenStars = true;
        notifyListeners();
        break;
      case StateRequestEnum.failed:
        model = model.copyWith("Есть проблемы с предсказанием");
        isHiddenStars = true;
        notifyListeners();
      case StateRequestEnum.socketFaild:
        model = model.copyWith("Нет связи с космосом");
        isHiddenStars = true;
        notifyListeners();
      default:
        model = model.copyWith("Что то не так с шаром");
        isHiddenStars = true;
        notifyListeners();
    }
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
