import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:localstorage/localstorage.dart';
import 'package:ottugi_curry/view/page/bookmark/bookmark_page.dart';
import 'package:ottugi_curry/view/page/login/login_page.dart';
import 'package:ottugi_curry/view/page/login/login_rating_page.dart';
import 'package:ottugi_curry/view/page/main/main_page.dart';
import 'package:ottugi_curry/view/page/rating_recommend/rating_rec_page.dart';
import 'package:ottugi_curry/view/page/recipe_camera/recipe_camera_page.dart';
import 'package:ottugi_curry/view/page/recipe_detail/recipe_detail_page.dart';
import 'package:ottugi_curry/view/page/recipe_list/recipe_recs_page.dart';
import 'package:ottugi_curry/view/page/text_search/text_search_page.dart';
import 'package:ottugi_curry/view/page/user/user_page.dart';

// token 저장하는 secure storage
FlutterSecureStorage tokenStorage = const FlutterSecureStorage();
// 회원 정보 저장하는 local storage: id, email, nickName, 소셜로그인 플랫폼 이름(kakao/google)
LocalStorage userStorage = LocalStorage('user');
// LocalStorage socialStorage = LocalStorage('social');

/// 앱 전체에 공유하는 static 변수 저장
class Config {
  static final routers = [
    //bottom nav bar
    GetPage(
        name: '/main',
        page: () => const MainPage(),
        transition: Transition.noTransition),
    GetPage(
        name: '/recipe',
        page: () => const RecipeCameraPage(),
        transition: Transition.noTransition),
    GetPage(
        name: '/user',
        page: () => const UserPage(),
        transition: Transition.noTransition),
    GetPage(
        name: '/bookmark',
        page: () => const BookmarkPage(),
        transition: Transition.noTransition),
    GetPage(
        name: '/login',
        page: () => const LoginPage(),
        transition: Transition.noTransition),
    GetPage(
        name: '/recipe_detail',
        page: () => const RecipeDetailPage(),
        transition: Transition.noTransition),
    GetPage(
        name: '/search',
        page: () => const TextSearchPage(),
        transition: Transition.noTransition),
    GetPage(
        name: '/rating',
        page: () => const RatingRecPage(),
        transition: Transition.noTransition),
    GetPage(
        name: '/camera_rec',
        page: () => const RecipeRecsPage(),
        transition: Transition.noTransition),
    GetPage(
        name: '/login_rating',
        page: () => const LoginRatingPage(),
        transition: Transition.noTransition),
  ];

  // 레시피 상세 페이지에서 조리순서를 보는 방식: 음성/사진/즐글
  static int galleryView = 0;
  static int textListView = 1;

  // 레시피 상세 페이지에서 TTS 상태: 대기(정지)/실행/일시정지
  static String stopped = 'stopped';
  static String playing = 'playing';
  static String paused = 'paused';

  // storage 이름
  static String id = 'id';
  static String email = 'email';
  static String nickName = 'nickName';
  static String social = 'social';
  static String kakao = 'kakao';
  static String google = 'google';

  // 리스트 화면에서 한 페이지당 보여줄 갯수
  static int elementNum = 10;

  // 검색 필터들
  final timeType = [
    '5분 이내',
    '10분 이내',
    '20분 이내',
    '30분 이내',
    '60분 이내',
    '90분 이내',
    '120분 이내',
    '2시간 이상'
  ];

  final compoType = ['가볍게', '든든하게', '푸짐하게'];

  final levelType = ['아무나', '초급', '중급', '고급', '마스터'];

  // 알림 메시지 멘트
  final breakfastMessage = ['오늘 아침은 무엇을 먹을까요? 추천 받아 보세요!', '상쾌한 하루를 위한 아침 메뉴를 추천 받아 보세요!', '레시피를 추천 받고 요리해 보세요!'];
  final lunchMessage = ['점심 메뉴가 고민 된다면, 추천 해드릴게요.', '카레와 함께 오늘도 맛있는 점심 드세요!', '당신을 위한 점심 메뉴가 준비되어 있어요.'];
  final dinnerMessage = ['오늘 저메추는 카레가 해드릴게요!', '원하는 저녁 메뉴를 카레에서 골라보세요!', '고생한 나를 위한 저녁! 메뉴를 추천해 드릴게요.'];
}

enum SocialPlatform { none, google, kakao }

SocialPlatform social = SocialPlatform.none;
