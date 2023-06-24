import 'package:dio/dio.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:ottugi_curry/config/config.dart';
import 'package:ottugi_curry/repository/recipe_repository.dart';
import 'package:ottugi_curry/utils/long_string_to_list_utils.dart';
import 'package:ottugi_curry/utils/user_profile_utils.dart';
import 'package:ottugi_curry/model/bookmark_update.dart';
import 'package:ottugi_curry/repository/bookmark_repository.dart';

class RecipeDetailController {
  // RecipeResponse
  RxString composition = ''.obs;
  RxString difficulty = ''.obs;
  RxInt id = 0.obs;
  RxString ingredients = ''.obs;
  RxList<String> ingredientsTitle = <String>[].obs;
  RxList<String> ingredientsContent = <String>[].obs;
  RxList<List<String>> ingredientsContentList = <List<String>>[[]].obs;
  RxBool isBookmark = false.obs;
  RxString name = ''.obs;
  RxList<String> orders = <String>[].obs;
  RxList<String> photo = <String>[].obs;
  RxString servings = ''.obs;
  RxString thumbnail = ''.obs;
  RxString time = ''.obs;

  // 조리순서 보기 방식 선택
  RxInt orderViewOption = Config.galleryView.obs;

  Future<void> loadRecipeDetail(int recipeId) async {
    try {
      Dio dio = Dio();
      RecipeRepository recipeRepository = RecipeRepository(dio);
      print('print getUserId(): ${getUserId()}');
      final resp = await recipeRepository.getRecipeDetail(
          recipeId, 1); // TODO: userId 수정
      print('print respIngredients: ${resp.ingredients!}');

      // 응답 값 변수에 저장
      composition.value = resp.composition!;
      difficulty.value = resp.difficulty!;
      id.value = resp.recipeId!;
      ingredients.value = resp.ingredients!;
      isBookmark.value = resp.isBookmark!;
      name.value = resp.name!;
      orders.value = splitToVerBar(resp.orders!);
      photo.value = splitToVerBar(resp.photo!); // 문자열 |(vertical Bar)로 분할
      servings.value = resp.servings!;
      thumbnail.value = resp.thumbnail!;
      time.value = resp.time!;

      // 대괄호 있는 문자열 분할
      splitTitleAndContent(
          ingredients.value, ingredientsTitle, ingredientsContent);
      splitIngredientsContent();
    } on DioError catch (e) {
      print('loadRecipeDetail: $e');
      return;
    }
  }

  void updateOrderViewOption(int newOption) {
    orderViewOption.value = newOption;
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
}
