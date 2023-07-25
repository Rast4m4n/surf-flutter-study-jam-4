import 'dart:convert';

import 'package:surf_practice_magic_ball/data/api/config/base_url.dart';
import 'package:surf_practice_magic_ball/domain/model/eight_ball_model.dart';

import 'package:http/http.dart' as http;

class EightBallApi {
  Future<EightBallModel> getEightBallData() async {
    try {
      final response = await http.get(
        Uri.parse(BaseUrl.baseUrl),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(utf8.decode(response.bodyBytes));
        final ballData = EightBallModel.fromJson(
          data as Map<String, dynamic>,
        );
        return ballData;
      } else {
        throw Exception("Ошибка. Статус: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception('Ошибка: $e');
    }
  }
}
