import 'package:json_annotation/json_annotation.dart';

part 'menu_list.g.dart';

@JsonSerializable()
class MenuList {
  String? userId;
  List<String> recipeId;

  MenuList({this.userId, required this.recipeId});

  factory MenuList.fromJson(Map<String, dynamic> json) =>
      _$MenuListFromJson(json);
  Map<String, dynamic> toJson() => _$MenuListToJson(this);
}
