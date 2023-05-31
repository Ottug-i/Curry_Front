import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:ottugi_curry/model/menu.dart';
import 'package:ottugi_curry/model/menu_list.dart';
import 'package:ottugi_curry/repository/list_repository.dart';

class MenuListPage extends StatefulWidget {
  const MenuListPage({Key? key}) : super(key: key);

  @override
  _MenuListPageState createState() => _MenuListPageState();
}

class _MenuListPageState extends State<MenuListPage> {
  final MenuRepository _menuRepository = MenuRepository(Dio());

  Future<List<MenuModel>> _fetchMenuList() async {
    final menuList = MenuList(userId: 1, recipeId: ["6855278", "6909678"]);
    final menuModels = await _menuRepository.getMenuList(menuList);
    return menuModels;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu List'),
      ),
      body: FutureBuilder<List<MenuModel>>(
        future: _fetchMenuList(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            final menuModels = snapshot.data;
            if (menuModels != null && menuModels.isNotEmpty) {
              // Render the list of menu models
              return ListView.builder(
                itemCount: menuModels.length,
                itemBuilder: (context, index) {
                  final menuModel = menuModels[index];
                  return ListTile(
                    title: Text(menuModel.name ?? ''),
                    subtitle: Text(menuModel.composition ?? ''),
                    leading: Image.network(menuModel.thumbnail ?? ''),
                  );
                },
              );
            } else {
              return const Center(
                child: Text('No menu found.'),
              );
            }
          }
        },
      ),
    );
  }
}
