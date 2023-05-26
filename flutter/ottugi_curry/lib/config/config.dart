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
// token 제외 회원 정보 저장하는 local storage
LocalStorage userStorage = LocalStorage('user');

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
}