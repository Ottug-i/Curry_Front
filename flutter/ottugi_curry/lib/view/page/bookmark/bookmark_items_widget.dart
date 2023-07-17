import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ottugi_curry/config/color_schemes.dart';
import 'package:ottugi_curry/view/controller/bookmark/bookmark_controller.dart';

class ItemsWidget extends StatefulWidget {
  //final BookmarkListController controller;
  final String controllerTag;

  const ItemsWidget({Key? key, required this.controllerTag}) : super(key: key);

  @override
  _ItemsWidgetState createState() => _ItemsWidgetState();
}

class _ItemsWidgetState extends State<ItemsWidget> {
  late BookmarkListController controller;

  @override
  void initState() {
    super.initState();
    //controller = Get.find<BookmarkListController>(tag: widget.controllerTag);
    controller = Get.put(BookmarkListController(), tag: widget.controllerTag);

    @override
    void dependencies() {
      // TODO: implement dependencies
      Get.lazyPut(
        () => BookmarkListController(),
        tag: widget.controllerTag, //tag 옵션과 함께 dependency 주입!
      );
    }

    _initMenuList();
  }

  Future<void> _initMenuList() async {
    print('여기는 bookmrk_item_widget.dart');
    //print('print Get.arguments: ${Get.arguments}');
    await controller.fetchData(1, 1);
  }

  @override
  Widget build(BuildContext context) {
    //Get.put(BookmarkListController());
    //final controller = Get.find<BookmarkListController>();
    //final menuList = Get.find<BookmarkListController>().BoomrkList;

    return FutureBuilder(
        future: _initMenuList(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final menuList = controller.BoomrkList;
          if (menuList.isNotEmpty) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: menuList.length,
              itemBuilder: (BuildContext context, int i) {
                final menuItem = menuList[i];
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
                                        child: IconButton(
                                          icon: Icon(menuItem.isBookmark!
                                              ? Icons.bookmark_rounded
                                              : Icons.bookmark_border_rounded),
                                          iconSize: 30,
                                          color: lightColorScheme.primary,
                                          onPressed: () {
                                            controller.deleteBookmark(
                                                1, menuItem.recipeId);
                                          },
                                        ),
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
