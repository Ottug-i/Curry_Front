// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MenuModel _$MenuModelFromJson(Map<String, dynamic> json) => MenuModel(
      name: json['name'] as String?,
      id: json['id'] as int?,
      thumbnail: json['thumbnail'] as String?,
      time: json['time'] as String?,
      difficulty: json['difficulty'] as String?,
      composition: json['composition'] as String?,
      ingredients: json['ingredients'] as String?,
      isBookmark: json['isBookmark'] as bool?,
    );

Map<String, dynamic> _$MenuModelToJson(MenuModel instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'thumbnail': instance.thumbnail,
      'time': instance.time,
      'difficulty': instance.difficulty,
      'composition': instance.composition,
      'ingredients': instance.ingredients,
      'isBookmark': instance.isBookmark,
    };
