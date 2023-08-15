import 'package:dio/dio.dart';
import 'package:ottugi_curry/model/recipe_response.dart';
import 'package:get/get.dart';
import 'package:ottugi_curry/repository/recommend_repository.dart';

class LoginRatingController {
  RxList<RecipeResponse> randomRatingList = <RecipeResponse>[].obs;
  // 평점 -> 저장된 평점 말고 사용자가 조정하는 평점
  RxList<double> rating = <double>[].obs;
  RxBool isEmptyRating = false.obs;

  Future<void> loadRandomRating() async { // 랜덤 레시피 받아오기
    try {
      Dio dio = Dio();
      RecommendRepository recommendRepository = RecommendRepository(dio);
      final resp = await recommendRepository.getRecommendInitialRating();
      randomRatingList.value = resp;

    } on DioException catch (e) {
      print('loadRandomRating error : $e');
      return;
    }
  }
}