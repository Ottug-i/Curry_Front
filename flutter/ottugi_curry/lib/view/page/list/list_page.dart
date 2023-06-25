import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ottugi_curry/config/color_schemes.dart';
import 'package:ottugi_curry/view/controller/list/recipe_list_controller.dart';
import 'package:ottugi_curry/view/page/list/list_item_widget.dart';

class ListPage extends StatefulWidget {
  //List<String> ingredientList;
  //ListPage(this.ingredientList, {super.key});
  const ListPage({super.key});

  @override
  ListPageState createState() => ListPageState();
}

//final rListController = Get.put(MenuListController());

class ListPageState extends State<ListPage> {
  //List<String> get ingredientList => widget.ingredientList;

  Future<void> _initMenuList() async {
    print('여기는 list_page.dart');
    // 갯수 확인을 위해 api 요청보냄 - 실질적으로 화면에 뿌려주는건 list_item_widget에서
    await Get.find<MenuListController>().fetchData(1, ["달걀", "베이컨"]);
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
                      "달걀, 베이컨",
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
                const SizedBox(
                  height: 20,
                ),
                // 아이템 위젯
                if (rListController.MenuModelList.isEmpty)
                  const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('검색 결과가 없습니다.'),
                    ],
                  )
                else
                  Obx(
                    () => ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: rListController.MenuModelList.length,
                        itemBuilder: (BuildContext context, int i) {
                          return ItemsWidget(rListController.MenuModelList[i],
                              const ["달걀", "베이컨"]);
                        }),
                  )
              ],
            ),
          );
        });
  }
}
