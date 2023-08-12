import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ottugi_curry/config/color_schemes.dart';
import 'package:ottugi_curry/view/comm/bottom_nav_bar_widget.dart';

/// AppBar, BottomNavigationBar 내장된 기본 레이아웃
/// 인자로 appBarTitle, body widget 넣어 사용
class DefaultLayoutWidget extends StatelessWidget {
  final String? appBarTitle;
  final Widget body;
  final bool? backToMain; // 메인 페이지 이동 여부 저장
  final String? backToPageRoute; // 페이지 이동 루트 저장

  const DefaultLayoutWidget({
    Key? key,
    this.appBarTitle,
    required this.body,
    this.backToMain, // 뒤로 가기 버튼 눌렀을 때, 무조건 메인으로 돌아가도록 고정 필요한 경우 사용
    this.backToPageRoute, // 뒤로 가기 버튼 눌렀을 때, 특정 페이지로 이동하고 싶을 때 사용
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
              print('print getPreviousRoute: ${Get.previousRoute}');
              if (backToMain != null) {
                // 메인 페이지로 이동 (페이지 재로딩 위해 사용)
                Get.offAllNamed('/main');
              } else if (backToPageRoute != null) {
                Get.offAllNamed(backToPageRoute!);
              } else {
                Get.back();
              }
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
