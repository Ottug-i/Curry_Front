import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ottugi_curry/view_model/list/recipe_list_view_model.dart';

class ItemsWidget extends StatefulWidget {
  const ItemsWidget({Key? key}) : super(key: key);

  @override
  _ItemsWidgetState createState() => _ItemsWidgetState();
}

class _ItemsWidgetState extends State<ItemsWidget> {
  Future<void> _initMenuList() async {
    print('여기는 item_widget.dart');
    //print('print Get.arguments: ${Get.arguments}');
    await Get.find<MenuListViewModel>().fetchData(1, ["6855278", "6909678"]);
  }

  @override
  void initState() {
    super.initState();
    _initMenuList();
  }

  @override
  Widget build(BuildContext context) {
    Get.put(MenuListViewModel());
    final rListController = Get.find<MenuListViewModel>();
    //final menuList = Get.find<MenuListViewModel>().MenuModelList;

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
              itemCount: menuList.length,
              itemBuilder: (BuildContext context, int i) {
                final menuItem = menuList[i];
                return GestureDetector(
                  onTap: () {
                    Get.toNamed('/recipe_detail',
                        arguments: 6909678); //6909678: 레시피 아이디 예시
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
                                fit: BoxFit.cover,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                            height: 12,
                                          ),
                                        ],
                                      ),
                                      // 북마크 아이콘
                                      Container(
                                        margin: const EdgeInsets.only(
                                            left: 8, right: 8),
                                        alignment: Alignment.topLeft,
                                        //crossAxisAlignment: CrossAxisAlignment.start,
                                        child: Icon(
                                          menuItem.isBookmark!
                                              ? Icons.bookmark_rounded
                                              : Icons.bookmark_border_rounded,
                                          size: 30,
                                          color: const Color(0xffFFD717),
                                        ), /*Obx(
                                          () => GestureDetector(
                                            onTap: () {
                                              bool value;
                                              if (menuItem.isBookmark == true) {
                                                value = false;
                                              } else {
                                                value = true;
                                              }
                                              rListController
                                                  .updateBookmark(value);
                                            },
                                            child: Icon(
                                              menuItem.isBookmark!
                                                  ? Icons.bookmark_rounded
                                                  : Icons
                                                      .bookmark_border_rounded,
                                              size: 30,
                                              color: const Color(0xffFFD717),
                                            ),
                                          ),
                                        ),*/
                                      ),
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
                                    height: 12,
                                  ),
                                  // 세 번째 줄 (아이콘 - 시간, 난이도, 구성)
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      iconWithText(context, Icons.timer,
                                          '${menuItem.time}분'),
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
