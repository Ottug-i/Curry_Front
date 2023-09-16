import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:ottugi_curry/config/color_schemes.dart';
import 'package:ottugi_curry/utils/screen_size_utils.dart';
import 'package:ottugi_curry/view/comm/default_layout_widget.dart';
import 'package:ottugi_curry/view/controller/text_search/text_search_controller.dart';
import 'package:ottugi_curry/view/page/recipe_list/list_item_widget.dart';
import 'package:ottugi_curry/view/page/text_search/text_search_categories_widget.dart';

class TextSearchPage extends StatefulWidget {
  const TextSearchPage({Key? key}) : super(key: key);

  @override
  State<TextSearchPage> createState() => _TextSearchPageState();
}

class _TextSearchPageState extends State<TextSearchPage> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
    Get.put(TextSearchController()).textEditingController.value.text = '';
    Get.put(TextSearchController()).searchName.value = '';
  }

  Future _initRankList() async {
    Get.put(TextSearchController());
    final textSearchController = Get.find<TextSearchController>();
    await textSearchController.loadRankList();
  }

  @override
  Widget build(BuildContext context) {
    Get.put(TextSearchController());
    final searchController = Get.find<TextSearchController>();

    return DefaultLayoutWidget(
      backToMain: true,
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
              controller: _scrollController,
              child: Column(
                children: [
                  // 검색어 입력 창
                  Obx(
                    () => Container(
                      margin: const EdgeInsets.fromLTRB(16, 10, 16, 10),
                      child: TextField(
                        controller:
                            searchController.textEditingController.value,
                        onSubmitted: (String text) {
                          if (searchController
                              .textEditingController.value.text.isNotEmpty) {
                            searchController.searchName.value = text;
                            searchController.handleTextSearch(pageIndex: 0);
                          } else {
                            searchController.searchName.value = '';
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
                                        .recipeListPageResponse
                                        .value
                                        .content
                                        ?.length,
                                    itemBuilder: (BuildContext context, int i) {
                                      return ListItemWidget(
                                        menuItem: searchController
                                            .recipeListPageResponse
                                            .value
                                            .content![i],
                                        controller: searchController,
                                      );
                                    }),
                              ),

                              // 페이징
                              searchController.recipeListPageResponse.value
                                      .content!.isNotEmpty
                                  ? Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20,
                                          right: 20,
                                          top: 5,
                                          bottom: 10),
                                      child: Obx(() => NumberPaginator(
                                            // 페이지가 reload되어 totalPages가 바뀌면 업데이트 되어야 함
                                            numberPages: searchController
                                                    .recipeListPageResponse
                                                    .value
                                                    .totalPages ??
                                                0,
                                            controller: searchController
                                                .pageController.value,
                                            onPageChange: (int index) {
                                              searchController.handleTextSearch(pageIndex: index);
                                              // 스크롤 맨 위로 이동
                                              _scrollController.jumpTo(0);
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
                                        top: 20, left: 25),
                                    child: Text(
                                      '인기 검색어',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium,
                                    ),
                                  ),
                                  SizedBox(
                                    height: isWidthMobile(context) == true
                                        ? 450
                                        : 700,
                                    child: ListView.builder(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      padding: const EdgeInsets.only(
                                          top: 17,
                                          bottom: 14,
                                          left: 20,
                                          right: 20),
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
                                                // 변경 사항 저장
                                                searchController.searchName.value = searchController.rankList[idx].name!;
                                                searchController.textEditingController.value.text = searchController.rankList[idx].name!;
                                                // 검색
                                                searchController.handleTextSearch(pageIndex: 0);
                                              },
                                              child: Padding(
                                                padding:
                                                    isWidthMobile(context) ==
                                                            true
                                                        ? const EdgeInsets.only(
                                                            top: 3,
                                                            bottom: 3,
                                                            left: 7,
                                                            right: 7)
                                                        : const EdgeInsets.only(
                                                            top: 13,
                                                            bottom: 13,
                                                            left: 7,
                                                            right: 7),
                                                child: RichText(
                                                    text: TextSpan(
                                                        text: '${idx + 1}   ',
                                                        style: TextStyle(
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
