import 'package:json_annotation/json_annotation.dart';

part 'rank_response.g.dart';

@JsonSerializable()
class RankResponse {
    String? name;
    int? score;

  RankResponse({
    this.name,
    this.score
  });

  factory RankResponse.fromJson(Map<String, dynamic> json) => _$RankResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RankResponseToJson(this);
}
