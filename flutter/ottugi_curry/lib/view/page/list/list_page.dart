import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:number_paginator/number_paginator.dart';
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

class ListPageState extends State<ListPage> {
  //List<String> get ingredientList => widget.ingredientList;

  Future<void> _initMenuList() async {
    await Get.find<MenuListController>().fetchData(1, 1);
  }

  late final MenuListController rListController;
  final NumberPaginatorController pageController = NumberPaginatorController();
  bool isChange = false;

  @override
  void initState() {
    super.initState();
    rListController = Get.put(MenuListController());
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
                          rListController.selectedIngredient.value
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
                                        const Text('촬영한 재료가 아니라면 선택을 해제하세요.'),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Column(
                                            children: rListController
                                                .ingredientList.value
                                                .map((favorite) {
                                          return CheckboxListTile(
                                              activeColor: lightColorScheme
                                                  .primary,
                                              checkboxShape:
                                                  RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5)),
                                              value: favorite["isChecked"],
                                              title: Text(favorite["name"],
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleMedium),
                                              onChanged: (val) {
                                                // 재료 변경 없이 완료 누르면 현재 페이지에 있는게 맞음
                                                isChange = true;
                                                setState(() {
                                                  favorite["isChecked"] = val;
                                                });
                                              });
                                        }).toList()),
                                        SizedBox(
                                          width: 100,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              if (isChange) {
                                                rListController
                                                    .changeIngredients();
                                                rListController.fetchData(1, 1);
                                                pageController.navigateToPage(
                                                    0); // 1페이지로 이동(초기화)
                                              }
                                              isChange = false;
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
                if (rListController.MenuModelList.isEmpty)
                  const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('검색 결과가 없습니다.'),
                    ],
                  )
                else
                  Column(
                    children: [
                      Obx(
                        () => ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: rListController.MenuModelList.length,
                            itemBuilder: (BuildContext context, int i) {
                              return ItemsWidget(
                                  rListController.MenuModelList[i]);
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
                                  rListController.fetchData(1, index + 1);
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
