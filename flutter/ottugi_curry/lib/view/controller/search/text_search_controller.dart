import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ottugi_curry/model/menu.dart';
import 'package:ottugi_curry/model/rank_response.dart';
import 'package:ottugi_curry/model/recipe_list_response.dart';
import 'package:ottugi_curry/model/search_queries.dart';
import 'package:ottugi_curry/repository/rank_repository.dart';
import 'package:ottugi_curry/repository/recipe_repository.dart';

class TextSearchController {
  RxList<RankResponse> rankList = <RankResponse>[].obs;
  Rx<TextEditingController> textEditingController =
  TextEditingController(text: '').obs;

  // pageable, sort 데이터 생략
  Rx<RecipeListResponse> recipeListResponse = RecipeListResponse(
    content: <MenuModel>[],
    totalPages: 0,
    totalElements: 0,
    last: false,
    first: false,
    numberOfElements: 0,
    size: 0,
    number: 0,
    empty: false,
  ).obs;

  RxString searchName = ''.obs;
  RxString searchComposition = ''.obs;
  RxString searchDifficulty = ''.obs;
  RxString searchTime = ''.obs;
  RxInt currentPages = 0.obs;

  Future<void> loadRankList() async {
    try {
      Dio dio = Dio();
      RankRepository rankRepository = RankRepository(dio);

      final resp = await rankRepository.getRankList();

      // 응답 값 변수에 저장
      rankList.value = resp;
      print('print rankListFirstName: ${rankList.first.name}');
    } on DioError catch (e) {
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
    // 검색어 및 옵션 저장
    searchName.value = name;
    searchComposition.value = composition ?? '';
    searchDifficulty.value = difficulty ?? '';
    searchTime.value = time ?? '';

    print('print composition: ${composition}');
    print('print difficulty: ${difficulty}');
    print('print time: ${time}');

    try {
      Dio dio = Dio();
      RecipeRepository recipeRepository = RecipeRepository(dio);

      SearchQueries searchQueries = SearchQueries(
          userId: 1,
          name: name,
          composition: composition ?? '',
          difficulty: difficulty ?? '',
          time: time ?? '',
          page: page ?? 1,
          size: 10);
      final resp = await recipeRepository.searchByBox(searchQueries);
      print('print respContentLength: ${resp.content}');
      print('print respTotalPages: ${resp.totalPages}');
      // 응답 값 변수에 저장
      recipeListResponse.value = resp;
      print(
          'print recipeListResponse.value.content?.first.name: ${recipeListResponse.value.content?.first.name}');
      print('print recipeListResponseValueSize: ${recipeListResponse.value.size}');
      print('print searchControllerRecipeListResponseValueTotalPages: ${recipeListResponse.value.totalPages}');

      // 응답 값 변수에 저장
    } on DioError catch (e) {
      print('loadRankList: $e');
      return;
    }
  }

  void handlePaging(int pageIndex) {
    print('print searchControllerRecipeListResponseValueTotalPages: ${recipeListResponse.value.totalPages}');
    print('print pageIndex: ${pageIndex}');

    handleTextSearch(
        name: searchName.value,
        composition: searchComposition.value,
        difficulty: searchDifficulty.value,
        time: searchTime.value,
        page: pageIndex);
  }
}
