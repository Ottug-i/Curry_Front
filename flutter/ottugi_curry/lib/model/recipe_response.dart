import 'package:json_annotation/json_annotation.dart';

part 'recipe_response.g.dart';

@JsonSerializable()
class RecipeResponse {
  final int recipeId;
  final String? name;
  final String? thumbnail;
  final String? time;
  final String? difficulty; // 구성 (ex. 든든하게)
  final String? composition;
  final String? ingredients;
  final bool? isBookmark;
  final String? mainGenre;

  //List<String>? ingredients;
  // 생성자
  RecipeResponse(
      {this.name,
      required this.recipeId,
      this.thumbnail,
      this.time,
      this.difficulty,
      this.composition,
      this.ingredients,
      this.isBookmark,
      this.mainGenre});

  factory RecipeResponse.fromJson(Map<String, dynamic> json) =>
      _$RecipeResponseFromJson(json);
  Map<String, dynamic> toJson() => _$RecipeResponseToJson(this);
}
