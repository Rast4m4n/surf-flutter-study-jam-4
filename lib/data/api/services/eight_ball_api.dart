import 'dart:convert';
import 'dart:io';

import 'package:surf_practice_magic_ball/data/api/config/base_url.dart';
import 'package:surf_practice_magic_ball/data/api/config/state_request.dart';
import 'package:surf_practice_magic_ball/domain/model/eight_ball_model.dart';

import 'package:http/http.dart' as http;

class EightBallApi {
  Future<EightBallModel?> getEightBallData() async {
    try {
      final response = await http.get(
        Uri.parse(BaseUrl.baseUrl),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(utf8.decode(response.bodyBytes));
        final ballData = EightBallModel.fromJson(
          data as Map<String, dynamic>,
        );

        StateRequest.state = StateRequestEnum.success;
        return ballData;
      } else {
        StateRequest.state = StateRequestEnum.failed;
        print("Ошибка. Статус: ${response.statusCode}");
        return null;
      }
    } on SocketException catch (e) {
      StateRequest.state = StateRequestEnum.socketFailed;
      print(e);
      return null;
    } catch (e) {
      throw Exception('Ошибка: $e');
    }
  }
}
