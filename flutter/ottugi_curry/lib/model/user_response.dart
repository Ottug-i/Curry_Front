import 'package:json_annotation/json_annotation.dart';

part 'user_response.g.dart';

@JsonSerializable()
class  UserResponse {
  String? email;
  int? id;
  String? nickName;
  String? role;
  String? token;
  bool? isNew;

  UserResponse({
    this.email,
    this.id,
    this.nickName,
    this.role,
    this.token,
    this.isNew
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) => _$UserResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserResponseToJson(this);
}
