import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:ottugi_curry/config/color_schemes.dart';
import 'package:ottugi_curry/utils/long_string_to_list_utils.dart';
import 'package:ottugi_curry/view/controller/bookmark/bookmark_controller.dart';
import 'package:ottugi_curry/view/page/recipe_list/categories_widget.dart';

class BookmrkListPage extends StatefulWidget {
  final String mode;
  const BookmrkListPage({super.key, this.mode = 'search'});

  @override
  BookmrkListPageState createState() => BookmrkListPageState();
}

//final bListController = Get.put(BookmarkListController());

class BookmrkListPageState extends State<BookmrkListPage> {
  final bListController = Get.put(BookmarkListController());
  final textController = TextEditingController();
  final NumberPaginatorController pageController = NumberPaginatorController();

  Future<void> _initMenuList() async {
    await Get.find<BookmarkListController>().fetchData(1, 1);
  }

  @override
  Widget build(BuildContext context) {
    print(bListController.response.value.empty);
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
                Column(
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.fromLTRB(16, 10, 16, 10),
                      child: TextField(
                        controller: textController,
                        onSubmitted: (String text) {
                          // 입력된 텍스트에 접근하여 원하는 작업 수행
                          print('입력된 텍스트: $text');
                          // bListController를 통해 데이터 업데이트 등의 작업 수행
                          bListController.searchData(1, text); //userId, text
                        },
                        decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.search),
                            hintText: '레시피 이름을 입력하고 Enter를 눌러주세요..',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: const BorderSide(
                                    color: Colors.black))), // InputDecoration
                      ), // TextField
                    ), // Container
                  ], // Widget
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // 카테고리 위젯
                    const CategoriesWidget(),
                    // 아이템 위젯
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Obx(() => itemList()),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }

  Widget itemList() {
    final menuList = bListController.response.value.content;
    if (menuList!.isNotEmpty) {
      return Column(
        children: [
          // 아이템 그리는 부분
          ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            physics: const NeverScrollableScrollPhysics(),
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
                    margin:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
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
                                      icon: Icon(menuItem.isBookmark!
                                          ? Icons.bookmark_rounded
                                          : Icons.bookmark_border_rounded),
                                      iconSize: 30,
                                      padding: EdgeInsets.zero,
                                      constraints: const BoxConstraints(),
                                      color: lightColorScheme.primary,
                                      onPressed: () {
                                        bListController.deleteBookmark(
                                            1, menuItem.recipeId);
                                      },
                                    ),
                                  ],
                                ),
                                // 두 번째 줄 (재료 목록)
                                Row(children: [
                                  Expanded(
                                      child: Text(
                                    '${extractOnlyContent(menuItem.ingredients ?? '')}',
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
          ),
          // 페이지네이션
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: NumberPaginator(
                numberPages: bListController.response.value.totalPages!,
                controller: pageController,
                onPageChange: (int index) {
                  bListController.fetchData(1, index + 1);
                },
                config: NumberPaginatorUIConfig(
                  buttonSelectedForegroundColor: Colors.black,
                  buttonUnselectedForegroundColor: Colors.grey,
                  buttonSelectedBackgroundColor: lightColorScheme.primary,
                ),
              )),
        ],
      );
    } else {
      return const Center(
        child: Text('추천 레시피를 찾지 못했습니다.'),
      );
    }
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
