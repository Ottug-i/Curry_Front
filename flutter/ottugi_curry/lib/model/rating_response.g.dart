// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rating_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RatingResponse _$RatingResponseFromJson(Map<String, dynamic> json) =>
    RatingResponse(
      rating: (json['rating'] as num?)?.toDouble(),
      recipeId: json['recipeId'] as int?,
      userId: json['userId'] as int?,
    );

Map<String, dynamic> _$RatingResponseToJson(RatingResponse instance) =>
    <String, dynamic>{
      'rating': instance.rating,
      'recipeId': instance.recipeId,
      'userId': instance.userId,
    };
