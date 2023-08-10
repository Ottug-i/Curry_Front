// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecipeResponse _$RecipeResponseFromJson(Map<String, dynamic> json) =>
    RecipeResponse(
      name: json['name'] as String?,
      recipeId: json['recipeId'] as int,
      thumbnail: json['thumbnail'] as String?,
      time: json['time'] as String?,
      difficulty: json['difficulty'] as String?,
      composition: json['composition'] as String?,
      ingredients: json['ingredients'] as String?,
      isBookmark: json['isBookmark'] as bool?,
    );

Map<String, dynamic> _$RecipeResponseToJson(RecipeResponse instance) =>
    <String, dynamic>{
      'recipeId': instance.recipeId,
      'name': instance.name,
      'thumbnail': instance.thumbnail,
      'time': instance.time,
      'difficulty': instance.difficulty,
      'composition': instance.composition,
      'ingredients': instance.ingredients,
      'isBookmark': instance.isBookmark,
    };
