import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:ottugi_curry/model/menu.dart';
import 'package:ottugi_curry/model/bookmark_update.dart';
import 'package:ottugi_curry/model/recipe_list_response.dart';
import 'package:ottugi_curry/repository/recipe_repository.dart';
import 'package:ottugi_curry/repository/bookmark_repository.dart';

class RecipeListController extends GetxController {
  Rx<RecipeListResponse> response = RecipeListResponse().obs;
  RxList<MenuModel> MenuModelList =
      <MenuModel>[].obs; // response.value.content 와 같은 셈

  RxList<dynamic> ingredientList = [].obs; // List<dynamic>
  RxList<String> selectedIngredient = <String>[].obs; // List<String>

  RxInt currentPage = 1.obs; // 북마크 업데이트 시 reload를 위해 필요함

  void setIngredientList(List<String> input) {
    ingredientList.clear();
    for (var item in input) {
      var data = {"name": item, "isChecked": true};
      ingredientList.add(data);
    }
  }

  void changeIngredients() {
    selectedIngredient.clear();
    // 재료 확인 페이지 & 모달창에서 사용
    for (var item in ingredientList.value) {
      if (item["isChecked"] == true) {
        selectedIngredient.add(item["name"]);
      }
    }
  }

  Future<void> fetchData(int userId, int page) async {
    // 클릭 시 마다 현재 위치를 저장해두어야 북마크 업데이트 시 페이지 안 변함
    currentPage.value = page;

    try {
      final RecipeRepository recipeRepository = RecipeRepository(Dio());

      Map<String, dynamic> request = {
        "userId": userId,
        "ingredients": selectedIngredient,
        "page": page,
        "size": 10
      };
      final menuData = await recipeRepository.getMenuList(request);
      MenuModelList.clear(); // 기존 데이터를 지우고 시작

      for (var menu in menuData.content!) {
        // item Widget에서 재료 문자열 정리하는 것으로 변경 -> 주석처리 함
        // final ingredientsValue = extractOnlyContent(menu.ingredients!);

        // MenuModel의 나머지 속성들은 그대로 유지
        var updatedMenu = MenuModel(
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

  void updateBookmark(int userId, int recipeId) async {
    try {
      final BookmarkRepository bookmrkRepository = BookmarkRepository(Dio());
      final bookmrkItem = Bookmark(userId: userId, recipeId: recipeId);
      await bookmrkRepository.updateBookmark(bookmrkItem);
      await fetchData(userId, currentPage.value); // 재로딩
    } catch (error) {
      // 에러 처리
      print('Error updating bookmark: $error');
    }
  }
}
