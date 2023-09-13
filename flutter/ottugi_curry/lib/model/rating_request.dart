import 'package:json_annotation/json_annotation.dart';

part 'rating_request.g.dart';

@JsonSerializable()
class RatingRequest {
  Map? newUserRatingsDic;
  int? userId;

  RatingRequest({
    this.newUserRatingsDic,
    this.userId,
  });

  factory RatingRequest.fromJson(Map<String, dynamic> json) => _$RatingRequestFromJson(json);

  Map<String, dynamic> toJson() => _$RatingRequestToJson(this);
}

