import 'package:flutter/material.dart';
import 'package:ottugi_curry/view/page/list/categories.dart';
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
  final bListController = Get.put(BookmarkListViewModel());
  final textController = TextEditingController();

  Future<void> _initMenuList() async {
    print('여기는 bookmark_list_page.dart');
    await Get.find<BookmarkListViewModel>().fetchData(1);
    //print(Get.find<BookmarkListViewModel>().BoomrkList);
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
                          height: 10,
                        ),
                        Flexible(child: Obx(() => ItemList())),
                      ])
                  ],
                ),
              ),
            ),
          );
        });
  }

  Widget ItemList() {
    final menuList = bListController.BoomrkList;
    if (menuList.isNotEmpty) {
      return ListView.builder(
        shrinkWrap: true,
        itemCount: menuList.length,
        itemBuilder: (BuildContext context, int i) {
          final menuItem = menuList[i];
          return GestureDetector(
            onTap: () {
              Get.toNamed('/recipe_detail',
                  arguments: menuItem.id); //6909678: 레시피 아이디 예시
            },
            child: Container(
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // 음식 이름
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                  margin:
                                      const EdgeInsets.only(left: 8, right: 8),
                                  alignment: Alignment.topLeft,
                                  child: IconButton(
                                    icon: Icon(menuItem.isBookmark!
                                        ? Icons.bookmark_rounded
                                        : Icons.bookmark_border_rounded),
                                    iconSize: 30,
                                    color: const Color(0xffFFD717),
                                    onPressed: () {
                                      bListController.updateBookmark(
                                          1, menuItem.id);
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
                                style: Theme.of(context).textTheme.bodySmall,
                                overflow: TextOverflow.ellipsis,
                              )),
                            ]),
                            const SizedBox(
                              height: 12,
                            ),
                            // 세 번째 줄 (아이콘 - 시간, 난이도, 구성)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                iconWithText(
                                    context, Icons.timer, '${menuItem.time}'),
                                iconWithText(context, Icons.handshake_outlined,
                                    '${menuItem.difficulty}'),
                                iconWithText(context, Icons.food_bank_rounded,
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
