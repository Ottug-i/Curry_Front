import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:ottugi_curry/model/recipe_response.dart';
import 'package:ottugi_curry/model/bookmark_update.dart';
import 'package:ottugi_curry/model/recipe_list_page_response.dart';
import 'package:ottugi_curry/model/search_queries.dart';
import 'package:ottugi_curry/repository/bookmark_repository.dart';
import 'package:ottugi_curry/config/config.dart';
import 'package:ottugi_curry/view/controller/recommend/recommend_controller.dart';

class BookmarkListController extends GetxController {
//  Rx<RecipeListPageResponse> response = RecipeListPageResponse().obs;

  Rx<NumberPaginatorController> pageController =
      NumberPaginatorController().obs;

  Rx<RecipeListPageResponse> response = RecipeListPageResponse(
    content: <RecipeResponse>[],
    totalPages: 0,
    totalElements: 0,
    last: false,
    first: false,
    numberOfElements: 0,
    size: 0,
    number: 0,
    empty: false,
  ).obs;

  RxBool isBookmark = false.obs;

  Rx<String> selectedCategory = ''.obs;
  Rx<String> selectedCategoryValue = ''.obs;

  RxString searchText = ''.obs;

  Rx<String> searchComposition = ''.obs;
  Rx<String> searchDifficulty = ''.obs;
  Rx<String> searchTime = ''.obs;

  // RxInt currentPage = 1.obs; // 북마크 업데이트 시 reload를 위해 필요함

  @override
  void onClose() {
    print('controller updated');
    super.onClose();
  }

  Future<void> loadData({required int userId, required int page}) async {
    if (searchComposition.isNotEmpty ||
        searchDifficulty.isNotEmpty ||
        searchTime.isNotEmpty ||
        (searchText.value != '')) {
      // 검색 조건이 하나라도 있다면
      searchData(userId: userId, page: page);
    }

    // 클릭 시 마다 현재 위치를 저장해두어야
    // 북마크 업데이트 시 페이지 안 변함
    //currentPage.value = page;
    pageController.value.currentPage = page;
    pageController.refresh();

    try {
      final BookmarkRepository bookmrkRepository = BookmarkRepository(Dio());
      final menuData =
          await bookmrkRepository.getBookmark(page, Config.elementNum, userId);
      response.value = menuData;

      // 북마크 추천 토글 상태를 저장하는 리스트 초기화
      Get.find<RecommendController>().isSelected.clear();
      for (int i = 0; i < response.value.content!.length; i++) {
        Get.find<RecommendController>().isSelected.add(false);
      }

      response.refresh();
      update();
    } catch (error) {
      // 에러 처리
      print('Error fetching menu list: $error');
    }
  }

  void updateCategory(String category) {
    selectedCategory.value = category;
    update(); // rebuild 하게 함
  }

  void toggleValue(target, newvalue) {
    print("toggle");
    // target은 변수, newValue는 변수값인 셈.
    if (target.value == newvalue) {
      target.value = ''; // 해제
    } else {
      target.value = newvalue; // 새로운 값
    }
    update(); // 변수 값이 바뀔 때마다 화면 UI도 업데이트
  }

  // 북마크 추가/삭제 -> 다른 페이지에서도 사용하는 api 관련 공용 함수
  Future<void> updateBookmark(int userId, int recipeId) async {
    postBookmark(userId, recipeId);
    await loadData(
        userId: userId, page: pageController.value.currentPage); // 재로딩
  }

  Future<void> postBookmark(int userId, int recipeId) async {
    try {
      final BookmarkRepository bookmrkRepository = BookmarkRepository(Dio());
      final bookmrkItem = Bookmark(userId: userId, recipeId: recipeId);
      final resp = await bookmrkRepository.postBookmark(bookmrkItem);
      if (resp == true || resp == false) { // 정상 처리 확인
        print('updating Bookmark Successes');
      }
    } catch (error) {
      // 에러 처리
      print('Error updating bookmark: $error');
    }
  }

  void deleteBookmark(int userId, int recipeId) async {
    try {
      final BookmarkRepository bookmrkRepository = BookmarkRepository(Dio());
      final bookmrkItem = Bookmark(userId: userId, recipeId: recipeId);
      await bookmrkRepository.postBookmark(bookmrkItem);
      // 북마크 페이지에서 바꿀 때는 요소 갯수가 달라져 페이지에 영향이 있을 수 있음
      int newpage = pageController.value.currentPage;
      if (isPageChange()) {
        newpage -= 1;
      }
      await loadData(userId: userId, page: newpage); // 재로딩
    } catch (error) {
      // 에러 처리
      print('Error updating bookmark: $error');
    }
  }

  bool isPageChange() {
    // 현재 페이지의 마지막 북마크 삭제 시, 페이지 전환이 필요한 경우가 있다.
    if (response.value.numberOfElements == 1) {
      // 업데이트 되기 전 정보
      return true;
    } else {
      return false;
    }
  }

  Future<void> searchData({required int userId, required int page}) async {
    pageController.value.currentPage = page;

    print(
        'comp: ${searchComposition.value}, diff: ${searchDifficulty.value}, time: ${searchTime.value}, text: ${searchText.value}');

    try {
      Dio dio = Dio();
      BookmarkRepository bookmrkRepository = BookmarkRepository(dio);

      SearchQueries searchQueries = SearchQueries(
          userId: userId,
          name: searchText.value,
          composition: searchComposition.value,
          difficulty: searchDifficulty.value,
          time: searchTime.value,
          page: page,
          size: Config.elementNum);
      final menuData = await bookmrkRepository.getSearch(searchQueries);
      print(menuData.content);
      response.value = menuData;
      response.refresh();
      update();
    } on DioException catch (e) {
      print('Error updating bookmark: $e');
      return;
    }
  }
}
