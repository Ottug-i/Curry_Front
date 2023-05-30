import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:ottugi_curry/config/config.dart';
import 'package:ottugi_curry/model/user_response.dart';
import 'package:ottugi_curry/repository/user_repository.dart';

class LoginController {
  Future<void> loginGoogle() async {
    GoogleSignIn googleSignIn = GoogleSignIn(
    );
    GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      print('google login 성공: $googleSignInAccount');
      login(googleSignInAccount.email, googleSignInAccount.displayName!);
    }
  }

  Future<void> loginKakao() async {
    if (await isKakaoTalkInstalled()) {
      try {
        await UserApi.instance.loginWithKakaoTalk();
        print('로그인 성공: 카카오톡');
        getUserKakao();
      } catch (error) {
        print('로그인 실패: 카카오톡 $error');

        // 사용자가 카카오톡 설치 후 디바이스 권한 요청 화면에서 로그인을 취소한 경우,
        // 의도적인 로그인 취소로 보고 카카오계정으로 로그인 시도 없이 로그인 취소로 처리 (예: 뒤로 가기)
        if (error is PlatformException && error.code == 'CANCELED') {
          return;
        }
        // 카카오톡에 연결된 카카오계정이 없는 경우, 카카오계정으로 로그인
        try {
          await UserApi.instance.loginWithKakaoAccount();
          print('로그인 성공: 카카오계정');
          getUserKakao();
        } catch (error) {
          print('로그인 실패: 카카오계정 $error');
        }
      }
    } else {
      try {
        await UserApi.instance.loginWithKakaoAccount();
        print('로그인 성공: 카카오계정');
        getUserKakao();
      } catch (error) {
        print('로그인 실패: 카카오계정 $error');
      }
    }
  }

  Future<void> getUserKakao() async {
    try {
      User user = await UserApi.instance.me();
          String email = user.kakaoAccount?.email ?? '';
          String nickName = user.kakaoAccount?.profile?.nickname ?? '';

          if (email.isNotEmpty && nickName.isNotEmpty) {
            login(email, nickName);
          }
    } catch (error) {
      print('사용자 정보 요청 실패 $error');
    }
  }

  void login(String email, String nickName) async {
    try {
      Dio dio = Dio();
      UserRepository userRepository = UserRepository(dio);

      print('$nickName, $email');
      final resp = await userRepository.saveLogin(UserResponse(email: email, nickName: nickName));
      print('최종 로그인 성공: ${resp.id}, ${resp.email}, ${resp.nickName}, ${resp.token}');

      // 로그인 성공
      // storage 에 token 저장
      await tokenStorage.write(key: 'token', value: resp.token.toString());
      // local storage 에 id, email, nickName 저장
      userStorage.setItem('id', resp.id.toString());
      userStorage.setItem('email', resp.email.toString());
      userStorage.setItem('nickName', resp.nickName.toString());

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