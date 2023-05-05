import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ottugi_curry/model/user.dart';
import 'package:ottugi_curry/repository/user_repository.dart';

class LoginController {
  Future loginGoogle() async {
    GoogleSignIn googleSignIn = GoogleSignIn(
      clientId: '533961426623-17qecigrqom78pqt8ts3p5kccjb1d6ns.apps.googleusercontent.com',
    );
    GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      print('google login 성공: $googleSignInAccount');
      login(googleSignInAccount.email, googleSignInAccount.displayName!);
    }
  }

  login(String email, String nickname) async {
    try {
      Dio dio = Dio();
      UserRepository userRepository = UserRepository(dio);

      print('$nickname, $email');
      final resp = await userRepository.saveLogin(
          User(email: email, nickname: nickname));
      print('response: ${resp.id}, ${resp.email}, ${resp.nickname}, ${resp.token}');

      // 로그인 성공-> 메인 페이지 이동
      Get.offAndToNamed('/main');
    } on DioError catch (e) {
      print('DioError: $e');
    }
  }
}