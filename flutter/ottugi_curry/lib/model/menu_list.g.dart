// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MenuList _$MenuListFromJson(Map<String, dynamic> json) => MenuList(
      userId: json['userId'] as int?,
      ingredients: (json['ingredients'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      page: json['page'] as int?,
      size: json['size'] as int?,
    );

Map<String, dynamic> _$MenuListToJson(MenuList instance) => <String, dynamic>{
      'userId': instance.userId,
      'ingredients': instance.ingredients,
      'page': instance.page,
      'size': instance.size,
    };
