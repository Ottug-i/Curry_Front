import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ottugi_curry/config/color_schemes.dart';
import 'package:ottugi_curry/view/comm/bottom_nav_bar_widget.dart';

/// AppBar, BottomNavigationBar 내장된 기본 레이아웃
/// 인자로 appBarTitle, body widget 넣어 사용
class DefaultLayoutWidget extends StatelessWidget {
  final String? appBarTitle;
  final Widget body;

  const DefaultLayoutWidget({
    Key? key,
    this.appBarTitle,
    required this.body,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: lightColorScheme.background,
        leading: Padding(
          padding: const EdgeInsets.only(left: 25),
          child: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () {
              Get.back();
            },
          ),
        ),
        title: Text(
          appBarTitle ?? '',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
      body: body,
      bottomNavigationBar: const BottomNavBarWidget(),
    );
  }
}
