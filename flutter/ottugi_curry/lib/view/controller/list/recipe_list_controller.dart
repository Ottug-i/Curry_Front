import 'package:get/get.dart';
import 'package:ottugi_curry/config/dio_config.dart';
import 'package:ottugi_curry/model/ingredient_request.dart';
import 'package:ottugi_curry/model/recipe_response.dart';
import 'package:ottugi_curry/model/recipe_list_page_response.dart';
import 'package:ottugi_curry/repository/recommend_repository.dart';
import 'package:ottugi_curry/view/controller/bookmark/bookmark_list_controller.dart';

class RecipeListController extends GetxController {
  Rx<RecipeListPageResponse> response = RecipeListPageResponse().obs;
  RxList<RecipeResponse> MenuModelList =
      <RecipeResponse>[].obs; // response.value.content 와 같은 셈

  RxList<dynamic> ingredientList = [].obs; // List<dynamic>
  RxList<String> selectedIngredient = <String>[].obs; // List<String>
  int maxSelected = 5;
  int currentSelected = 0;

  RxInt currentPage = 1.obs; // 북마크 업데이트 시 reload를 위해 필요함

  RxBool isLoading = true.obs;

  void setIngredientList(List<String> input) {
    print("setIngredientList - 받은 input: $input");
    ingredientList.clear();
    for (var item in input) {
      var data = {"name": item, "isChecked": true, "ableToDelete": false};
      currentSelected += 1;
      ingredientList.add(data);
    }
    // 셋팅까지 하면 감지 완료
    isLoading.value = false;
  }

  void changeIngredients() {
    selectedIngredient.clear();
    // 재료 확인 페이지 & 모달창에서 사용
    for (var item in ingredientList) {
      if (item["isChecked"] == true) {
        selectedIngredient.add(item["name"]);
      }
    }
  }

  void setIngredient(String name) {
    // 식재료 직접 추가
    Map<String, Object> data;
    if (currentSelected < maxSelected) {
      data = {"name": name, "isChecked": true, "ableToDelete": true};
      currentSelected += 1;
    } else {
      data = {"name": name, "isChecked": false, "ableToDelete": true};
    }
    ingredientList.add(data);
  }

  void deleteIngredient(String name) {
    // 직접 추가한 식재료 삭제
    ingredientList.removeWhere((ingredient) => ingredient["name"] == name);
    print("ingredientList: $ingredientList");
  }

  bool canAddIngredient(String name) {
    // 중복 검사
    if (ingredientList.any((element) => element["name"] == name)) {
      return true;
    } else {
      return false;
    }
  }

  bool isFull() {
    // 가능한 식재료 갯수 총 10개
    if (ingredientList.length < 10) {
      return false;
    } else {
      return true;
    }
  }

  Future<void> fetchData(int userId, int page) async {
    // 클릭 시 마다 현재 위치를 저장해두어야 북마크 업데이트 시 페이지 안 변함
    currentPage.value = page;

    try {
      final dio = createDio();
      final RecommendRepository recommendRepository = RecommendRepository(dio);

      IngredientRequest ingredientRequest = IngredientRequest(
        ingredients: selectedIngredient,
        page: page,
        size: 10,
        userId: userId,
      );
      final menuData = await recommendRepository
          .postRecommendIngredientsList(ingredientRequest);
      MenuModelList.clear(); // 기존 데이터를 지우고 시작

      for (var menu in menuData.content!) {
        // item Widget에서 재료 문자열 정리하는 것으로 변경 -> 주석처리 함
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

        MenuModelList.add(updatedMenu);
        // 디버깅용 코드
        //var jsonString = updatedMenu.toJson().toString();
        //print(jsonString);
      }

      response.value.content = MenuModelList;
      response.value.totalPages = menuData.totalPages;
      response.value.totalElements = menuData.totalElements;
      response.value.size = menuData.size;
      response.value.number = menuData.number;
      response.value.last = menuData.last;
      response.value.first = menuData.first;
      response.value.empty = menuData.empty;
      response.value.numberOfElements = menuData.numberOfElements;

      response.refresh();

      update();
    } catch (error) {
      // 에러 처리
      print('Error fetching menu list: $error');
    }
  }

  Future<void> updateBookmark(int userId, int recipeId) async {
    Get.put(BookmarkListController());
    Get.find<BookmarkListController>().postBookmark(userId, recipeId);
    await fetchData(userId, currentPage.value); // 재로딩
  }
}
