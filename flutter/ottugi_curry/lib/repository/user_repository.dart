import 'package:ottugi_curry/model/user.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'user_repository.g.dart';

@RestApi(baseUrl: "http://localhost:8080")
abstract class UserRepository {
  factory UserRepository(Dio dio, {String baseUrl}) = _UserRepository;

  // 회원 정보 조회
  @GET('/api/user/getProfile')
  Future<User> getProfile(@Query("id") int id);
  
  // 회원 정보 수정
  @PUT('/api/user/setProfile')
  Future<User> setProfile(@Body() User user);

  // 회원 탈퇴
  @DELETE('/api/user/setWithdraw')
  Future<User> setWithdraw(@Query("id") int id);

  // 소셜 회원가입과 로그인
  @POST('/auth/login')
  Future<User> saveLogin(@Body() User user);
}