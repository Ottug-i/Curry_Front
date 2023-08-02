import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PageScrollController extends GetxController {
  ScrollController scrollController = ScrollController();

  // 새로운 채팅 메시지가 도착할 때마다 이 함수를 호출합니다.
  void scrollToBottom() {
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
}
