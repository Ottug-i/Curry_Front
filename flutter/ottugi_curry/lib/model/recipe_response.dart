import 'package:json_annotation/json_annotation.dart';

part 'recipe_response.g.dart';

@JsonSerializable()
class RecipeResponse {
  String? composition;
  String? difficulty;
  int? id;
  String? ingredients;
  bool? isBookmark;
  String? name;
  String? orders;
  String? photo;
  String? servings;
  String? thumbnail;
  String? time;

  RecipeResponse({
    this.composition,
    this.difficulty,
    this.id,
    this.ingredients,
    this.isBookmark,
    this.name,
    this.orders,
    this.photo,
    this.servings,
    this.thumbnail,
    this.time,
  });

  factory RecipeResponse.fromJson(Map<String, dynamic> json) => _$RecipeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RecipeResponseToJson(this);
}
