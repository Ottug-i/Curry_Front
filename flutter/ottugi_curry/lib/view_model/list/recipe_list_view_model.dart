import 'dart:developer';

import 'package:get/get.dart';
import 'package:dio/dio.dart';
//import 'package:ottugi_curry/model/MenuModel.dart';
import 'package:ottugi_curry/model/menu.dart';
import 'package:ottugi_curry/model/menu_list.dart';
import 'package:ottugi_curry/repository/menu_repository.dart';

class MenuListViewModel extends GetxController {
  var MenuModelList = <MenuModel>[].obs;

  Rx<String> selectedCategory = 'null'.obs;
  Rx<String> selectedCategoryValue = '0'.obs;

  /*@override // GetxController에서 복사해 온 메서드
  void onInit() {
    super.onInit();
    fetchData();
  }*/
/*
  final MenuRepository _menuRepository = MenuRepository(Dio());

  Future<List<MenuModel>> _fetchMenuList() async {
    final menuList = MenuList(userId: "1", recipeId: ["6855278", "6909678"]);
    final menuModels = await _menuRepository.getMenuList(menuList);
    return menuModels;
  }
*/
  Future<void> fetchData() async {
    try {
      final MenuRepository menuRepository = MenuRepository(Dio());

      final menuList = MenuList(userId: "1", recipeId: ["6855278", "6909678"]);
      final menuData = await menuRepository.getMenuList(menuList);
      MenuModelList.clear(); // 기존 데이터를 지우고 시작

      for (var menu in menuData) {
        MenuModelList.add(menu);
      }

      var print = MenuModelList.toJson();
      log('MenuModelList: $print');
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

  bool checkData(MenuModel e) {
    switch (selectedCategory.value) {
      case 'time':
        final datatime = int.tryParse(e.time ?? '0');
        final selctedValue = int.parse(selectedCategoryValue.value);
        if (selctedValue == 30) {
          if (datatime! >= 30) {
            return true;
          } else {
            return false;
          }
        } else if ((selctedValue - 10 < datatime!) &&
            (datatime < selctedValue + 10)) {
          return true;
        } else {
          return false;
        }
      case 'level':
        if (e.difficulty == selectedCategoryValue.value) {
          return true;
        } else {
          return false;
        }

      case 'composition':
        if (e.composition == selectedCategoryValue.value) {
          return true;
        } else {
          return false;
        }
      default:
        return true;
    }
  }

  void updateData() {
    print('updateData 실행');
    var filterData =
        MenuModelList.where((element) => checkData(element)).toList();
    print(filterData.length);
    MenuModelList.assignAll(filterData);
    //update();
  }
}
