import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:ottugi_curry/utils/long_string_to_list_utils.dart';
import 'package:ottugi_curry/model/menu.dart';
import 'package:ottugi_curry/model/bookmark_update.dart';
import 'package:ottugi_curry/model/recipe_list_response.dart';
import 'package:ottugi_curry/repository/recipe_repository.dart';
import 'package:ottugi_curry/repository/bookmark_repository.dart';

class MenuListController extends GetxController {
  var response = RecipeListResponse().obs;
  var MenuModelList = <MenuModel>[].obs; // response.value.content 와 같은 셈

  var currentPage = 1.obs; // 북마크 업데이트 시 reload를 위해 필요함

  Future<void> fetchData(
      int userId, List<String> ingredientList, int page) async {
    print('fetchData 실행');

    currentPage.value = page;

    try {
      final RecipeRepository recipeRepository = RecipeRepository(Dio());

      Map<String, dynamic> request = {
        "userId": userId,
        "ingredients": ingredientList,
        "page": page,
        "size": 3
      };
      final menuData = await recipeRepository.getMenuList(request);
      MenuModelList.clear(); // 기존 데이터를 지우고 시작

      for (var menu in menuData.content!) {
        final ingredientsValue = extractOnlyContent(menu.ingredients!);

        // MenuModel의 나머지 속성들은 그대로 유지
        var updatedMenu = MenuModel(
          recipeId: menu.recipeId,
          name: menu.name,
          thumbnail: menu.thumbnail,
          time: menu.time,
          difficulty: menu.difficulty,
          composition: menu.composition,
          ingredients: ingredientsValue,
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

      update();
    } catch (error) {
      // 에러 처리
      print('Error fetching menu list: $error');
    }
  }

  void updateBookmark(int userId, int recipeId, List<String> recipeIds) async {
    print('Bookmrk의 updateData 실행');
    try {
      final BookmarkRepository bookmrkRepository = BookmarkRepository(Dio());
      final bookmrkItem = Bookmark(userId: userId, recipeId: recipeId);
      await bookmrkRepository.updateBookmark(bookmrkItem);
      await fetchData(userId, recipeIds, currentPage.value); // 재로딩
    } catch (error) {
      // 에러 처리
      print('Error updating bookmark: $error');
    }
  }

  void updatePage(int page) {
    currentPage.value = page;
    update();
  }
}
