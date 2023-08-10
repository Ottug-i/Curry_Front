import 'package:json_annotation/json_annotation.dart';
import 'package:ottugi_curry/model/recipe_response.dart';

part 'recipe_list_page_response.g.dart';

@JsonSerializable()
class RecipeListPageResponse {
  List<RecipeResponse>? content;
  int? totalPages;
  int? totalElements;
  int? size;
  int? number;
  bool? last;
  bool? first;
  bool? empty;
  int? numberOfElements;

  RecipeListPageResponse(
      {this.content,
      this.totalPages,
      this.totalElements,
      this.last,
      this.size,
      this.number,
      this.first,
      this.empty,
      this.numberOfElements});

  factory RecipeListPageResponse.fromJson(Map<String, dynamic> json) =>
      _$RecipeListPageResponseFromJson(json);
  Map<String, dynamic> toJson() => _$RecipeListPageResponseToJson(this);
}
