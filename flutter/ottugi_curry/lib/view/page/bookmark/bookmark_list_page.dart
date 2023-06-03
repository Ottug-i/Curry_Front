import 'package:flutter/material.dart';
import 'package:ottugi_curry/view/page/list/categories.dart';
import 'package:ottugi_curry/view/page/bookmark/bookmark_items_widget.dart';
import 'package:get/get.dart';
import 'package:ottugi_curry/view_model/bookmark/bookmark_view_model.dart';

class BookmrkListPage extends StatefulWidget {
  final String mode;
  const BookmrkListPage({super.key, this.mode = 'search'});

  @override
  BookmrkListPageState createState() => BookmrkListPageState();
}

//final bListController = Get.put(BookmarkListViewModel());

class BookmrkListPageState extends State<BookmrkListPage> {
  Future<void> _initMenuList() async {
    print('여기는 bookmark_list_page.dart');
    await Get.find<BookmarkListViewModel>().fetchData(1);
    //print(Get.find<BookmarkListViewModel>().BoomrkList);
  }

  @override
  Widget build(BuildContext context) {
    final bListController =
        Get.put(BookmarkListViewModel(), tag: Get.parameters['bookmark']);

    final textController = TextEditingController();

    return FutureBuilder(
        future: _initMenuList(),
        builder: (context, snap) {
          if (snap.connectionState != ConnectionState.done) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return Scaffold(
            resizeToAvoidBottomInset: false, // overflowed 방지
            body: Container(
              width: double.infinity, // 또는 원하는 크기로 지정
              padding: const EdgeInsets.only(top: 10),
              color: const Color(0xffF5F5F5),
              child: SingleChildScrollView(
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
                              bListController.searchData(
                                  1, text); //userId, text
                            },
                            decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.search),
                                hintText: '레시피 이름을 입력하고 Enter를 눌러주세요..',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: const BorderSide(
                                        color:
                                            Colors.black))), // InputDecoration
                          ), // TextField
                        ), // Container
                      ], // Widget
                    ),
                    // 아이템 위젯
                    if (bListController.BoomrkList.isEmpty)
                      const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Text('검색 결과가 없습니다.'),
                        ],
                      )
                    else
                      Column(mainAxisSize: MainAxisSize.min, children: [
                        // 카테고리 위젯
                        const CategoriesWidget(),
                        const SizedBox(
                          height: 20,
                        ),
                        Flexible(
                            child: ItemsWidget(controller: bListController)),
                      ])
                  ],
                ),
              ),
            ),
          );
        });
  }
}

void searchRecipe(String query) {
  Get.put(BookmarkListViewModel());
  final bListController = Get.find<BookmarkListViewModel>();

  var BoomrkList = bListController.BoomrkList;
  // 검색어에 해당하는 새로운 레시피 정보들
  final suggestions = BoomrkList.where((recipe) {
    final recipeTitle = recipe.name!.toLowerCase();
    final input = query.toLowerCase(); // 검색창에 입력한 정보들
    return recipeTitle.contains(input);
  }).toList();

  for (var e in suggestions) {
    debugPrint(e.toString());
  }

  // 검색결과로 업데이트
  BoomrkList.assignAll(suggestions);
}
