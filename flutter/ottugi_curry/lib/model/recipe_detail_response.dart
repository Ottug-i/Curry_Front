import 'package:json_annotation/json_annotation.dart';

part 'recipe_detail_response.g.dart';

@JsonSerializable()
class RecipeDetailResponse {
  String? composition;
  String? difficulty;
  int? recipeId;
  String? ingredients;
  bool? isBookmark;
  String? name;
  String? orders;
  String? photo;
  String? servings;
  String? thumbnail;
  String? time;

  RecipeDetailResponse({
    this.composition,
    this.difficulty,
    this.recipeId,
    this.ingredients,
    this.isBookmark,
    this.name,
    this.orders,
    this.photo,
    this.servings,
    this.thumbnail,
    this.time,
  });

  factory RecipeDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$RecipeDetailResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RecipeDetailResponseToJson(this);
}
