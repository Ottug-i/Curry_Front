import 'package:flutter/material.dart';
import 'package:ottugi_curry/view/page/list/categories.dart';
import 'package:ottugi_curry/view/page/list/item_widget.dart';
import 'package:get/get.dart';
import 'package:ottugi_curry/view_model/list/recipe_list_view_model.dart';

class ListPage extends StatefulWidget {
  final String mode;
  const ListPage({super.key, this.mode = 'search'});

  @override
  ListPageState createState() => ListPageState();
}

class ListPageState extends State<ListPage> {
  final rListController = Get.put(RecipeListViewModel());

  @override
  Widget build(BuildContext context) {
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
              widget.mode == 'search'
                  ? searchMode("감자, 치즈, 계란")
                  : bookmarkMode(),
              // 아이템 위젯
              if (rListController.recipeList.isEmpty)
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text('검색 결과가 없습니다.'),
                  ],
                )
              else
                // 카테고리 위젯
                const CategoriesWidget(),
              const ItemsWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

Row searchMode(String ingredients) {
  // 식재료 text
  return Row(children: [
    Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Text(
        ingredients,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black,
          decoration: TextDecoration.underline,
          decorationColor: Color(0xffFFD717),
          decorationThickness: 4,
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
  ]);
}

Column bookmarkMode() {
  final controller = TextEditingController();

  return Column(
    children: <Widget>[
      Container(
        margin: const EdgeInsets.fromLTRB(16, 10, 16, 10),
        child: TextField(
          controller: controller, // controller 사용
          decoration: InputDecoration(
              prefixIcon: const Icon(Icons.search),
              hintText: '레시피 이름을 검색하세요...',
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(
                      color: Colors.black))), // InputDecoration
        ), // TextField
      ), // Container
    ], // Widget
  );
}
