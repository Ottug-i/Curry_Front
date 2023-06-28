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
    print('여기는 list_page.dart');
    await Get.find<MenuListController>().fetchData(1, ["달걀", "베이컨"], 1);
  }

  late final MenuListController rListController;

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
                      child: const Text(
                        "달걀, 베이컨",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          // decoration: TextDecoration.underline,
                          // decorationColor: lightColorScheme.primary,
                          // decorationThickness: 4,
                        ),
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
                                  rListController.MenuModelList[i],
                                  const ["달걀", "베이컨"]);
                            }),
                      ),
                      if (rListController.response.value.totalPages != 1)
                        const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 30),
                            child: NumbersPage()),
                    ],
                  )
              ],
            ),
          );
        });
  }
}

class NumbersPage extends StatefulWidget {
  const NumbersPage({Key? key}) : super(key: key);

  @override
  _NumbersPageState createState() => _NumbersPageState();
}

class _NumbersPageState extends State<NumbersPage> {
  int _currentPage = 0;
  final rListController = Get.find<MenuListController>();

  @override
  Widget build(BuildContext context) {
    return NumberPaginator(
      numberPages: rListController.response.value.totalPages!,
      onPageChange: (int index) {
        setState(() {
          // NumberPaginator위젯이 변화 감지를 위한 부분.
          // 감지하면 자동 업뎃되어 동그라미가 현재 페이지로 이동하게 됨
          _currentPage = index;
        });
        rListController.fetchData(1, ["달걀", "베이컨"], index + 1);
      },
      config: NumberPaginatorUIConfig(
        buttonSelectedForegroundColor: Colors.black,
        buttonUnselectedForegroundColor: Colors.grey,
        buttonSelectedBackgroundColor: lightColorScheme.primary,
      ),
    );
  }
}
