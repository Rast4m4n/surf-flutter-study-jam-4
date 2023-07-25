import 'package:json_annotation/json_annotation.dart';

part 'eight_ball_model.g.dart';

@JsonSerializable()
class EightBallModel {
  EightBallModel({
    required this.reading,
  });

  final String reading;

  Map<String, dynamic> tojson() => _$EightBallModelToJson(this);

  factory EightBallModel.fromJson(Map<String, dynamic> json) =>
      _$EightBallModelFromJson(json);

  EightBallModel copyWith(
    String? reading,
  ) {
    return EightBallModel(
      reading: reading ?? this.reading,
    );
  }
}
