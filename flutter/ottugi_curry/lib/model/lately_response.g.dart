// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lately_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LatelyResponse _$LatelyResponseFromJson(Map<String, dynamic> json) =>
    LatelyResponse(
      recipeId: json['recipeId'] as int?,
      name: json['name'] as String?,
      thumbnail: json['thumbnail'] as String?,
    );

Map<String, dynamic> _$LatelyResponseToJson(LatelyResponse instance) =>
    <String, dynamic>{
      'recipeId': instance.recipeId,
      'name': instance.name,
      'thumbnail': instance.thumbnail,
    };
