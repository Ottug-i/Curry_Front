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
      page: json['page'] as int?,
      size: json['size'] as int?,
      userId: json['userId'] as int?,
    );

Map<String, dynamic> _$IngredientRequestToJson(IngredientRequest instance) =>
    <String, dynamic>{
      'ingredients': instance.ingredients,
      'page': instance.page,
      'size': instance.size,
      'userId': instance.userId,
    };
