import 'package:flutter/material.dart';
import 'package:ottugi_curry/config/custom_theme_data.dart';
import 'package:ottugi_curry/view/page/recipe_detail_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '카레',
      theme: CustomThemeData.themeDataLight,
      home: const RecipeDetailPage(),
    );
  }
}