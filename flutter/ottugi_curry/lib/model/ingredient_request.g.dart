// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ingredient_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IngredientRequest _$IngredientRequestFromJson(Map<String, dynamic> json) =>
    IngredientRequest(
      ingredients: (json['ingredients'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      composition: json['composition'] as String?,
      difficulty: json['difficulty'] as String?,
      time: json['time'] as String?,
      page: json['page'] as int?,
      size: json['size'] as int?,
      userId: json['userId'] as int?,
    );

Map<String, dynamic> _$IngredientRequestToJson(IngredientRequest instance) =>
    <String, dynamic>{
      'ingredients': instance.ingredients,
      'composition': instance.composition,
      'difficulty': instance.difficulty,
      'time': instance.time,
      'page': instance.page,
      'size': instance.size,
      'userId': instance.userId,
    };
