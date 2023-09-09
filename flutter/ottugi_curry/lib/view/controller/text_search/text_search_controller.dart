import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:ottugi_curry/config/config.dart';
import 'package:ottugi_curry/config/dio_config.dart';
import 'package:ottugi_curry/model/recipe_response.dart';
import 'package:ottugi_curry/model/rank_response.dart';
import 'package:ottugi_curry/model/recipe_list_page_response.dart';
import 'package:ottugi_curry/model/search_queries.dart';
import 'package:ottugi_curry/repository/rank_repository.dart';
import 'package:ottugi_curry/repository/recipe_repository.dart';
import 'package:ottugi_curry/utils/user_profile_utils.dart';
import 'package:ottugi_curry/view/controller/bookmark/bookmark_list_controller.dart';

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

  RxString selectedCategory = ''.obs;
  RxString selectedCategoryValue = ''.obs;

  RxString searchName = ''.obs;

  RxString searchComposition = ''.obs;
  RxString searchDifficulty = ''.obs;
  RxString searchTime = ''.obs;

  RxInt pageIndex = 1.obs;

  // 인기 검색어 조회
  Future<void> loadRankList() async {
    try {
      final dio = createDio();
      RankRepository rankRepository = RankRepository(dio);

      final resp = await rankRepository.getRankList();

      // 응답 값 변수에 저장
      rankList.value = resp;
    } on DioException catch (e) {
      print('loadRankList: $e');
      return;
    }
  }

  Future<void> handleTextSearch(
      {required String name,
      // String? composition,
      // String? difficulty,
      // String? time,
        bool? changeOptions,
      int? page}) async {


    // 검색어 및 옵션 변경시 - 페이징 인덱스 리셋
    if (searchName.value != name) {
      page = 1;
      pageController.value.currentPage = 0;
    }
    if (changeOptions == true) {
      page = 1;
      pageController.value.currentPage = 0;
    }

    // 검색어, 페이지 인덱스 저장
    searchName.value = name;
    if (page != null) {
      pageIndex.value = page;
    }
    
    print('print searchTime: ${searchTime.value}');
    print('print searchDifficulty: ${searchDifficulty.value}');
    print('print searchComposition: ${searchComposition.value}');

    try {
      final dio = createDio();
      RecipeRepository recipeRepository = RecipeRepository(dio);

      SearchQueries searchQueries = SearchQueries(
          userId: getUserId(),
          name: name,
          composition: searchComposition.value,
          difficulty: searchDifficulty.value,
          time: searchTime.value,
          page: pageIndex.value,
          size: Config.elementNum);
      final resp = await recipeRepository.getSearch(searchQueries);
      // 응답 값 변수에 저장
      recipeListPageResponse.value = resp;

    } on DioException catch (e) {
      print('print handleTextSearch: $e');
      return;
    }
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
  }

  Future<void> updateBookmark(int userId, int recipeId) async {
    Get.put(BookmarkListController());
    await Get.find<BookmarkListController>().postBookmark(userId, recipeId);
    await handleTextSearch(name: searchName.value, page: pageIndex.value);
  }
}
