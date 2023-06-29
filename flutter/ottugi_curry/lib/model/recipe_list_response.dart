import 'package:json_annotation/json_annotation.dart';
import 'package:ottugi_curry/model/menu.dart';

part 'recipe_list_response.g.dart';

@JsonSerializable()
class RecipeListResponse {
  List<MenuModel>? content;
  int? totalPages;
  int? totalElements;
  int? size;
  int? number;
  bool? last;
  bool? first;
  bool? empty;

  RecipeListResponse({
    this.content,
    this.totalPages,
    this.totalElements,
    this.last,
    this.size,
    this.number,
    this.first,
    this.empty,
  });

  factory RecipeListResponse.fromJson(Map<String, dynamic> json) =>
      _$RecipeListResponseFromJson(json);
  Map<String, dynamic> toJson() => _$RecipeListResponseToJson(this);
}
