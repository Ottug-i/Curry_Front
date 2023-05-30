import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:localstorage/localstorage.dart';
import 'package:ottugi_curry/view/page/bookmark/bookmark_page.dart';
import 'package:ottugi_curry/view/page/login/login_page.dart';
import 'package:ottugi_curry/view/page/main/main_page.dart';
import 'package:ottugi_curry/view/page/recipe_camera/recipe_camera_page.dart';
import 'package:ottugi_curry/view/page/recipe_detail/recipe_detail_page.dart';
import 'package:ottugi_curry/view/page/user/user_page.dart';

// token 저장하는 secure storage
FlutterSecureStorage tokenStorage = const FlutterSecureStorage();
// 회원 정보 저장하는 local storage: id, email, nickName, 소셜로그인 플랫폼 이름(kakao/google)
LocalStorage userStorage = LocalStorage('user');
LocalStorage socialStorage = LocalStorage('social');

/// 앱 전체에 공유하는 static 변수 저장
class Config {
  static final routers = [
    //bottom nav bar
    GetPage(name: '/main', page: () => MainPage(), transition: Transition.noTransition),
    GetPage(name: '/recipe', page: () => RecipeCameraPage(), transition: Transition.noTransition),
    GetPage(name: '/user', page: () => UserPage(), transition: Transition.noTransition),
    GetPage(name: '/bookmark', page: () => BookmarkPage(), transition: Transition.noTransition),
    GetPage(name: '/login', page: () => LoginPage(), transition: Transition.noTransition),
    GetPage(name: '/recipe_detail', page: () => RecipeDetailPage(), transition: Transition.noTransition),
  ];

  // 레시피 상세 페이지에서 조리순서를 보는 방식: 음성/사진/즐글
  static int soundView = 0;
  static int galleryView = 1;
  static int textListView = 2;

  // storage 이름
  static String id = 'id';
  static String email = 'email';
  static String nickName = 'nickName';
  static String social = 'social';
  static String kakao = 'kakao';
  static String google = 'google';
}

enum SocialPlatform { none, google, kakao }
SocialPlatform social = SocialPlatform.none;