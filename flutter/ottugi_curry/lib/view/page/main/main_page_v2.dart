import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainPageV2 extends StatelessWidget {
  const MainPageV2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool condition = true;
    final rowWidgetWidth = MediaQuery.of(context).size.width/2-40;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.asset(
                    'assets/images/curry_logo.png',
                    height: 30,
                  ),
                ),
                const Padding(padding: EdgeInsets.only(top: 30)),

                condition == true
                ? Column(
                  children: [
                    Text(
                      '최근 본 레시피',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    // SizedBox(
                    //   height: 180,
                    //   child: ListView.builder(
                    //       padding: const EdgeInsets.only(
                    //           top: 14, bottom: 14),
                    //       shrinkWrap: true,
                    //       scrollDirection: Axis.horizontal,
                    //       itemCount:
                    //       userController.latelyList.length,
                    //       itemBuilder:
                    //           (BuildContext context, int idx) {
                    //         return latelyRecipeCardWidget(
                    //             userController.latelyList[idx]);
                    //       }),
                    // )
                  ],
                )
                : const SizedBox(),

                // 재료 찍어 레시피 추천 받기 버튼
                Container(
                  width: double.infinity,
                  height: 140,
                  padding: const EdgeInsets.only(
                      top: 20, bottom: 20, left: 20, right: 20),
                  margin: const EdgeInsets.only(top: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.0),
                    color: Colors.white,
                  ),
                  child: InkWell (
                    onTap: () {
                      Get.toNamed('/recipe');
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('재료 찍고\n레시피 추천 받기',
                          style: Theme.of(context).textTheme.titleMedium,),
                        Image.asset(
                          'assets/images/main_camera.png',
                          // width: 120,
                          width: rowWidgetWidth - 5,
                        ),
                      ],
                    ),
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // 사진 찍기 버튼
                    Container(
                      width:rowWidgetWidth,
                      height: 160,
                      padding: const EdgeInsets.only(
                          top: 20, bottom: 20, left: 20, right: 20),
                      margin: const EdgeInsets.only(top: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.0),
                        color: Colors.white,
                      ),
                      child: InkWell(
                        onTap: () {
                          // Get.toNamed('/recipe');
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('사진 찍기',
                                style: Theme.of(context).textTheme.titleMedium),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Image.asset(
                                'assets/images/main_ar.png',
                                height: 78,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Padding(padding: EdgeInsets.only(right: 15)),
                    //레시피 검색 버튼
                    Container(
                      width:rowWidgetWidth,
                      height: 160,
                      padding: const EdgeInsets.only(
                          top: 20, bottom: 20, left: 20, right: 20),
                      margin: const EdgeInsets.only(top: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.0),
                        color: Colors.white,
                      ),
                      child: InkWell(
                        onTap: () {
                          Get.toNamed('/search');
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('레시피 검색',
                                style: Theme.of(context).textTheme.titleMedium),
                            Image.asset(
                              'assets/images/main_search.png',
                              width: rowWidgetWidth - 5,
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // 북마크 버튼
                    Container(
                      width:rowWidgetWidth,
                      height: 160,
                      padding: const EdgeInsets.only(
                          top: 20, bottom: 20, left: 20, right: 20),
                      margin: const EdgeInsets.only(top: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.0),
                        color: Colors.white,
                      ),
                      child: InkWell(
                        onTap: () {
                          Get.toNamed('/bookmark');
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('북마크',
                                style: Theme.of(context).textTheme.titleMedium),
                            Image.asset(
                              'assets/images/main_bookmark.png',
                              width: rowWidgetWidth - 5,
                            ),
                          ],
                        ),
                      ),
                    ),

                    // 마이페이지 버튼
                    Container(
                      width:rowWidgetWidth,
                      height: 160,
                      padding: const EdgeInsets.only(
                          top: 20, bottom: 20, left: 20, right: 20),
                      margin: const EdgeInsets.only(top: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.0),
                        color: Colors.white,
                      ),
                      child: InkWell(
                        onTap: () {
                          Get.toNamed('/user');
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('마이페이지',
                                style: Theme.of(context).textTheme.titleMedium),
                            Image.asset(
                              'assets/images/main_user.png',
                              width: rowWidgetWidth - 5,
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
