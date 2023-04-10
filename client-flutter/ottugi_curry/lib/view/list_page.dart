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
                topRight: Radius.circular(35)
              )
            ),
            child: Column(

              // 검색창
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left:5),
                        height: 50,
                        width: 300,
                        child: TextFormField(
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "검색어를 입력하세요..."
                          ),
                        )
                      ),
                      const Spacer(),
                      const Icon(
                        Icons.camera_alt,
                        size: 27,
                        color: Color(0xffFFD717)
                      )
                    ],
                  ),
                ),

                // 카테고리 text
                Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 10
                  ),
                  child: const Text(
                    "Categories",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.black
                    ),
                  ),
                ),

                // 카테고리 위젯
                const CategoriesWidget(),

                // 아이템 위젯
                Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  child: const Text(
                    "Best Selling",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.black
                      ),
                    )
                ),

                const ItemsWidget(),  
              ],
            ),
          )
        ],
      ),
    );
  }
}