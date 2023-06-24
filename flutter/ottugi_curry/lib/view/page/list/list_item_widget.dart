import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ottugi_curry/config/color_schemes.dart';
import 'package:ottugi_curry/view/controller/list/recipe_list_controller.dart';

class ItemsWidget extends StatefulWidget {
  const ItemsWidget({Key? key}) : super(key: key);

  @override
  _ItemsWidgetState createState() => _ItemsWidgetState();
}

class _ItemsWidgetState extends State<ItemsWidget> {
  Future<void> _initMenuList() async {
    print('여기는 item_widget.dart');
    //print('print Get.arguments: ${Get.arguments}');
    await Get.find<MenuListController>().fetchData(1, ["달걀", "베이컨"]);
  }

  @override
  void initState() {
    super.initState();
    _initMenuList();
  }

  @override
  Widget build(BuildContext context) {
    Get.put(MenuListController());
    final rListController = Get.find<MenuListController>();

    return FutureBuilder(
        future: _initMenuList(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final menuList = rListController.MenuModelList;
          if (menuList.isNotEmpty) {
            return ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: menuList.length,
              itemBuilder: (BuildContext context, int i) {
                final menuItem = menuList[i];
                // 북마크 아이콘을 변경해서 전체 리스트를 reload하려면
                //  다시 추천시스템을 거쳐야해서(23.06.04 기준)
                // 북마크 update는 정상 작동하지만 그 결과를 받아와서 UI를 재구성하지는 않도록 함
                bool? initBookmark = menuItem.isBookmark;
                return GestureDetector(
                  onTap: () {
                    Get.toNamed('/recipe_detail',
                        arguments: menuItem.recipeId); //6909678: 레시피 아이디 예시
                  },
                  child: Container(
                      padding: const EdgeInsets.all(20),
                      margin: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 10),
                      // card
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 3,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(24.0),
                              child: Image.network(
                                '${menuItem.thumbnail}' ?? '',
                                fit: BoxFit.fill,
                                height: 100,
                                width: 150,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 7,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Column(
                                children: [
                                  // 첫 번째 줄 (메뉴 이름, 북마크 아이콘)
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      // 음식 이름
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${menuItem.name}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                        ],
                                      ),
                                      // 북마크 아이콘
                                      IconButton(
                                        icon: Icon(initBookmark!
                                            ? Icons.bookmark_rounded
                                            : Icons.bookmark_border_rounded),
                                        iconSize: 30,
                                        padding: EdgeInsets.zero,
                                        constraints: const BoxConstraints(),
                                        color: lightColorScheme.primary,
                                        onPressed: () {
                                          rListController.updateBookmark(
                                              1,
                                              menuItem.recipeId,
                                              ["6855278", "6909678"]);
                                        },
                                      )
                                    ],
                                  ),
                                  // 두 번째 줄 (재료 목록)
                                  Row(children: [
                                    Expanded(
                                        child: Text(
                                      '${menuItem.ingredients}',
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                      overflow: TextOverflow.ellipsis,
                                    )),
                                  ]),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  // 세 번째 줄 (아이콘 - 시간, 난이도, 구성)
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      iconWithText(context, Icons.timer,
                                          '${menuItem.time}'),
                                      iconWithText(
                                          context,
                                          Icons.handshake_outlined,
                                          '${menuItem.difficulty}'),
                                      iconWithText(
                                          context,
                                          Icons.food_bank_rounded,
                                          '${menuItem.composition}'),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      )),
                );
              },
            );
          } else {
            return const Center(
              child: Text('추천 레시피를 찾지 못했습니다.'),
            );
          }
        });
  }
}

Column iconWithText(BuildContext context, IconData icon, String text) {
  return Column(
    children: [
      Icon(icon, size: 30),
      Text(
        text,
        style: Theme.of(context).textTheme.bodySmall,
        overflow: TextOverflow.ellipsis,
      )
    ],
  );
}
