import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:ottugi_curry/model/recipe_response.dart';
import 'package:ottugi_curry/model/bookmark_update.dart';
import 'package:ottugi_curry/model/recipe_list_page_response.dart';
import 'package:ottugi_curry/repository/bookmark_repository.dart';
import 'package:ottugi_curry/config/config.dart';
import 'package:ottugi_curry/view/controller/recommend/recommend_controller.dart';

class BookmarkListController extends GetxController {
  Rx<RecipeListPageResponse> response = RecipeListPageResponse().obs;
  RxList<RecipeResponse> BoomrkList = <RecipeResponse>[].obs;

  RxBool isBookmark = false.obs;

  Rx<String> selectedCategory = ''.obs;
  Rx<String> selectedCategoryValue = ''.obs;

  Rx<String> composition = ''.obs;
  Rx<String> difficulty = ''.obs;
  Rx<String> time = ''.obs;

  RxInt currentPage = 1.obs; // 북마크 업데이트 시 reload를 위해 필요함

  @override
  void onClose() {
    print('controller updated');
    super.onClose();
  }

  void saveResponse(menuData) {
    for (var menu in menuData.content!) {
      // ingredients 문자열 정리 -> It₩em Widget에서 바꾸기로 변경
      // final ingredientsValue = extractOnlyContent(menu.ingredients!);

      // MenuModel의 나머지 속성들은 그대로 유지
      var updatedMenu = RecipeResponse(
        recipeId: menu.recipeId,
        name: menu.name,
        thumbnail: menu.thumbnail,
        time: menu.time,
        difficulty: menu.difficulty,
        composition: menu.composition,
        ingredients: menu.ingredients,
        isBookmark: menu.isBookmark,
      );

      BoomrkList.add(updatedMenu);

      // 디버깅용 코드
      // var jsonString = updatedMenu.toJson().toString();
      // print(jsonString);
    }
    response.value.content = BoomrkList;
    response.value.totalPages = menuData.totalPages;
    response.value.totalElements = menuData.totalElements;
    response.value.size = menuData.size;
    response.value.number = menuData.number;
    response.value.last = menuData.last;
    response.value.first = menuData.first;
    response.value.empty = menuData.empty;
    response.value.numberOfElements = menuData.numberOfElements;
  }

  Future<void> fetchData(int userId, int page) async {
    // 클릭 시 마다 현재 위치를 저장해두어야 북마크 업데이트 시 페이지 안 변함
    currentPage.value = page;

    try {
      final BookmarkRepository bookmrkRepository = BookmarkRepository(Dio());
      final menuData =
          await bookmrkRepository.getBookmark(page, Config.elementNum, userId);
      BoomrkList.clear(); // 기존 데이터를 지우고 시작
      response.value = RecipeListPageResponse();

      saveResponse(menuData);


      // 북마크 추천 토글 상태를 저장하는 리스트 초기화
      Get.find<RecommendController>().toggleSelected.clear();
      response.value.content!.map((e) => Get.find<RecommendController>().toggleSelected.add(false)).toList();

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

  void updateCategoryValue(String newvalue) {
    selectedCategoryValue.value = newvalue;
    update();
  }

  void toggleValue(target, newvalue) {
    if (target.value == newvalue) {
      target.value = '';
    } else {
      target.value = newvalue;
    }
    update();
  }

  void deleteBookmark(int userId, int recipeId) async {
    try {
      final BookmarkRepository bookmrkRepository = BookmarkRepository(Dio());
      final bookmrkItem = Bookmark(userId: userId, recipeId: recipeId);
      await bookmrkRepository.updateBookmark(bookmrkItem);
      int page = currentPage.value;
      if (isPageChange()) {
        page -= 1;
      }
      await fetchData(userId, page); // 재로딩
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

  Future<void> searchData(int userId, String text) async {
    try {
      final BookmarkRepository bookmrkRepository = BookmarkRepository(Dio());
      final menuData = await bookmrkRepository.searchByName(
          1, Config.elementNum, userId, text);
      BoomrkList.clear(); // 기존 데이터를 지우고 시작
      response.value = RecipeListPageResponse();

      saveResponse(menuData);
      response.refresh();
      update();
    } catch (error) {
      // 에러 처리
      print('Error updating bookmark: $error');
    }
  }

  Future<void> searchByOption(int userId) async {
    print("serachByOption 실행 - $composition, $time, $difficulty");
    try {
      final BookmarkRepository bookmrkRepository = BookmarkRepository(Dio());

      final menuData = await bookmrkRepository.searchByOption(
          1,
          Config.elementNum,
          userId,
          composition.value,
          difficulty.value,
          time.value);
      // 요청 URL 출력
      //print('요청 URL: ${bookmrkRepository.options.path}');
      //print(menuData.empty);
      BoomrkList.clear(); // 기존 데이터를 지우고 시작

      saveResponse(menuData);
      response.refresh();
      update();
    } catch (error) {
      // 에러 처리
      print('Error updating bookmark: $error');
    }
  }
}
