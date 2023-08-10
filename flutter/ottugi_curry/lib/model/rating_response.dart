import 'package:json_annotation/json_annotation.dart';

part 'rating_response.g.dart';

@JsonSerializable()
class RatingResponse {
  double? rating;
  int? recipeId;
  int? userId;

  RatingResponse({
    this.rating,
    this.recipeId,
    this.userId
  });

  factory RatingResponse.fromJson(Map<String, dynamic> json) => _$RatingResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RatingResponseToJson(this);
}
