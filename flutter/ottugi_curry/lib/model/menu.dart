import 'package:json_annotation/json_annotation.dart';

part 'menu.g.dart';

@JsonSerializable()
class MenuModel {
  final int? id;
  final String? name;
  final String? thumbnail;
  final String? time;
  final String? difficulty; // 구성 (ex. 든든하게)
  final String? composition;
  final String? ingredients;
  final bool? isBookmark;

  //List<String>? ingredients;
  // 생성자
  MenuModel(
      {this.name,
      this.id,
      this.thumbnail,
      this.time,
      this.difficulty,
      this.composition,
      this.ingredients,
      this.isBookmark});

  factory MenuModel.fromJson(Map<String, dynamic> json) =>
      _$MenuModelFromJson(json);
  Map<String, dynamic> toJson() => _$MenuModelToJson(this);
}
