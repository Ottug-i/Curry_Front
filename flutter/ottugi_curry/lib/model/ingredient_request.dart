import 'package:json_annotation/json_annotation.dart';

part 'ingredient_request.g.dart';

@JsonSerializable()
class IngredientRequest {
  List<String>? ingredients;
  String? composition;
  String? difficulty;
  String? time;
  int? page;
  int? size;
  int? userId;

  IngredientRequest(
      {this.ingredients,
      this.composition,
      this.difficulty,
      this.time,
      this.page,
      this.size,
      this.userId});

  factory IngredientRequest.fromJson(Map<String, dynamic> json) =>
      _$IngredientRequestFromJson(json);

  Map<String, dynamic> toJson() => _$IngredientRequestToJson(this);
}
