import 'package:json_annotation/json_annotation.dart';

part 'lately_response.g.dart';

@JsonSerializable()
class LatelyResponse {
  int? recipeId;
  String? name;
  String? thumbnail;

  LatelyResponse({
    this.recipeId,
    this.name,
    this.thumbnail,
  });

  factory LatelyResponse.fromJson(Map<String, dynamic> json) =>
      _$LatelyResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LatelyResponseToJson(this);
}
