import 'package:json_annotation/json_annotation.dart';

part 'bookmark_update.g.dart';

@JsonSerializable()
class Bookmark {
  int userId;
  int recipeId;

  Bookmark({required this.userId, required this.recipeId});

  factory Bookmark.fromJson(Map<String, dynamic> json) =>
      _$BookmarkFromJson(json);
  Map<String, dynamic> toJson() => _$BookmarkToJson(this);
}
