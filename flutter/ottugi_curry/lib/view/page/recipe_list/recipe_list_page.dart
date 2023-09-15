import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:ottugi_curry/config/color_schemes.dart';
import 'package:ottugi_curry/utils/user_profile_utils.dart';
import 'package:ottugi_curry/view/controller/list/recipe_list_controller.dart';
import 'package:ottugi_curry/view/page/recipe_list/list_item_widget.dart';
import 'package:ottugi_curry/view/page/recipe_list/recipe_list_categories.dart';

class RecipeListPage extends StatefulWidget {
  const RecipeListPage({super.key});

  @override
  RecipeListPageState createState() => RecipeListPageState();
}

class RecipeListPageState extends State<RecipeListPage> {
  //List<String> get ingredientList => widget.ingredientList;

  Future<void> _initMenuList() async {
    await Get.find<RecipeListController>()
        .fetchData(userId: getUserId(), page: 1);
  }

  late final RecipeListController rListController;
  final NumberPaginatorController pageController = NumberPaginatorController();
  bool isSelectedChange = false;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    rListController = Get.put(RecipeListController());
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void initPageNumber() {
    pageController.navigateToPage(0);
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
            controller: _scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Container(
                      // 검색어 밑줄 변경 - 기존에 글자와 밑줄 사이의 여백이 너무 작아서 Container border로 변경
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: lightColorScheme.primary,
                                  width: 4.0))),
                      child: Obx(
                        () => Text(
                          rListController.selectedIngredient
                              .reduce((value, element) => '$value, $element'),
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  IconButton(
                    icon: const Icon(Icons.edit_rounded),
                    iconSize: 20,
                    color: Colors.black,
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return StatefulBuilder(
                            builder:
                                (BuildContext context, StateSetter setState) {
                              return Dialog(
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        const Text('원하는 재료가 아니라면 선택을 해제하세요.'),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Obx(
                                          () => ListView.builder(
                                              shrinkWrap: true,
                                              itemCount: rListController
                                                  .selectedList.length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return CheckboxListTile(
                                                    activeColor: lightColorScheme
                                                        .primary,
                                                    checkboxShape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5)),
                                                    value: rListController
                                                            .selectedList[index]
                                                        ["isChecked"],
                                                    title: Text(
                                                        rListController
                                                                .selectedList[
                                                            index]["name"],
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .titleMedium),
                                                    onChanged: (val) {
                                                      if (rListController
                                                          .isLastOne()) {
                                                        // 선택된 요소가 하나일 때
                                                        if (val == false) {
                                                          // 해제하려고 하면
                                                          Get.showSnackbar(
                                                            const GetSnackBar(
                                                              title: '갯수 초과',
                                                              message:
                                                                  '최소 한 개 이상의 재료를 선택해야 합니다.',
                                                              icon: Icon(
                                                                Icons.check_box,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                              backgroundColor:
                                                                  Colors.red,
                                                              duration:
                                                                  Duration(
                                                                      seconds:
                                                                          3),
                                                            ),
                                                          );
                                                        } else {
                                                          // (다른 요소를) 새롭게 추가하려고 하면
                                                          isSelectedChange =
                                                              true;
                                                          rListController
                                                              .toggleSelectedList(
                                                                  index);
                                                        }
                                                      } else {
                                                        isSelectedChange = true;
                                                        rListController
                                                            .toggleSelectedList(
                                                                index);
                                                      }
                                                    });
                                              }),
                                        ),
                                        SizedBox(
                                          width: 100,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              if (isSelectedChange) {
                                                // rListController.changeIngredients();
                                                rListController.fetchData(
                                                    userId: getUserId(),
                                                    page: 1);
                                                pageController.navigateToPage(
                                                    0); // 1페이지로 이동(초기화)
                                              }
                                              isSelectedChange = false;
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text('완료'),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      );
                    },
                  ),
                ]),
                const SizedBox(
                  height: 10,
                ),
                // 아이템 위젯
                if (rListController.response.value.empty!)
                  const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('검색 결과가 없습니다.'),
                    ],
                  )
                else
                  Column(
                    children: [
                      RecipeListCategories(callback: initPageNumber),
                      Obx(
                        () => ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount:
                                rListController.response.value.content!.length,
                            itemBuilder: (BuildContext context, int i) {
                              return ListItemWidget(
                                  menuItem: rListController
                                      .response.value.content![i],
                                  controller: rListController);
                            }),
                      ),
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Obx(() => NumberPaginator(
                                // 페이지가 reload되어 totalPages가 바뀌면 업데이트 되어야 함
                                numberPages:
                                    rListController.response.value.totalPages!,
                                controller: pageController,
                                onPageChange: (int index) {
                                  rListController.fetchData(
                                      userId: getUserId(), page: index + 1);
                                  _scrollController.jumpTo(0);
                                },
                                config: NumberPaginatorUIConfig(
                                  buttonSelectedForegroundColor: Colors.black,
                                  buttonUnselectedForegroundColor: Colors.grey,
                                  buttonSelectedBackgroundColor:
                                      lightColorScheme.primary,
                                ),
                              ))),
                    ],
                  )
              ],
            ),
          );
        });
  }
}
