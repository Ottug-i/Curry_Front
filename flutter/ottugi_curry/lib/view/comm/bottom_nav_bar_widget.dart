import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ottugi_curry/config/color_schemes.dart';
import 'package:ottugi_curry/view/controller/bottom_nav_bar_controller.dart';

class BottomNavBarWidget extends StatelessWidget {
  const BottomNavBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(BottomNavBarController());
    final bottomNavBarController = Get.find<BottomNavBarController>();
    List<String> bottomNavBarItemLabel = ['main', 'search', 'recipe', 'user', 'bookmark'];

    final url = Get.currentRoute;
    if (url.contains('/main')) {
      bottomNavBarController.currentIdx.value = 0;
    } else if (url.contains('/search')) {
      bottomNavBarController.currentIdx.value = 1;
    } else if (url.contains('/recipe')) {
      bottomNavBarController.currentIdx.value = 2;
    } else if (url.contains('/user')) {
      bottomNavBarController.currentIdx.value = 3;
    } else if (url.contains('/bookmark')) {
      bottomNavBarController.currentIdx.value = 4;
    }

    void handleOnTap(int idx) {
      Get.put(BottomNavBarController());
      Get.find<BottomNavBarController>().updateCurrentIdx(idx);
      if (idx == 0) {
        Get.offAndToNamed('/main');
      } else if (idx == 1) {
        Get.offAndToNamed('/search');
      } else if (idx == 2) {
        Get.offAndToNamed('/recipe');
      } else if (idx == 3) {
        Get.offAndToNamed('/user');
      } else if (idx == 4) {
        Get.offAndToNamed('/bookmark');
      }
    }

    return ClipRRect(
      borderRadius: const BorderRadius.only(
          topRight: Radius.circular(25.0), topLeft: Radius.circular(25.0)),
      child: BottomNavigationBar(
        backgroundColor: Colors.white,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        currentIndex: Get.find<BottomNavBarController>().currentIdx.toInt(),
        onTap: handleOnTap,
        items: bottomNavBarItemLabel
            .map((e) => bottomNavBarItem(bottomNavBarItemLabel.indexOf(e), e))
            .toList(),
      ),
    );
  }

  BottomNavigationBarItem bottomNavBarItem(int idx, String label) {
    Get.put(BottomNavBarController());
    int currentIdx = Get.find<BottomNavBarController>().currentIdx.toInt();
    List<double> bottomNavBarItemIconSize = [24, 26, 25, 26, 25];

    return BottomNavigationBarItem(
        icon: CircleAvatar(
          backgroundColor:
              currentIdx == idx ? lightColorScheme.primary : Colors.transparent,
          foregroundColor: currentIdx == idx ? Colors.black : Colors.grey,
          child: ImageIcon(
            AssetImage('assets/icons/$label.png'),
            size: bottomNavBarItemIconSize[idx],
          ),
        ),
        label: label);
  }
}
