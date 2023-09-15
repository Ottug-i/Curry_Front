import 'package:get/get.dart';
import 'package:ottugi_curry/config/config.dart';
import 'package:ottugi_curry/config/dio_config.dart';
import 'package:ottugi_curry/model/ingredient_request.dart';
import 'package:ottugi_curry/model/recipe_response.dart';
import 'package:ottugi_curry/model/recipe_list_page_response.dart';
import 'package:ottugi_curry/repository/recommend_repository.dart';
import 'package:ottugi_curry/view/controller/bookmark/bookmark_list_controller.dart';

class RecipeListController extends GetxController {
  // Rx<RecipeListPageResponse> response = RecipeListPageResponse().obs;
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
  //RxList<RecipeResponse> MenuModelList = <RecipeResponse>[].obs; // response.value.content 와 같은 셈

  RxList<dynamic> ingredientList = [].obs;
  RxList<dynamic> selectedList = [].obs;
  RxList<String> selectedIngredient = <String>[].obs;

  int maxSelected = 5;
  int currentSelected = 0;

  RxInt currentPage = 1.obs; // 북마크 업데이트 시 reload를 위해 필요함

  RxBool isLoading = true.obs;

  Rx<String> selectedCategory = ''.obs;
  Rx<String> selectedCategoryValue = ''.obs;

  Rx<String> searchComposition = ''.obs;
  Rx<String> searchDifficulty = ''.obs;
  Rx<String> searchTime = ''.obs;

  @override
  void dispose() {
    super.dispose();
    selectedCategory.value = '';
    selectedCategoryValue.value = '';

    searchComposition.value = '';
    searchDifficulty.value = '';
    searchTime.value = '';

    currentPage.value = 1;
  }

  void setIngredientList(List<String> input) {
    ingredientList.clear();
    if (input.isNotEmpty) {
      for (var item in input) {
        var data = {"name": item, "isChecked": true, "ableToDelete": false};
        currentSelected += 1;
        ingredientList.add(data);
      }
    }
    // 셋팅까지 하면 감지 완료
    isLoading.value = false;
  }

  void changeIngredients() {
    selectedIngredient.clear();
    selectedList.clear();
    // 재료 확인 페이지 & 모달창에서 사용
    for (var item in ingredientList) {
      if (item["isChecked"] == true) {
        selectedIngredient.add(item["name"]);
        selectedList
            .add({"name": item["name"], "isChecked": item["isChecked"]});
      }
    }
  }

  void addIngredient(String name) {
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

  bool isLastOne() {
    print("검사 시 selectedIngredient: $selectedIngredient");
    if (selectedIngredient.length == 1) {
      return true;
    } else {
      return false;
    }
  }

  void toggleItem(int index) {
    ingredientList[index]["isChecked"] = !ingredientList[index]["isChecked"];
    ingredientList.refresh();
  }

  void toggleSelectedList(int index) {
    if (selectedList[index]["isChecked"] == true) {
      selectedList[index]["isChecked"] = false;
      selectedIngredient.remove(selectedList[index]["name"]);
    } else {
      selectedList[index]["isChecked"] = true;
      selectedIngredient.add(selectedList[index]["name"]);
    }
    selectedList.refresh();
  }

  void toggleCategory(target, newvalue) {
    // target은 변수, newValue는 변수값인 셈.
    if (target.value == newvalue) {
      target.value = ''; // 해제
    } else {
      target.value = newvalue; // 새로운 값
    }
    currentPage.value = 1;
  }

  Future<void> fetchData({required int userId, required int page}) async {
    // 클릭 시 마다 현재 위치를 저장해두어야 북마크 업데이트 시 페이지 안 변함
    currentPage.value = page;

    try {
      final dio = createDio();
      final RecommendRepository recommendRepository = RecommendRepository(dio);

      IngredientRequest ingredientRequest = IngredientRequest(
        userId: userId,
        composition: searchComposition.value,
        difficulty: searchDifficulty.value,
        time: searchTime.value,
        ingredients: selectedIngredient,
        page: page,
        size: Config.elementNum,
      );
      final menuData = await recommendRepository
          .postRecommendIngredientsList(ingredientRequest);
      response.value = menuData;
      response.refresh();
    } catch (error) {
      // 에러 처리
      print('Error fetching menu list: $error');
    }
  }

  Future<void> updateBookmark(int userId, int recipeId) async {
    Get.put(BookmarkListController());
    await Get.find<BookmarkListController>().postBookmark(userId, recipeId);
    await fetchData(userId: userId, page: currentPage.value); // 재로딩
  }

  // 카테고리(옵션 검색) 관련 함수들
  void updateCategory(String category) {
    selectedCategory.value = category;
  }
}
