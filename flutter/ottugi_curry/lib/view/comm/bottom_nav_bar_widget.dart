import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ottugi_curry/config/color_schemes.dart';
import 'package:ottugi_curry/view/controller/bottom_nav_bar_controller.dart';

class BottomNavBarWidget extends StatelessWidget {
  const BottomNavBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(BottomNavBarController());
    List<String> bottomNavBarItemLabel = ['main', 'recipe', 'user', 'bookmark'];

    void handleOnTap(int idx) {
      Get.put(BottomNavBarController());
      Get.find<BottomNavBarController>().updateCurrentIdx(idx);
      if (idx == 0) {
        Get.offAndToNamed('/main');
      } else if (idx == 1) {
        Get.offAndToNamed('/recipe');
      } else if (idx == 2) {
        Get.offAndToNamed('/user');
      } else if (idx == 3) {
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
        // items:  [
        //   BottomNavigationBarItem(
        //       icon: CircleAvatar(
        //         backgroundColor: Get.find<BottomNavBarController>().currentIdx.toInt() == 0? lightColorScheme.primary : Colors.transparent,
        //         child: ImageIcon(
        //           AssetImage('assets/icons/main.png'),
        //         ),
        //       ),
        //       label: 'home'),
        //   BottomNavigationBarItem(
        //       icon: ImageIcon(
        //         AssetImage('assets/icons/recipe.png'),
        //       ),
        //       label: 'recipe'),
        //   BottomNavigationBarItem(
        //       icon: ImageIcon(
        //         AssetImage('assets/icons/user.png'),
        //       ),
        //       label: 'user'),
        //   BottomNavigationBarItem(
        //       icon: ImageIcon(
        //         AssetImage('assets/icons/bookmark.png'),
        //       ),
        //       label: 'bookmark'),
        // ],
      ),
    );
  }

  BottomNavigationBarItem bottomNavBarItem(int idx, String label) {
    Get.put(BottomNavBarController());
    int currentIdx = Get.find<BottomNavBarController>().currentIdx.toInt();

    return BottomNavigationBarItem(
        icon: CircleAvatar(
          backgroundColor:
              currentIdx == idx ? lightColorScheme.primary : Colors.transparent,
          foregroundColor: currentIdx == idx ? Colors.black : Colors.grey,
          child: ImageIcon(
            AssetImage('assets/icons/$label.png'),
            size: 25,
          ),
        ),
        label: label);
  }
}

// class BottomNavBarWidget extends StatefulWidget {
//   const BottomNavBarWidget({Key? key}) : super(key: key);
//
//   @override
//   State<BottomNavBarWidget> createState() => _BottomNavBarWidgetState();
// }
//
// class _BottomNavBarWidgetState extends State<BottomNavBarWidget> {
//   int _selectedIndex = 0;
//
//   final List<Widget> _bodyWidgets = <Widget>[
//     MainPage(),
//     RecipeCameraPage(),
//     UserPage(),
//     BookmarkPage()
//   ];
//
//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//
//   }
// }
