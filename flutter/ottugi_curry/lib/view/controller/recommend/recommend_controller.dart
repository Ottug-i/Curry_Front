import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:ottugi_curry/model/bookmark_update.dart';
import 'package:ottugi_curry/model/rating_response.dart';
import 'package:ottugi_curry/model/recipe_response.dart';
import 'package:ottugi_curry/model/rating_request.dart';
import 'package:ottugi_curry/repository/bookmark_repository.dart';
import 'package:ottugi_curry/repository/recommend_repository.dart';

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
  RxDouble previousRating = 0.0.obs; // 평점 초기화를 위해 이전 평점 저장

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
      bookmarkIdSet.clear();
    }

    try {
      Dio dio = Dio();
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
    rating.value = 0.0; // 초기화

    try {
      Dio dio = Dio();
      RecommendRepository recommendRepository = RecommendRepository(dio);

      RatingResponse? resp= await recommendRepository.getUserRating(recipeId, 1);
      if (resp == null) { // 평점 매기지 않았으면 0.0으로 초기화
        ratingResponse.value = RatingResponse(rating: 0.0, recipeId: recipeId, userId: 1);
      } else {
        ratingResponse.value = resp; // 평점 매긴 경우
      }

      print('print userRatingValueRating: ${ratingResponse.value.rating}');
    } on DioException catch (e) {
      print('loadUserRating error : $e');
      return;
    }
  }

  Future<bool> updateUserRating({required Map additionalPropMap}) async { // 레시피 평점 추가
    try {
      print('print additionalPropList: ${additionalPropMap}');
      Dio dio = Dio();
      RecommendRepository recommendRepository = RecommendRepository(dio);
      
      RatingRequest ratingRequest = RatingRequest(
        new_user_ratings_dic: additionalPropMap,
        user_id: 1
      );
      bool resp = await recommendRepository.postUserRating(ratingRequest);
      // resp == true: 업데이트 성공
      return resp;

    } on DioException catch (e) {
      print('updateUserRating error : $e');
      return false;
    }
  }

  void updateBookmark(int userId, int recipeId) async {
    try {
      final BookmarkRepository bookmrkRepository = BookmarkRepository(Dio());
      final bookmrkItem = Bookmark(userId: userId, recipeId: recipeId);
      await bookmrkRepository.updateBookmark(bookmrkItem);

      await Get.find<RecommendController>().getBookmarkList(1);
    } catch (error) {
      // 에러 처리
      print('Error updating bookmark: $error');
    }
  }
}