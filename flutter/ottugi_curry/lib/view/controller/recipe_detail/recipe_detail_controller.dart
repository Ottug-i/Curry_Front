import 'package:dio/dio.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:ottugi_curry/config/config.dart';
import 'package:ottugi_curry/model/recipe_response.dart';
import 'package:ottugi_curry/repository/recipe_repository.dart';
import 'package:ottugi_curry/utils/long_string_to_list_utils.dart';
import 'package:ottugi_curry/utils/user_profile_utils.dart';
import 'package:ottugi_curry/model/bookmark_update.dart';
import 'package:ottugi_curry/repository/bookmark_repository.dart';

class RecipeDetailController {
  // RecipeResponse
  Rx<RecipeResponse> recipeResponse = RecipeResponse(
    composition: '',
    difficulty: '',
    recipeId: 0,
    ingredients: '',
    isBookmark: false,
    name: '',
    orders: '',
    photo: '',
    servings: '',
    thumbnail: '',
    time: '',

  ).obs;
  // RxString composition = ''.obs;
  // RxString difficulty = ''.obs;
  // RxInt id = 0.obs;
  // RxString ingredients = ''.obs;
  RxList<String> ingredientsTitle = <String>[].obs;
  RxList<String> ingredientsContent = <String>[].obs;
  RxList<List<String>> ingredientsContentList = <List<String>>[[]].obs;
  // RxBool isBookmark = false.obs;
  // RxString name = ''.obs;
  RxList<String> ordersList = <String>[].obs;
  RxList<String> photoList = <String>[].obs;
  // RxString servings = ''.obs;
  // RxString thumbnail = ''.obs;
  // RxString time = ''.obs;

  // 조리순서 보기 방식 선택
  RxInt orderViewOption = Config.galleryView.obs;
  // TTS 음성 출력 여부
  RxBool ttsStatus = false.obs;
  Rx<FlutterTts> tts = FlutterTts().obs;

  Future<void> loadRecipeDetail(int recipeId) async {
    try {
      Dio dio = Dio();
      RecipeRepository recipeRepository = RecipeRepository(dio);
      print('print getUserId(): ${getUserId()}');
      final resp = await recipeRepository.getRecipeDetail(
          recipeId, 1); // TODO: userId 수정

      recipeResponse.value = resp;

      // 응답 값 변수에 저장
      // composition.value = resp.composition!;
      // difficulty.value = resp.difficulty!;
      // id.value = resp.recipeId!;
      // ingredients.value = resp.ingredients!;
      // isBookmark.value = resp.isBookmark!;
      // name.value = resp.name!;
      ordersList.value = splitToVerBar(recipeResponse.value.orders!);
      photoList.value = splitToVerBar(recipeResponse.value.photo!); // 문자열 |(vertical Bar)로 분할
      // servings.value = resp.servings!;
      // thumbnail.value = resp.thumbnail!;
      // time.value = resp.time!;

      // 대괄호 있는 문자열 분할
      splitTitleAndContent(
          recipeResponse.value.ingredients ?? '', ingredientsTitle, ingredientsContent);
      splitIngredientsContent();
    } on DioError catch (e) {
      print('loadRecipeDetail: $e');
      return;
    }
  }

  Future<void> updateBookmark(int userId, int recipeId) async {
    print('Bookmrk의 updateData 실행');
    try {
      final BookmarkRepository bookmrkRepository = BookmarkRepository(Dio());

      final bookmrkItem = Bookmark(userId: userId, recipeId: recipeId);
      await bookmrkRepository.updateBookmark(bookmrkItem);
      await loadRecipeDetail(recipeId); // 재로딩
    } catch (error) {
      // 에러 처리
      print('Error updating bookmark: $error');
    }
  }

  void setTTS() { // TTS 기본 설정 
    tts.value.setLanguage('ko-KR');
    tts.value.setSpeechRate(0.4);
    tts.value.setVolume(1.0);
  }

  void speakTTS(String text) { // 각 옵션에서 실행
    print('print ttsStatusValue: ${ttsStatus.value}');
    if (ttsStatus.value == true) {
      tts.value.speak(text); // tts 실행
    } else {
      tts.value.stop();
    }
  }

  void speakOrderTTS() { // 전체 옵션 기준으로 실행
    print('print ordersListToString: ${ordersList.toString()}');
    print('print ttsStatusValue: ${ttsStatus.value}');
    if (ttsStatus.value == true) {
      tts.value.speak(ordersList.toString());
    } else {
      tts.value.stop();
    }
  }
}
