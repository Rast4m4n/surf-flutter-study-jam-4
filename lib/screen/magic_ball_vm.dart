import 'package:flutter/material.dart';
import 'package:surf_practice_magic_ball/data/api/config/state_request.dart';
import 'package:surf_practice_magic_ball/data/api/services/eight_ball_api.dart';
import 'package:surf_practice_magic_ball/domain/model/eight_ball_model.dart';
import 'package:surf_practice_magic_ball/resources/resources.dart';

abstract class IMagicBallViewModel implements ChangeNotifier {
  String imagePath = Images.ball;
  late EightBallModel model;
  late EightBallApi api;

  /// Скрытие звёзд, если шар выдал ответ
  bool isHiddenStars = false;

  /// Ответ от шара предсказаний
  void getBallResponse() {}

  /// Очистка старых предсказаний
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
  Future<void> getBallResponse() async {
    clearResponse();
    final data = await api.getEightBallData();
    switch (StateRequest.state) {
      case StateRequestEnum.success:
        model = model.copyWith(data!.reading);
        isHiddenStars = true;
        imagePath = Images.ball;
        notifyListeners();
        break;
      case StateRequestEnum.failed:
        model = model.copyWith("Есть проблемы с предсказанием");
        isHiddenStars = true;
        imagePath = Images.redBall;
        notifyListeners();
      case StateRequestEnum.socketFaild:
        model = model.copyWith("Нет связи с космосом");
        isHiddenStars = true;
        imagePath = Images.redBall;
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
  void getBallResponse() {
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
