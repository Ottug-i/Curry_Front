import 'package:dio/dio.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:ottugi_curry/config/config.dart';
import 'package:ottugi_curry/model/recipe_detail_response.dart';
import 'package:ottugi_curry/repository/recipe_repository.dart';
import 'package:ottugi_curry/utils/long_string_to_list_utils.dart';
import 'package:ottugi_curry/utils/user_profile_utils.dart';
import 'package:ottugi_curry/model/bookmark_update.dart';
import 'package:ottugi_curry/repository/bookmark_repository.dart';

class RecipeDetailController {
  // RecipeResponse
  Rx<RecipeDetailResponse> recipeResponse = RecipeDetailResponse(
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

  // 줄글 데이터 변환하여 저장하는 변수들
  RxList<String> ingredientsTitle = <String>[].obs;
  RxList<String> ingredientsContent = <String>[].obs;
  RxList<List<String>> ingredientsContentList = <List<String>>[[]].obs;
  RxList<String> ordersList = <String>[].obs;
  RxList<String> photoList = <String>[].obs;

  // 조리순서 보기 방식 선택
  RxInt orderViewOption = Config.galleryView.obs;

  // TTS 음성 출력 여부
  Rx<FlutterTts> tts = FlutterTts().obs;
  RxString ttsStatus = Config.stopped.obs;

  // 이전 페이지 루트 저장
  RxString previousRoute = ''.obs;

  Future<void> loadRecipeDetail(int recipeId) async {
    try {
      Dio dio = Dio();
      RecipeRepository recipeRepository = RecipeRepository(dio);
      print('print getUserId(): ${getUserId()}');
      final resp = await recipeRepository.getRecipeDetail(
          recipeId, 1); // TODO: userId 수정

      recipeResponse.value = resp;

      // 응답 값 변수에 저장
      ordersList.value = splitToVerBar(recipeResponse.value.orders!);
      photoList.value = splitToVerBar(recipeResponse.value.photo!); // 문자열 |(vertical Bar)로 분할

      // 대괄호 있는 문자열 분할
      splitTitleAndContent(
          recipeResponse.value.ingredients ?? '', ingredientsTitle, ingredientsContent);
      splitIngredientsContent();
    } on DioException catch (e) {
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

  Future<void> speakTTS() async { // 전체 옵션 기준으로 실행
    // tts 실행
    ttsStatus.value = Config.playing;
    await tts.value.speak(ordersList.toString());
    await tts.value.awaitSpeakCompletion(true);

    // tts가 읽는 동안 기다렸다가, 종료되면 status를 stopped로 변경
    ttsStatus.value = Config.stopped;
    tts.value.stop();
  }

  void pauseTTS() {
    ttsStatus.value = Config.paused;
    tts.value.pause();
  }

  void stopTTS() {
    ttsStatus.value = Config.stopped;
    tts.value.stop();
  }
}
