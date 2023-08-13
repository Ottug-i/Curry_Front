import 'package:ottugi_curry/model/user_response.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'user_repository.g.dart';

@RestApi(baseUrl: "http://192.168.0.51:8080")
abstract class UserRepository {
  factory UserRepository(Dio dio, {String baseUrl}) = _UserRepository;

  // 회원 정보 조회
  @GET('/api/user')
  Future<UserResponse> getProfile(@Query("id") int id);

  // 회원 정보 수정
  @PUT('/api/user')
  Future<UserResponse> setProfile(@Body() UserResponse user);

  // 회원 탈퇴
  @DELETE('/api/user/withdraw')
  Future<bool> setWithdraw(@Query("id") int id);
}
