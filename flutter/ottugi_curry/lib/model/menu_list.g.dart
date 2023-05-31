// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MenuList _$MenuListFromJson(Map<String, dynamic> json) => MenuList(
      userId: json['userId'] as int?,
      recipeId:
          (json['recipeId'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$MenuListToJson(MenuList instance) => <String, dynamic>{
      'userId': instance.userId,
      'recipeId': instance.recipeId,
    };
