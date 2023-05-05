import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:ottugi_curry/config/custom_theme_data.dart';

import 'package:ottugi_curry/view/page/list/list_page.dart';
import 'package:ottugi_curry/view/page/list/recipe_recs_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: '카레',
      theme: CustomThemeData.themeDataLight,
      initialRoute: '/',
      //getPages: Config.routers,
      home: const RecipeRecs(),
    );
  }
}
