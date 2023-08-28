import 'package:flutter/material.dart';
import 'package:surf_practice_magic_ball/data/api/config/state_request.dart';
import 'package:surf_practice_magic_ball/data/api/services/eight_ball_api.dart';
import 'package:surf_practice_magic_ball/domain/model/eight_ball_model.dart';
import 'package:surf_practice_magic_ball/resources/resources.dart';

abstract class IMagicBallViewModel implements ChangeNotifier {
  String imageBallPath = Images.ball;
  bool isBallResponseError = false;
  late EightBallModel model;
  late EightBallApi api;

  /// Скрытие звёзд, если шар выдал ответ
  bool isHiddenStars = false;

  /// Ответ от шара предсказаний
  void getBallResponse() {}

  /// Очистка старых предсказаний
  void clearResponse() {}

  /// Смена цвета шара, например, при ошибке сервера
  void changeColorBall() {}
}

class MagicBallViewModel extends ChangeNotifier implements IMagicBallViewModel {
  MagicBallViewModel({
    required this.model,
    required this.api,
  });

  @override
  String imageBallPath = Images.ball;

  @override
  bool isBallResponseError = false;

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
        changeColorBall();
        notifyListeners();
        break;
      case StateRequestEnum.failed:
        model = model.copyWith("Есть проблемы с предсказанием");
        isHiddenStars = true;
        changeColorBall();
        notifyListeners();
      case StateRequestEnum.socketFailed:
        model = model.copyWith("Нет связи с космосом");
        isHiddenStars = true;
        changeColorBall();
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

  @override
  void changeColorBall() {
    if (StateRequest.state == StateRequestEnum.failed ||
        StateRequest.state == StateRequestEnum.socketFailed) {
      imageBallPath = Images.redBall;
      isBallResponseError = true;
    } else {
      imageBallPath = Images.ball;
      isBallResponseError = false;
    }
  }
}

// class MockMagicBallViewModel extends ChangeNotifier
//     implements IMagicBallViewModel {
//   MockMagicBallViewModel({
//     required this.model,
//     required this.api,
//   });
//   @override
//   String imagePath = Images.ball;

//   @override
//   bool isHiddenStars = false;

//   @override
//   EightBallModel model;

//   @override
//   EightBallApi api;
//   @override
//   void getBallResponse() {
//     clearResponse();
//     isHiddenStars = true;
//     model = model.copyWith('Ответ');
//     notifyListeners();
//   }

//   @override
//   void clearResponse() {
//     model = model.copyWith('');
//     isHiddenStars = false;
//   }
// }
