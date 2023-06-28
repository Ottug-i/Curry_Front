import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:ottugi_curry/model/menu.dart';
import 'package:ottugi_curry/model/menu_list.dart';
import 'package:ottugi_curry/repository/recipe_repository.dart';

class MenuListPage extends StatefulWidget {
  const MenuListPage({Key? key}) : super(key: key);

  @override
  _MenuListPageState createState() => _MenuListPageState();
}

class _MenuListPageState extends State<MenuListPage> {
  final RecipeRepository _recipeRepository = RecipeRepository(Dio());

  Future<List<MenuModel>> _fetchMenuList() async {
    final menuList =
        MenuList(userId: 1, ingredients: ["달걀", "베이컨"], page: 1, size: 10);
    final menuModels = await _recipeRepository.getMenuList(menuList);
    return menuModels.content!;
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
