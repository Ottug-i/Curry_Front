import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:ottugi_curry/config/color_schemes.dart';
import 'package:ottugi_curry/model/recipe_response.dart';
import 'package:ottugi_curry/utils/long_string_to_list_utils.dart';
import 'package:ottugi_curry/utils/user_profile_utils.dart';
import 'package:ottugi_curry/view/controller/bookmark/bookmark_list_controller.dart';
import 'package:ottugi_curry/view/controller/recommend/recommend_controller.dart';
import 'package:ottugi_curry/view/page/bookmark/bookmark_categories.dart';

import '../recipe_list/list_item_widget.dart';

class BookmrkListPage extends StatefulWidget {
  final String mode;

  const BookmrkListPage({super.key, this.mode = 'search'});

  @override
  BookmrkListPageState createState() => BookmrkListPageState();
}

class BookmrkListPageState extends State<BookmrkListPage> {
  final bListController = Get.put(BookmarkListController());
  final textController = TextEditingController();
  final NumberPaginatorController pageController = NumberPaginatorController();

  Future<void> _initMenuList() async {
    await Get.find<BookmarkListController>().loadData(userId: getUserId(), page: 1);
  }

  @override
  Widget build(BuildContext context) {
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
                          bListController.searchText.value = text; // 텍스트 검색
                          bListController.searchData(
                              userId: getUserId(),
                              page: bListController
                                  .pageController.value.currentPage); // 옵션 검색
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
                    const BookmarkCategories(),
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
    Get.put(RecommendController());
    final recommendController = Get.find<RecommendController>();

    // menuList null 여부 If문 변경 - 기존처럼 하면 Null 일 경우 에러 화면이 나타남
    return menuList!.isNotEmpty
        ? Column(
            children: [
              // 아이템 그리는 부분
              ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: menuList.length,
                itemBuilder: (BuildContext context, int i) {
                  final menuItem = menuList[i];
                  return Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.toNamed('/recipe_detail',
                              arguments: menuItem.recipeId);
                        },
                        child: Container(
                            padding: const EdgeInsets.only(top: 20, bottom: 5),
                            margin: const EdgeInsets.only(
                                left: 20, right: 20, top: 8),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(24),
                                topLeft: Radius.circular(24),
                              ),
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20, bottom: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        flex: 3,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(24.0),
                                          child: Image.network(
                                            '${menuItem.thumbnail}',
                                            fit: BoxFit.fill,
                                            height: 100,
                                            width: 150,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 7,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 20),
                                          child: Column(
                                            children: [
                                              // 첫 번째 줄 (메뉴 이름, 북마크 아이콘)
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  // 음식 이름
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        '${menuItem.name}',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .titleMedium,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                    ],
                                                  ),
                                                  // 북마크 아이콘
                                                  IconButton(
                                                    icon: Icon(menuItem
                                                            .isBookmark!
                                                        ? Icons.bookmark_rounded
                                                        : Icons
                                                            .bookmark_border_rounded),
                                                    iconSize: 30,
                                                    padding: EdgeInsets.zero,
                                                    constraints:
                                                        const BoxConstraints(),
                                                    color: lightColorScheme
                                                        .primary,
                                                    onPressed: () {
                                                      bListController
                                                          .deleteBookmark(
                                                              getUserId(),
                                                              menuItem
                                                                  .recipeId);
                                                    },
                                                  ),
                                                ],
                                              ),
                                              // 두 번째 줄 (재료 목록)
                                              Row(children: [
                                                Expanded(
                                                    child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 8.0),
                                                  child: Text(
                                                    extractOnlyContent(
                                                        menuItem.ingredients ??
                                                            ''),
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodySmall,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                )),
                                              ]),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              // 세 번째 줄 (아이콘 - 시간, 난이도, 구성)
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  iconWithText(
                                                      context, 'time', 30, '${menuItem.time}'),
                                                  iconWithText(context, 'chef2', 30,
                                                      '${menuItem.difficulty}'),
                                                  iconWithText(context, 'meal', 33,
                                                      '${menuItem.composition}'),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )),
                      ),

                      // 북마크 추천 토글 위젯
                      InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () {
                          recommendController.isSelected[i] =
                              !recommendController.isSelected[i];
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          margin: const EdgeInsets.only(
                              left: 20, right: 20, bottom: 8),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: const BorderRadius.only(
                              bottomRight: Radius.circular(24),
                              bottomLeft: Radius.circular(24),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.7),
                                spreadRadius: 0,
                                blurRadius: 7.0,
                                offset: const Offset(0, 5), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              const Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    '비슷한 레시피 추천 받기',
                                    style: TextStyle(fontSize: 13),
                                  ),
                                  Padding(padding: EdgeInsets.only(right: 5)),
                                  Icon(
                                    Icons.expand_more_rounded,
                                  ),
                                  Padding(padding: EdgeInsets.only(left: 5)),
                                ],
                              ),
                              Obx(
                                () => recommendController.isSelected[i] == true
                                    ? FutureBuilder(
                                        future:
                                            _initBookmarkRec(menuItem.recipeId),
                                        builder: (context, snap) {
                                          if (snap.connectionState !=
                                              ConnectionState.done) {
                                            return const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            );
                                          }

                                          return SizedBox(
                                              height: 160,
                                              child: ListView.builder(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 15, bottom: 10),
                                                  shrinkWrap: true,
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  itemCount: recommendController
                                                      .bookmarkRecList.length,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int idx) {
                                                    return bookmarkRecCardWidget(
                                                        recommendController
                                                                .bookmarkRecList[
                                                            idx]);
                                                  }));
                                        })
                                    : const SizedBox(),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
              // 페이지네이션
              Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 5, bottom: 10),
                  child: NumberPaginator(
                    numberPages: bListController.response.value.totalPages ?? 0,
                    controller: pageController,
                    onPageChange: (int index) {
                      bListController.loadData(userId: getUserId(), page: index + 1);
                    },
                    initialPage: 0,
                    config: NumberPaginatorUIConfig(
                      buttonSelectedForegroundColor: Colors.black,
                      buttonUnselectedForegroundColor: Colors.grey,
                      buttonSelectedBackgroundColor: lightColorScheme.primary,
                    ),
                  )),
            ],
          )
        : const Center(
            child: Padding(
              padding: EdgeInsets.only(top: 30.0),
              child: Text('북마크한 레시피가 없습니다.'),
            ),
          );
  }

  Future _initBookmarkRec(int recipeId) async {
    Get.put(RecommendController());
    await Get.find<RecommendController>().loadBookmarkRec(recipeId: recipeId);
  }

  InkWell bookmarkRecCardWidget(RecipeResponse recipeResponse) {
    return InkWell(
      onTap: () {
        Get.toNamed('/recipe_detail', arguments: recipeResponse.recipeId);
      },
      child: Container(
        margin: const EdgeInsets.only(right: 15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25.0),
            color: Colors.white),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 15.0, left: 15, right: 15, bottom: 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25.0),
                child: Image.network(
                  '${recipeResponse.thumbnail}',
                  fit: BoxFit.fill,
                  height: 80,
                  width: 80,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Container(
                constraints: const BoxConstraints(
                  maxWidth: 100,
                ),
                child: Text(
                  '${recipeResponse.name}',
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
