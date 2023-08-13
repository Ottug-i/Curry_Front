import 'package:dio/dio.dart';
import 'package:ottugi_curry/model/recipe_response.dart';
import 'package:get/get.dart';
import 'package:ottugi_curry/repository/recommend_repository.dart';

class LoginRatingController {
  RxList<RecipeResponse> randomRatingList = <RecipeResponse>[].obs;
  // 평점 -> 저장된 평점 말고 사용자가 조정하는 평점
  RxList<double> rating = <double>[].obs;
  RxList<double> previousRating = <double>[].obs;
  RxBool isEmptyRating = false.obs;

  Future<void> loadRandomRating() async { // 랜덤 레시피 받아오기
    try {

      // 임시 데이터 저장 - 추천 레시피 10개로 사용하기
      Dio dio = Dio();
      RecommendRepository recommendRepository = RecommendRepository(dio);
      final resp = await recommendRepository.getRating(1, [6842324, 6845721, 6845906, 6846020, 6846262], 1);
      randomRatingList.value = resp;

    } on DioException catch (e) {
      print('loadRandomRating error : $e');
      return;
    }
  }
}