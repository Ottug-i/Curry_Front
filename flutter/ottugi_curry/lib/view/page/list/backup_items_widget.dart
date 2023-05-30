import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ottugi_curry/view_model/list/recipe_list_view_model.dart';

class ItemsWidget extends StatefulWidget {
  const ItemsWidget({Key? key}) : super(key: key);

  @override
  _ItemsWidgetState createState() => _ItemsWidgetState();
}

class _ItemsWidgetState extends State<ItemsWidget> {
  Future<void> _initMenuList() async {
    print('print Get.arguments: ${Get.arguments}');
    await Get.find<MenuListViewModel>().fetchData(1, ["6855278", "6909678"]);
  }

  @override
  Widget build(BuildContext context) {
    Get.put(MenuListViewModel());
    final rListController = Get.find<MenuListViewModel>();

    return FutureBuilder(
        future: _initMenuList(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final menuList = rListController.MenuModelList;
          if (menuList.isNotEmpty) {
            return Expanded(
                // 또는 SizedBox 등을 사용하여 사이즈를 제약할 수 있습니다.
                child: ListView.builder(
              itemCount: menuList.length,
              itemBuilder: (context, index) {
                final menuItem = menuList[index];
                return ListTile(
                  title: Text(menuItem.name ?? ''),
                  subtitle: Text(menuItem.composition ?? ''),
                  leading: Image.network(menuItem.thumbnail ?? ''),
                );
              },
            ));
          } else {
            return const Center(
              child: Text('추천 레시피를 찾지 못했습니다.'),
            );
          }
        });
  }
}

Column iconWithText(IconData icon, String text) {
  return Column(
    children: [
      Icon(icon, size: 30),
      Text(text,
          style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
              color: Colors.black,
              fontWeight: FontWeight.normal))
    ],
  );
}
