import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:ottugi_curry/config/config.dart';
import 'package:ottugi_curry/config/dio_config.dart';
import 'package:ottugi_curry/model/user_response.dart';
import 'package:ottugi_curry/repository/login_repository.dart';
import 'package:ottugi_curry/utils/user_profile_utils.dart';

class LoginController {
  // 구글 소셜 로그인
  Future<void> loginGoogle() async {
    GoogleSignIn googleSignIn = GoogleSignIn();
    GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      print('google login 성공: $googleSignInAccount');
      await userStorage.setItem(Config.social, Config.google);

      // 최종 로그인
      handleLogin(googleSignInAccount.email, googleSignInAccount.displayName!);
    }
  }

  // 카카오 소셜 로그인
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

  // 사용자 정보 요청
  Future<void> getUserKakao() async {
    try {
      User user = await UserApi.instance.me();
      String email = user.kakaoAccount?.email ?? '';
      String nickName = user.kakaoAccount?.profile?.nickname ?? '';

      if (email.isNotEmpty && nickName.isNotEmpty) {
        await userStorage.setItem(Config.social, Config.kakao);

        // 최종 로그인
        handleLogin(email, nickName);
      }
    } catch (error) {
      print('사용자 정보 요청 실패 $error');
    }
  }

  // 최종 로그인
  Future<void> handleLogin(String email, String nickName) async {
    try {
      final dio = createDioWithoutToken();
      LoginRepository loginRepository = LoginRepository(dio);

      if (nickName.length >= 10) {
        nickName = nickName.substring(0, 11); // 닉네임 최대 10글자
      }

      print('$nickName, $email');
      final resp = await loginRepository
          .postAuthLogin(UserResponse(email: email, nickName: nickName));
      print(
          '최종 로그인 성공: ${resp.isNew}, ${resp.id}, ${resp.email}, ${resp.nickName}, ${resp.token}');

      // 로그인 성공
      // storage 에 token 저장
      await tokenStorage.write(key: 'token', value: resp.token.toString());
      // local storage 에 id, email, nickName 저장
      await userStorage.setItem(Config.id, resp.id.toString());
      await userStorage.setItem(Config.email, resp.email.toString());
      await userStorage.setItem(Config.nickName, resp.nickName.toString());

      if (resp.isNew == true) {
        // 회원가입인 경우 - 랜덤 레시피 평점 매기기
        Get.offAndToNamed('/login_rating');
      } else {
        // 메인 페이지 이동
        Get.offAndToNamed('/main');
      }
    } on DioException catch (e) {
      print('login $e');
      return;
    }
  }

  // 로그인 여부 확인
  Future<void> checkLogin() async {
    // 토근 재발급
    // 성공 -> 로그인 중. 새로운 토큰 발급 및 저장
    // 실패 -> 로그인 상태 아님. 로그아웃.
    if (getUserEmail().isEmpty) {
      print('checkLogin - No UserEmail 로그인 상태 아님');
      return;
    }

    try {
      final dio = createDioWithoutToken();
      LoginRepository loginRepository = LoginRepository(dio);

      final resp = await loginRepository.postAuthReissue(getUserEmail());
      final token = resp.token.toString();
      print('checkLogin - 로그인 중: ${token}');

      // storage 에 새로운 token 저장
      await tokenStorage.write(key: 'token', value: token);
      // 메인화면으로 이동
      Get.offAndToNamed('/main');
    } on DioException catch (e) {
      print('checkLogin: $e');

      if (e.response?.statusCode == 401) {
        print('checkLogin - 401 Err 로그인 상태 아님');
        // 로그아웃
        Get.put(LoginController());
        Get.find<LoginController>().handleLogout();
      }
      return;
    }

  }

  // 로그아웃
  void handleLogout() async {
    // 소셜 로그인 플랫폼 로그아웃
    final social = await userStorage.getItem(Config.social);
    print('print social: $social');
    if (social == Config.google) {
      // 구글 로그아웃
      await GoogleSignIn().signOut();
    } else if (social == Config.kakao) {
      // 카카오 로그아웃
      try {
        await UserApi.instance.logout();
        print('로그아웃 성공, SDK에서 토큰 삭제');
      } catch (error) {
        print('로그아웃 실패, SDK에서 토큰 삭제 $error');
      }
    }

    // 저장해둔 회원 정보 삭제
    await tokenStorage.delete(key: 'token');

    await userStorage.deleteItem(Config.id);
    await userStorage.deleteItem(Config.email);
    await userStorage.deleteItem(Config.nickName);
    await userStorage.deleteItem(Config.social);

    // 다른 페이지에서 로그아웃 요청 -> 로그인 페이지로 이동
    // 로그인 페이지에서 로그인 여부 확인 후 로그인 상태 아니어서 로그아웃 요청 -> 페이지 이동 x
    if (!Get.currentRoute.contains('/login')) {
      Get.offAndToNamed('/login');
    }
  }
}
