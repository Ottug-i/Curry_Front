import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ottugi_curry/config/config.dart';
import 'package:ottugi_curry/model/user.dart';
import 'package:ottugi_curry/repository/user_repository.dart';

class LoginController {
  Future<void> loginGoogle() async {
    GoogleSignIn googleSignIn = GoogleSignIn(
      clientId: '533961426623-17qecigrqom78pqt8ts3p5kccjb1d6ns.apps.googleusercontent.com',
    );
    GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      print('google login 성공: $googleSignInAccount');
      login(googleSignInAccount.email, googleSignInAccount.displayName!);
    }
  }

  void login(String email, String nickName) async {
    try {
      Dio dio = Dio();
      UserRepository userRepository = UserRepository(dio);

      print('$nickName, $email');
      final resp = await userRepository.saveLogin(
          User(email: email, nickName: nickName));
      print('response: ${resp.id}, ${resp.email}, ${resp.nickName}, ${resp.token}');

      // 로그인 성공
      // storage 에 token 저장
      await tokenStorage.write(key: 'token', value: resp.token.toString());
      // local storage 에 id, email, nickName 저장
      userStorage.setItem('id', resp.id.toString());
      userStorage.setItem('EMAIL', resp.email.toString());
      userStorage.setItem('nickName', resp.nickName.toString());
      // Get.put(UserController());
      // final userController = Get.find<UserController>();
      // userController.userId.value = resp.id!;
      // userController.email.value = resp.email.toString();
      // userController.nickName.value = resp.nickName.toString();

      // 메인 페이지 이동
      Get.offAndToNamed('/main');
    } on DioError catch (e) {
      print('$e');
      return;
    }
  }

  void checkLogin() async {
    final token = await tokenStorage.read(key: 'token');
    if (token != null) {
      Get.offAndToNamed('/main');
    }
  }
}