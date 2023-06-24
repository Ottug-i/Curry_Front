import 'package:get/get.dart';
import 'package:dio/dio.dart';
//import 'package:ottugi_curry/model/MenuModel.dart';
import 'package:ottugi_curry/model/menu.dart';
import 'package:ottugi_curry/model/bookmark_update.dart';
import 'package:ottugi_curry/repository/bookmark_repository.dart';
import 'package:ottugi_curry/utils/long_string_to_list_utils.dart';

class BookmarkListController extends GetxController {
  var BoomrkList = <MenuModel>[].obs;

  RxBool isBookmark = false.obs;

  Rx<String> selectedCategory = ''.obs;
  Rx<String> selectedCategoryValue = ''.obs;

  Rx<String> composition = ''.obs;
  Rx<String> difficulty = ''.obs;
  Rx<String> time = ''.obs;

  @override
  void onClose() {
    print('controller updated');
    super.onClose();
  }

  Future<void> fetchData(int userId) async {
    print('Bookmrk의 fetchData 실행');
    try {
      final BookmarkRepository bookmrkRepository = BookmarkRepository(Dio());
      final menuData = await bookmrkRepository.getBookmark(userId);
      BoomrkList.clear(); // 기존 데이터를 지우고 시작

      for (var menu in menuData) {
        // ingredients 문자열 정리
        final ingredientsValue = extractOnlyContent(menu.ingredients!);

        // MenuModel의 나머지 속성들은 그대로 유지
        var updatedMenu = MenuModel(
          id: menu.id,
          name: menu.name,
          thumbnail: menu.thumbnail,
          time: menu.time,
          difficulty: menu.difficulty,
          composition: menu.composition,
          ingredients: ingredientsValue,
          isBookmark: menu.isBookmark,
        );

        BoomrkList.add(updatedMenu);

        // 디버깅용 코드
        var jsonString = updatedMenu.toJson().toString();
        print(jsonString);
      }
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
    print('toggle');
    if (target.value == newvalue) {
      target.value = '';
    } else {
      target.value = newvalue;
    }
    update();
  }

  void updateBookmark(int userId, int recipeId) async {
    print('Bookmrk의 updateData 실행');
    try {
      final BookmarkRepository bookmrkRepository = BookmarkRepository(Dio());
      final bookmrkItem = Bookmark(userId: userId, recipeId: recipeId);
      await bookmrkRepository.updateBookmark(bookmrkItem);
      await fetchData(userId); // 재로딩
    } catch (error) {
      // 에러 처리
      print('Error updating bookmark: $error');
    }
  }

  Future<void> searchData(int userId, String text) async {
    try {
      final BookmarkRepository bookmrkRepository = BookmarkRepository(Dio());
      final menuData = await bookmrkRepository.searchByName(userId, text);
      BoomrkList.clear(); // 기존 데이터를 지우고 시작

      for (var menu in menuData) {
        //var ingredientsValue = menu.ingredients;
        var ingredientsValue = menu.ingredients!
            .split("#")
            .where((element) => element.isNotEmpty)
            .join(", ");

        // MenuModel의 나머지 속성들은 그대로 유지
        var updatedMenu = MenuModel(
          id: menu.id,
          name: menu.name,
          thumbnail: menu.thumbnail,
          time: menu.time,
          difficulty: menu.difficulty,
          composition: menu.composition,
          ingredients: ingredientsValue,
          isBookmark: menu.isBookmark,
        );

        BoomrkList.add(updatedMenu);
        update();
        // 디버깅용 코드
        var jsonString = updatedMenu.toJson().toString();
        print('검색 결과: $jsonString');
      }
    } catch (error) {
      // 에러 처리
      print('Error updating bookmark: $error');
    }
  }

  Future<void> serachByOption(int userId) async {
    print("serachByOption 실행 - $composition, $time, $difficulty");
    try {
      final BookmarkRepository bookmrkRepository = BookmarkRepository(Dio());

      final menuData = await bookmrkRepository.searchByOption(
          userId, composition.value, difficulty.value, time.value);
      // 요청 URL 출력
      //print('요청 URL: ${bookmrkRepository.options.path}');
      print(menuData);
      BoomrkList.clear(); // 기존 데이터를 지우고 시작

      for (var menu in menuData) {
        //var ingredientsValue = menu.ingredients;
        var ingredientsValue = menu.ingredients!
            .split("#")
            .where((element) => element.isNotEmpty)
            .join(", ");

        // MenuModel의 나머지 속성들은 그대로 유지
        var updatedMenu = MenuModel(
          id: menu.id,
          name: menu.name,
          thumbnail: menu.thumbnail,
          time: menu.time,
          difficulty: menu.difficulty,
          composition: menu.composition,
          ingredients: ingredientsValue,
          isBookmark: menu.isBookmark,
        );

        BoomrkList.add(updatedMenu);
        update();
        // 디버깅용 코드
        var jsonString = updatedMenu.toJson().toString();
        print('검색 결과: $jsonString');
      }
    } catch (error) {
      // 에러 처리
      print('Error updating bookmark: $error');
    }
  }

  /*void changeBookmark() {
    print('changeBookmark 실행');
    var filterData = BoomrkList.where((element) => checkData(element)).toList();
    print(filterData.length);
    BoomrkList.assignAll(filterData);
    //update();
  }

  void updateBookmark(bool newvalue) {
    isBookmark.value = newvalue;
    update();
  }*/
}
