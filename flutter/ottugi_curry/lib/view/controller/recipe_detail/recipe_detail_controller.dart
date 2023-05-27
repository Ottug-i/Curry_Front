import 'package:dio/dio.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:ottugi_curry/config/config.dart';
import 'package:ottugi_curry/repository/recipe_repository.dart';
import 'package:ottugi_curry/utils/hash_to_list_utils.dart';
import 'package:ottugi_curry/utils/user_profile_utils.dart';

class RecipeDetailController {
  // RecipeResponse
  RxString composition = ''.obs;
  RxString difficulty = ''.obs;
  RxInt id = 0.obs;
  RxList<String> ingredients = <String>[].obs;
  RxBool isBookmark = false.obs;
  RxString name = ''.obs;
  RxList<String> orders = <String>[].obs;
  RxList<String> photo = <String>[].obs;
  RxList<String> seasoning = <String>[].obs;
  RxString thumbnail = ''.obs;
  RxString time = ''.obs;

  // 조리순서 보기 방식 선택
  RxInt orderViewOption = Config.galleryView.obs;

  Future<void> loadRecipeDetail(int recipeId) async {
    try {
      Dio dio = Dio();
      RecipeRepository recipeRepository = RecipeRepository(dio);
      print('print getUserId(): ${getUserId()}');
      final resp = await recipeRepository.getRecipeDetail(recipeId, 1);

      // 응답 값 변수에 저장
      composition.value = resp.composition!;
      difficulty.value = resp.difficulty!;
      id.value = resp.id!;
      ingredients.value = hashToList(resp.ingredients!);
      isBookmark.value = resp.isBookmark!;
      name.value = resp.name!;
      orders.value = hashToList(resp.orders!);
      photo.value = hashToList(resp.photo!);
      seasoning.value = hashToList(resp.seasoning!);
      thumbnail.value = resp.thumbnail!;
      time.value = resp.time!;
    } on DioError catch (e) {
      print('loadRecipeDetail: $e');
      return;
    }
  }

  void updateOrderViewOption(int newOption) {
    orderViewOption.value = newOption;
  }
}