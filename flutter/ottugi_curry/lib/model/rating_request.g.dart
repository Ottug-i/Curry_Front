// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rating_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RatingRequest _$RatingRequestFromJson(Map<String, dynamic> json) =>
    RatingRequest(
      new_user_ratings_dic: (json['new_user_ratings_dic'] as List<dynamic>?)
          ?.map((e) => AdditionalProp.fromJson(e as Map<String, dynamic>))
          .toList(),
      user_id: json['user_id'] as int?,
    );

Map<String, dynamic> _$RatingRequestToJson(RatingRequest instance) =>
    <String, dynamic>{
      'new_user_ratings_dic': instance.new_user_ratings_dic,
      'user_id': instance.user_id,
    };
