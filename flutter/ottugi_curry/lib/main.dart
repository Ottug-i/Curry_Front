import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:ottugi_curry/config/config.dart';
import 'package:ottugi_curry/config/custom_theme_data.dart';

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
      getPages: Config.routers,
      // home: ListPage(),
    );
  }
}
