// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe_detail_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecipeDetailResponse _$RecipeDetailResponseFromJson(
        Map<String, dynamic> json) =>
    RecipeDetailResponse(
      composition: json['composition'] as String?,
      difficulty: json['difficulty'] as String?,
      recipeId: json['recipeId'] as int?,
      ingredients: json['ingredients'] as String?,
      isBookmark: json['isBookmark'] as bool?,
      name: json['name'] as String?,
      orders: json['orders'] as String?,
      photo: json['photo'] as String?,
      servings: json['servings'] as String?,
      thumbnail: json['thumbnail'] as String?,
      time: json['time'] as String?,
    );

Map<String, dynamic> _$RecipeDetailResponseToJson(
        RecipeDetailResponse instance) =>
    <String, dynamic>{
      'composition': instance.composition,
      'difficulty': instance.difficulty,
      'recipeId': instance.recipeId,
      'ingredients': instance.ingredients,
      'isBookmark': instance.isBookmark,
      'name': instance.name,
      'orders': instance.orders,
      'photo': instance.photo,
      'servings': instance.servings,
      'thumbnail': instance.thumbnail,
      'time': instance.time,
    };
