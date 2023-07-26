import 'package:json_annotation/json_annotation.dart';

part 'search_queries.g.dart';

@JsonSerializable()
class SearchQueries {
  String? composition;
  String? difficulty;
  String? name;
  int? page;
  int? size;
  String? time;
  int userId;

  SearchQueries({
    this.composition,
    this.difficulty,
    this.name,
    this.page,
    this.size,
    this.time,
    required this.userId,
  });

  factory SearchQueries.fromJson(Map<String, dynamic> json) => _$SearchQueriesFromJson(json);

  Map<String, dynamic> toJson() => _$SearchQueriesToJson(this);
}
