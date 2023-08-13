import 'package:ottugi_curry/model/user_response.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'login_repository.g.dart';

@RestApi(baseUrl: "http://localhost:8080")
abstract class LoginRepository {
  factory LoginRepository(Dio dio, {String baseUrl}) = _LoginRepository;

  // 소셜 회원가입과 로그인
  @POST('/auth/login')
  Future<UserResponse> postAuthLogin(@Body() UserResponse user);

  // 토큰 재발급
  @POST('/auth/reissue')
  Future<UserResponse> postAuthReissue(@Query('email') String email);
}