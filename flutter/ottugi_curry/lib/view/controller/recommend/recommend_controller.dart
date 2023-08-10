import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:ottugi_curry/model/additional_prop.dart';
import 'package:ottugi_curry/model/rating_response.dart';
import 'package:ottugi_curry/model/recipe_response.dart';
import 'package:ottugi_curry/model/rating_request.dart';
import 'package:ottugi_curry/repository/recommend_repository.dart';

class RecommendController {
  RxList<RecipeResponse> bookmarkRecList = <RecipeResponse>[].obs;
  RxList<RecipeResponse> ratingRecList = <RecipeResponse>[].obs;
  Rx<RatingResponse> userRating = RatingResponse().obs;

  Future<void> loadBookmarkRec({int? page, required int recipeId}) async { // 레시피 북마크 추천
    try {
      Dio dio = Dio();
      RecommendRepository recommendRepository = RecommendRepository(dio);
      final resp = await recommendRepository.getBookmark(page ?? 1, recipeId, 1);
      bookmarkRecList.value = resp;

    } on DioException catch (e) {
      print('loadBookmarkRec error : $e');
      return;
    }
  }

  Future<void> loadRatingRec({required List<int> bookmarkList, int? page}) async { // 레시피 평점 추천
    try {
      Dio dio = Dio();
      RecommendRepository recommendRepository = RecommendRepository(dio);
      final resp = await recommendRepository.getRating(page ?? 1, bookmarkList, 1);
      ratingRecList.value = resp;
      print('print ratingRecListValueFirstName: ${ratingRecList.first.name}');

    } on DioException catch (e) {
      print('loadRatingRec error : $e');
      return;
    }
  }

  Future<void> loadUserRating({required int recipeId}) async { // 레시피 평점 조회
    try {
      Dio dio = Dio();
      RecommendRepository recommendRepository = RecommendRepository(dio);
      final resp = await recommendRepository.getUserRating(recipeId, 1);
      userRating.value = resp;
    } on DioException catch (e) {
      print('loadUserRating error : $e');
      return;
    }



  }

  Future<void> updateUserRating({required List<AdditionalProp> additionalPropList}) async { // 레시피 평점 추가
    try {
      Dio dio = Dio();
      RecommendRepository recommendRepository = RecommendRepository(dio);
      
      RatingRequest ratingRequest = RatingRequest(
        new_user_ratings_dic: additionalPropList,
        user_id: 1
      );
      final resp = await recommendRepository.postUserRating(ratingRequest);
      // resp true면 정상처리 된 것

    } on DioException catch (e) {
      print('updateUserRating error : $e');
      return;
    }
  }
}