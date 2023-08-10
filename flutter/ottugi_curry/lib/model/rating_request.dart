import 'package:json_annotation/json_annotation.dart';
import 'package:ottugi_curry/model/additional_prop.dart';

part 'rating_request.g.dart';

@JsonSerializable()
class RatingRequest {
  List<AdditionalProp>? new_user_ratings_dic;
  int? user_id;

  RatingRequest({
    this.new_user_ratings_dic,
    this.user_id,
  });

  factory RatingRequest.fromJson(Map<String, dynamic> json) => _$RatingRequestFromJson(json);

  Map<String, dynamic> toJson() => _$RatingRequestToJson(this);
}

