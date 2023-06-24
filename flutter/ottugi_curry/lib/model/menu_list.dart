import 'package:json_annotation/json_annotation.dart';

part 'menu_list.g.dart';

@JsonSerializable()
class MenuList {
  int? userId;
  List<String> ingredients;
  int? page;
  int? size;

  MenuList({this.userId, required this.ingredients, this.page, this.size});

  factory MenuList.fromJson(Map<String, dynamic> json) =>
      _$MenuListFromJson(json);
  Map<String, dynamic> toJson() => _$MenuListToJson(this);
}
