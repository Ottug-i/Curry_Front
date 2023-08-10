import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:ottugi_curry/model/additional_prop.dart';
import 'package:ottugi_curry/model/rating_response.dart';
import 'package:ottugi_curry/model/recipe_response.dart';
import 'package:ottugi_curry/model/rating_request.dart';
import 'package:ottugi_curry/repository/bookmark_repository.dart';
import 'package:ottugi_curry/repository/recommend_repository.dart';

class RecommendController {
  RxList<RecipeResponse> bookmarkRecList = <RecipeResponse>[].obs;
  RxList<RecipeResponse> ratingRecList = <RecipeResponse>[].obs;
  Rx<RatingResponse> userRating = RatingResponse().obs;

  // 북마크한 레시피 아이디 담는 셋
  RxSet<int> bookmarkIdList = <int>{}.obs;

  // 북마크 토글 상태 저장
  RxList<bool> toggleSelected = <bool>[].obs;

  Future<void> loadBookmarkRec({int? page, required int recipeId}) async { // 레시피 북마크 추천
    try {
      Dio dio = Dio();
      RecommendRepository recommendRepository = RecommendRepository(dio);
      final resp = await recommendRepository.getBookmark(page ?? 1, recipeId, 1);
      bookmarkRecList.value = resp;
      print('print bookmarkRecListFirstName: ${bookmarkRecList.first.name}');

    } on DioException catch (e) {
      print('loadBookmarkRec error : $e');
      return;
    }
  }

  Future<void> getBookmarkList(int page) async { // 북마크한 레시피 아이디 가져오기
    int size = 50; // 반복을 적게 하기 위해 큰 size로 받아옴
    if (page == 1) { // 최초 검색시 초기화
      bookmarkIdList.clear();
    }

    try {
      Dio dio = Dio();
      BookmarkRepository bookmarkRepository = BookmarkRepository(dio);
      final resp = await bookmarkRepository.getBookmark(page, size, 1);

      // 레시피 아이디만 가져와 저장
      resp.content?.map((e) => bookmarkIdList.add(e.recipeId)).toList();

      // 다음 페이지 있을 경우, 다음 페이지의 북마크 가져오기
      if (resp.totalElements! > (size * page)) {
        getBookmarkList(page + 1);
      }

      // 북마크한 레시피 아이디 리스트 넣어 평점으로 레시피 추천 받기 (set -> list 변환)
      loadRatingRec(bookmarkList: bookmarkIdList.toList());

    } on DioException catch (e) {
      print('getBookmarkList error : $e');
      return;
    }
  }

  Future<void> loadRatingRec({required List<int> bookmarkList, int? page}) async { // 레시피 평점 추천
    try {
      Dio dio = Dio();
      RecommendRepository recommendRepository = RecommendRepository(dio);
      final resp = await recommendRepository.getRating(page ?? 1, bookmarkList, 1);
      ratingRecList.value = resp;

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