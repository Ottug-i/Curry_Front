import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:ottugi_curry/config/dio_config.dart';
import 'package:ottugi_curry/model/rating_response.dart';
import 'package:ottugi_curry/model/recipe_response.dart';
import 'package:ottugi_curry/model/rating_request.dart';
import 'package:ottugi_curry/repository/bookmark_repository.dart';
import 'package:ottugi_curry/repository/recommend_repository.dart';
import 'package:ottugi_curry/utils/user_profile_utils.dart';
import 'package:ottugi_curry/view/controller/bookmark/bookmark_list_controller.dart';

class RecommendController {
  RxList<RecipeResponse> bookmarkRecList = <RecipeResponse>[].obs;
  RxList<RecipeResponse> ratingRecList = <RecipeResponse>[].obs;
  Rx<RatingResponse> ratingResponse = RatingResponse().obs;

  // 북마크한 레시피 아이디 담는 셋
  RxSet<int> bookmarkIdSet = <int>{}.obs;
  // 북마크 토글 상태 저장
  RxList<bool> isSelected = <bool>[].obs;
  // 평점 -> 저장된 평점 말고 사용자가 조정하는 평점
  RxDouble rating = 0.0.obs;

  // 북마크에 따른 레시피 추천
  Future<void> loadBookmarkRec({int? page, required int recipeId}) async {
    try {
      final dio = createDio();
      RecommendRepository recommendRepository = RecommendRepository(dio);
      final resp = await recommendRepository.getRecommendBookmarkList(page ?? 1, recipeId, getUserId());
      bookmarkRecList.value = resp;

    } on DioException catch (e) {
      print('loadBookmarkRec error : $e');
      return;
    }
  }

  // 북마크한 레시피 아이디 가져오기 -> 레시피 평점에 따른 레시피 추천에 사용
  Future<void> getBookmarkList(int page) async {
    int size = 50; // 반복을 적게 하기 위해 큰 size로 받아옴
    if (page == 1) { // 최초 검색시 초기화
      bookmarkIdSet.clear();
    }

    try {
      final dio = createDio();
      BookmarkRepository bookmarkRepository = BookmarkRepository(dio);
      final resp = await bookmarkRepository.getBookmark(page, size, 1);

      // 레시피 아이디만 가져와 저장
      resp.content?.map((e) => bookmarkIdSet.add(e.recipeId)).toList();

      // 다음 페이지 있을 경우, 다음 페이지의 북마크 가져오기
      if (resp.totalElements! > (size * page)) {
        getBookmarkList(page + 1);
      }

      // 북마크한 레시피 아이디 리스트 넣어 평점으로 레시피 추천 받기 (set -> list 변환)
      loadRatingRec(bookmarkList: bookmarkIdSet.toList());

    } on DioException catch (e) {
      print('getBookmarkList error : $e');
      return;
    }
  }

  // 레시피 평점에 따른 레시피 추천
  Future<void> loadRatingRec({required List<int> bookmarkList, int? page}) async {
    try {
      final dio = createDio();
      RecommendRepository recommendRepository = RecommendRepository(dio);
      final resp = await recommendRepository.getRecommendRatingList(page ?? 1, bookmarkList, getUserId());
      ratingRecList.value = resp;

    } on DioException catch (e) {
      print('loadRatingRec error : $e');
      return;
    }
  }

  // 레시피 평점 조회
  Future<void> loadRating({required int recipeId}) async {
    rating.value = 0.0; // 초기화

    try {
      final dio = createDio();
      RecommendRepository recommendRepository = RecommendRepository(dio);

      RatingResponse? resp= await recommendRepository.getRecommendRating(recipeId, getUserId());
      if (resp == null) { // 평점 매기지 않았으면 0.0으로 초기화
        ratingResponse.value = RatingResponse(rating: 0.0, recipeId: recipeId, userId: 1);
      } else {
        ratingResponse.value = resp; // 평점 매긴 경우
      }

      print('print userRatingValueRating: ${ratingResponse.value.rating}');
    } on DioException catch (e) {
      print('loadRating error : $e');
      return;
    }
  }

  // 레시피 평점 추가/수정
  Future<bool> updateRating({required Map additionalPropMap}) async { // 레시피 평점 추가
    try {
      print('print additionalPropList: $additionalPropMap');
      final dio = createDio();
      RecommendRepository recommendRepository = RecommendRepository(dio);
      
      RatingRequest ratingRequest = RatingRequest(
        new_user_ratings_dic: additionalPropMap,
        user_id: getUserId()
      );
      bool resp = await recommendRepository.postRecommendRating(ratingRequest);
      // resp == true: 업데이트 성공
      return resp;

    } on DioException catch (e) {
      print('updateRating error : $e');
      return false;
    }
  }

  // 레시피 평점 삭제
  Future<bool> deleteRating({required int recipeId}) async { // 레시피 평점 추가
    try {
      final dio = createDio();
      RecommendRepository recommendRepository = RecommendRepository(dio);
      bool resp = await recommendRepository.deleteRecommendRating(recipeId, getUserId());
      // resp == true: 업데이트 성공
      return resp;

    } on DioException catch (e) {
      print('deleteRating error : $e');
      return false;
    }
  }

  Future<void> updateBookmark(int userId, int recipeId) async {
    Get.put(BookmarkListController());
    Get.find<BookmarkListController>().postBookmark(userId, recipeId);
    // 추천 레시피 재로딩
    await Get.find<RecommendController>().getBookmarkList(1);
  }
}