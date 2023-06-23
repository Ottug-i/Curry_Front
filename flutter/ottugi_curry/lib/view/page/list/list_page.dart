import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ottugi_curry/config/color_schemes.dart';
import 'package:ottugi_curry/view/page/list/list_item_widget.dart';
import 'package:ottugi_curry/view/controller/list/recipe_list_controller.dart';

class ListPage extends StatefulWidget {
  final String mode;
  const ListPage({super.key, this.mode = 'search'});

  @override
  ListPageState createState() => ListPageState();
}

//final rListController = Get.put(MenuListController());

class ListPageState extends State<ListPage> {
  Future<void> _initMenuList() async {
    print('여기는 list_page.dart');
    await Get.find<MenuListController>().fetchData(1, ["6855278", "6909678"]);
    //print(Get.find<MenuListController>().MenuModelList);
  }

  @override
  Widget build(BuildContext context) {
    Get.put(MenuListController());
    final rListController = Get.find<MenuListController>();

    return FutureBuilder(
        future: _initMenuList(),
        builder: (context, snap) {
          if (snap.connectionState != ConnectionState.done) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      "감자, 치즈, 계란",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        decoration: TextDecoration.underline,
                        decorationColor: lightColorScheme.primary,
                        decorationThickness: 4,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  const Icon(
                    Icons.edit_rounded,
                    size: 20,
                    color: Colors.black,
                  ),
                  const Spacer(),
                ]),
                // 아이템 위젯
                if (rListController.MenuModelList.isEmpty)
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Text('검색 결과가 없습니다.'),
                    ],
                  )
                else
                  Column(mainAxisSize: MainAxisSize.min, children: [
                    // 카테고리 위젯
                    // CategoriesWidget(),
                    SizedBox(
                      height: 10,
                    ),
                    Flexible(child: ItemsWidget()),
                  ])
              ],
            ),
          );
        });
  }
}

void searchRecipe(String query) {
  Get.put(MenuListController());
  final rListController = Get.find<MenuListController>();

  var MenuModelList = rListController.MenuModelList;
  // 검색어에 해당하는 새로운 레시피 정보들
  final suggestions = MenuModelList.where((recipe) {
    final recipeTitle = recipe.name!.toLowerCase();
    final input = query.toLowerCase(); // 검색창에 입력한 정보들
    return recipeTitle.contains(input);
  }).toList();

  for (var e in suggestions) {
    debugPrint(e.toString());
  }

  // 검색결과로 업데이트
  MenuModelList.assignAll(suggestions);
}
