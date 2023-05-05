import 'package:flutter/material.dart';
import 'package:ottugi_curry/view/page/list/categories.dart';
import 'package:ottugi_curry/view/page/list/item_widget.dart';
import 'package:ottugi_curry/view/page/list/list_app_bar.dart';

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  ListPageState createState() => ListPageState();
}

class ListPageState extends State<ListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          const ListAppBar(),
          Container(
            width: double.infinity, // 또는 원하는 크기로 지정
            padding: const EdgeInsets.only(top: 10),
            color: const Color(0xffF5F5F5),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // 식재료 text
                  Row(children: const [
                    Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Text(
                        "감자, 치즈, 계란",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          decoration: TextDecoration.underline,
                          decorationColor: Color(0xffFFD717),
                          decorationThickness: 4,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    Icon(
                      Icons.edit_rounded,
                      size: 20,
                      color: Colors.black,
                    ),
                    Spacer(),
                  ]),

                  // 카테고리 위젯
                  const CategoriesWidget(),

                  // 아이템 위젯
                  const ItemsWidget(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
