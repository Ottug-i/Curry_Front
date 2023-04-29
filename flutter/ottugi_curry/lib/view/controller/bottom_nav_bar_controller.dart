import 'package:get/get.dart';

class BottomNavBarController {
  final currentIdx = 0.obs;

  void updateCurrentIdx(int idx) {
    currentIdx.value = idx;
  }
}