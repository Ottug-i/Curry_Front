import 'package:flutter/material.dart';
import 'package:get/get.dart';

void bookmarkSnackBar({required isBookmark, required name}) {
  if (isBookmark!) {
    // 누르기 전 상태에 따라
    Get.showSnackbar(
      GetSnackBar(
        title: '북마크 삭제',
        message:
        '${name}을(를) 북마크에서 해제했습니다.',
        icon: const Icon(
          Icons.favorite_border,
          color: Colors.white,
        ),
        backgroundColor: Colors.blue,
        duration: const Duration(seconds: 2),
      ),
    );
  } else {
    Get.showSnackbar(
      GetSnackBar(
        title: '북마크 추가',
        message:
        '${name}을(를) 북마크에 저장했습니다.',
        icon: const Icon(
          Icons.favorite,
          color: Colors.white,
        ),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 2),
      ),
    );
  }
}