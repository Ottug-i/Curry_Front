// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserResponse _$UserResponseFromJson(Map<String, dynamic> json) => UserResponse(
      email: json['email'] as String?,
      id: json['id'] as int?,
      nickName: json['nickName'] as String?,
      token: json['token'] as String?,
    );

Map<String, dynamic> _$UserResponseToJson(UserResponse instance) =>
    <String, dynamic>{
      'email': instance.email,
      'id': instance.id,
      'nickName': instance.nickName,
      'token': instance.token,
    };
