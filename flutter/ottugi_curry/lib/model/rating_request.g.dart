// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rating_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RatingRequest _$RatingRequestFromJson(Map<String, dynamic> json) =>
    RatingRequest(
      newUserRatingsDic: json['newUserRatingsDic'] as Map<String, dynamic>?,
      userId: json['userId'] as int?,
    );

Map<String, dynamic> _$RatingRequestToJson(RatingRequest instance) =>
    <String, dynamic>{
      'newUserRatingsDic': instance.newUserRatingsDic,
      'userId': instance.userId,
    };
