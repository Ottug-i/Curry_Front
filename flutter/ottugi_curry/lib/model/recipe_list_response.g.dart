// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecipeListResponse _$RecipeListResponseFromJson(Map<String, dynamic> json) =>
    RecipeListResponse(
      content: (json['content'] as List<dynamic>?)
          ?.map((e) => MenuModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalPages: json['totalPages'] as int?,
      totalElements: json['totalElements'] as int?,
      last: json['last'] as bool?,
      size: json['size'] as int?,
      number: json['number'] as int?,
      first: json['first'] as bool?,
      empty: json['empty'] as bool?,
    );

Map<String, dynamic> _$RecipeListResponseToJson(RecipeListResponse instance) =>
    <String, dynamic>{
      'content': instance.content,
      'totalPages': instance.totalPages,
      'totalElements': instance.totalElements,
      'size': instance.size,
      'number': instance.number,
      'last': instance.last,
      'first': instance.first,
      'empty': instance.empty,
    };
