import 'package:ottugi_curry/model/user_response.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'user_repository.g.dart';

@RestApi(baseUrl: "http://192.168.219.105:8080")
abstract class UserRepository {
  factory UserRepository(Dio dio, {String baseUrl}) = _UserRepository;

  // 회원 정보 조회
  @GET('/api/user/getProfile')
  Future<UserResponse> getProfile(@Query("id") int id);

  // 회원 정보 수정
  @PUT('/api/user/setProfile')
  Future<UserResponse> setProfile(@Body() UserResponse user);

  // 회원 탈퇴
  @DELETE('/api/user/setWithdraw')
  Future<bool> setWithdraw(@Query("id") int id);

  // 소셜 회원가입과 로그인
  @POST('/auth/login')
  Future<UserResponse> saveLogin(@Body() UserResponse user);
}
