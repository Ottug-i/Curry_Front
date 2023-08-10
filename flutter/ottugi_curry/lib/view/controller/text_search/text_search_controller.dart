import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:ottugi_curry/model/bookmark_update.dart';
import 'package:ottugi_curry/model/recipe_response.dart';
import 'package:ottugi_curry/model/rank_response.dart';
import 'package:ottugi_curry/model/recipe_list_page_response.dart';
import 'package:ottugi_curry/model/search_queries.dart';
import 'package:ottugi_curry/repository/bookmark_repository.dart';
import 'package:ottugi_curry/repository/rank_repository.dart';
import 'package:ottugi_curry/repository/recipe_repository.dart';

class TextSearchController {
  RxList<RankResponse> rankList = <RankResponse>[].obs;
  Rx<TextEditingController> textEditingController =
  TextEditingController(text: '').obs;
  Rx<NumberPaginatorController> pageController =
  NumberPaginatorController().obs;

  // pageable, sort 데이터 생략
  Rx<RecipeListPageResponse> recipeListPageResponse = RecipeListPageResponse(
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

  Rx<String> selectedCategory = ''.obs;
  Rx<String> selectedCategoryValue = ''.obs;

  RxString searchName = ''.obs;

  Rx<String> searchComposition = ''.obs;
  Rx<String> searchDifficulty = ''.obs;
  Rx<String> searchTime = ''.obs;


  Future<void> loadRankList() async {
    try {
      Dio dio = Dio();
      RankRepository rankRepository = RankRepository(dio);

      final resp = await rankRepository.getRankList();

      // 응답 값 변수에 저장
      rankList.value = resp;
      print('print rankListFirstName: ${rankList.first.name}');
    } on DioException catch (e) {
      print('loadRankList: $e');
      return;
    }
  }

  void updateSearchWord(String word) {
    // 검색어 저장
    searchName.value = word;
  }

  Future<void> handleTextSearch(
      {required String name,
      String? composition,
      String? difficulty,
      String? time,
      int? page}) async {

    // 검색어 및 옵션 변경시 - 페이징 인덱스 리셋
    if (searchName.value != name || searchComposition.value != composition || searchDifficulty.value != difficulty || searchTime.value != time) {
      pageController.value.currentPage = 0;
    }

    // 검색어 및 옵션 저장
    searchName.value = name;
    // 옵션 변경 시(null 외의 값 들어왔을 떄) 저장
    if (composition != null) {
      searchComposition.value = composition;
    }
    if (difficulty != null) {
      searchDifficulty.value = difficulty;
    }
    if (time != null) {
      searchTime.value = time;
    }

    print('print searchCompositionValue: ${searchComposition.value}');
    print('print searchDifficultyValue: ${searchDifficulty.value}');
    print('print searchTimeValue: ${searchTime.value}');

    try {
      Dio dio = Dio();
      RecipeRepository recipeRepository = RecipeRepository(dio);

      SearchQueries searchQueries = SearchQueries(
          userId: 1,
          name: name,
          composition: searchComposition.value,
          difficulty: searchDifficulty.value,
          time: searchTime.value,
          page: page ?? 1,
          size: 10);
      final resp = await recipeRepository.searchByBox(searchQueries);
      // 응답 값 변수에 저장
      recipeListPageResponse.value = resp;
      print('print respContentLength: ${resp.totalElements!}');

    } on DioException catch (e) {
      print('loadRankList: $e');
      return;
    }
  }

  void handlePaging(int pageIndex) {
    print('print TotalPages: ${recipeListPageResponse.value.totalPages}');
    print('print pageIndex: ${pageIndex}');

    handleTextSearch(
        name: searchName.value,
        composition: searchComposition.value,
        difficulty: searchDifficulty.value,
        time: searchTime.value,
        page: pageIndex);
  }

  void toggleValue(target, newValue) {
    if (target.value == newValue) {
      target.value = '';
    } else {
      target.value = newValue;
    }
  }

  void updateCategory(String value) {
    if (selectedCategory.value == value) {
      selectedCategory.value = '';
    } else {
      selectedCategory.value = value;
    }
    print('print SelectedCategoryValue: ${selectedCategory.value}');
  }

  void updateBookmark(int userId, int recipeId) async {
    try {
      final BookmarkRepository bookmrkRepository = BookmarkRepository(Dio());
      final bookmrkItem = Bookmark(userId: userId, recipeId: recipeId);
      await bookmrkRepository.updateBookmark(bookmrkItem);

      handleTextSearch(name: searchName.value);
      // await fetchData(userId, currentPage.value); // 재로딩
    } catch (error) {
      // 에러 처리
      print('Error updating bookmark: $error');
    }
  }
}
