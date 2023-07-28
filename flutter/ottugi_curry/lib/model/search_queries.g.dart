// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_queries.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchQueries _$SearchQueriesFromJson(Map<String, dynamic> json) =>
    SearchQueries(
      composition: json['composition'] as String?,
      difficulty: json['difficulty'] as String?,
      name: json['name'] as String?,
      page: json['page'] as int?,
      size: json['size'] as int?,
      time: json['time'] as String?,
      userId: json['userId'] as int,
    );

Map<String, dynamic> _$SearchQueriesToJson(SearchQueries instance) =>
    <String, dynamic>{
      'composition': instance.composition,
      'difficulty': instance.difficulty,
      'name': instance.name,
      'page': instance.page,
      'size': instance.size,
      'time': instance.time,
      'userId': instance.userId,
    };
