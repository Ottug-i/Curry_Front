import 'package:flutter/material.dart';
import 'package:ottugi_curry/view/categories.dart';
import 'package:ottugi_curry/view/item_widget.dart';
import 'package:ottugi_curry/view/list_app_bar.dart';

class ListPage extends StatelessWidget {
  const ListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          const ListAppBar(),
          Container(
            padding: const EdgeInsets.only(top: 20),
            decoration: const BoxDecoration(
                color: Color(0xffF5F5F5),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(35),
                    topRight: Radius.circular(35))),
            child: Column(
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
          )
        ],
      ),
    );
  }
}
