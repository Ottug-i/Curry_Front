import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:ottugi_curry/config/color_schemes.dart';
import 'package:ottugi_curry/view/comm/default_layout_widget.dart';
import 'package:ottugi_curry/view/controller/text_search/text_search_controller.dart';
import 'package:ottugi_curry/view/page/recipe_list/list_item_widget.dart';
import 'package:ottugi_curry/view/page/text_search/text_search_categories_widget.dart';

class TextSearchPage extends StatelessWidget {
  const TextSearchPage({Key? key}) : super(key: key);

  Future _initRankList() async {
    await Get.find<TextSearchController>().loadRankList();
  }

  @override
  Widget build(BuildContext context) {
    Get.put(TextSearchController());
    final searchController = Get.find<TextSearchController>();

    return DefaultLayoutWidget(
      appBarTitle: '레시피 검색',
      body: FutureBuilder(
          future: _initRankList(),
          builder: (context, snap) {
            if (snap.connectionState != ConnectionState.done) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return SingleChildScrollView(
              child: Column(
                children: [
                  // 검색어 입력 창
                  Container(
                    margin: const EdgeInsets.fromLTRB(16, 10, 16, 10),
                    child: TextField(
                      controller: searchController.textEditingController.value,
                      onSubmitted: (String text) {
                        if (searchController
                            .textEditingController.value.text.isNotEmpty) {
                          searchController.handleTextSearch(
                              name: text, page: 1);
                        }
                      },
                      decoration: InputDecoration(
                          prefixIcon: IconButton(
                            icon: Icon(
                              Icons.search,
                              color: lightColorScheme.primary,
                            ),
                            onPressed: () {
                              searchController
                                  .textEditingController.value.text = '';
                              searchController.searchName.value = '';
                            },
                          ),
                          hintText: '레시피 이름을 입력하고 Enter를 눌러주세요.',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                  color: Colors.black))), // InputDecoration
                    ), // TextField
                  ),

                  // 옵션 위젯
                  Obx(
                    () => searchController.searchName.isNotEmpty
                        ? const TextSearchCategoriesWidget()
                        : const SizedBox(),
                  ),

                  // 검색 결과
                  Obx(
                    () => searchController.searchName.value.isNotEmpty
                        ? Column(
                            children: [
                              // 결과
                              Obx(
                                () => ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: searchController
                                        .recipeListResponse
                                        .value
                                        .content
                                        ?.length,
                                    itemBuilder: (BuildContext context, int i) {
                                      return ListItemWidget(
                                        menuItem: searchController
                                            .recipeListResponse
                                            .value
                                            .content![i],
                                        controller: searchController,
                                      );
                                    }),
                              ),

                              // 페이징
                              searchController.recipeListResponse.value.content!
                                      .isNotEmpty
                                  ? Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20,
                                          right: 20,
                                          top: 5,
                                          bottom: 10),
                                      child: Obx(() => NumberPaginator(
                                            // 페이지가 reload되어 totalPages가 바뀌면 업데이트 되어야 함
                                            numberPages: searchController
                                                    .recipeListResponse
                                                    .value
                                                    .totalPages ??
                                                0,
                                            controller: searchController
                                                .pageController.value,
                                            onPageChange: (int index) {
                                              print('print index: ${index}');
                                              print(
                                                  'print pageControllerCurrentPage: ${searchController.pageController.value.currentPage}');
                                              searchController
                                                  .handlePaging(index + 1);
                                            },
                                            initialPage: 0,
                                            config: NumberPaginatorUIConfig(
                                              buttonSelectedForegroundColor:
                                                  Colors.black,
                                              buttonUnselectedForegroundColor:
                                                  Colors.grey,
                                              buttonSelectedBackgroundColor:
                                                  lightColorScheme.primary,
                                            ),
                                          )))
                                  : const Padding(
                                      padding: EdgeInsets.only(top: 10),
                                      child: Text('검색 결과가 없습니다.'),
                                    )
                            ],
                          )

                        // 인기 검색어
                        : searchController.rankList.isNotEmpty
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 20, left: 30),
                                    child: Text(
                                      '인기 검색어',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 450,
                                    child: ListView.builder(
                                      padding: const EdgeInsets.only(
                                          top: 17,
                                          bottom: 14,
                                          left: 30,
                                          right: 30),
                                      itemCount:
                                          searchController.rankList.length,
                                      itemBuilder:
                                          (BuildContext context, int idx) {
                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                searchController
                                                    .handleTextSearch(
                                                  name:
                                                      '${searchController.rankList[idx].name}',
                                                );
                                                searchController
                                                        .textEditingController
                                                        .value
                                                        .text =
                                                    searchController
                                                        .rankList[idx].name!;
                                              },
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 3, bottom: 3),
                                                child: RichText(
                                                    text: TextSpan(
                                                        text: '${idx + 1}   ',
                                                        style: TextStyle(
                                                          fontSize: 17,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color:
                                                              lightColorScheme
                                                                  .primary,
                                                        ),
                                                        children: [
                                                      TextSpan(
                                                          text:
                                                              '${searchController.rankList[idx].name}',
                                                          style: DefaultTextStyle
                                                                  .of(context)
                                                              .style)
                                                    ])),
                                              ),
                                            ),
                                            const Divider(
                                              thickness: 0.3,
                                              color: Colors.grey,
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              )
                            : const SizedBox(),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
