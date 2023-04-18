import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ottugi_curry/view_model/menu_view_model.dart';

class ItemsWidget extends StatelessWidget {
  const ItemsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final menuController = Get.put(MenuViewModel());

    var imageNames = [
      'egg-benedict.jpeg',
      'hangtown-fry.jpeg',
      'sandwich.jpeg',
      'taco.jpeg'
    ];
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: menuController.menuList.length,
      itemBuilder: (BuildContext context, int i) {
        return Container(
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            // card
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(24.0),
                  child: Image.asset(
                    imageNames.length > i
                        ? "images/${imageNames[i]}"
                        : "images/taco.jpeg",
                    width: 160,
                  ),
                ),
                Expanded(
                  //flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Column(
                      children: [
                        // 첫 번째 줄 (메뉴 이름, 북마크 아이콘)
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // 음식 이름 + 재료 설명
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Obx(() => Text(
                                      '${menuController.menuList[i].name}',
                                      style: const TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 18,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )),
                                const SizedBox(
                                  height: 12,
                                ),
                              ],
                            ),
                            // 북마크 아이콘
                            Container(
                              margin: const EdgeInsets.only(left: 8, right: 8),
                              alignment: Alignment.topLeft,
                              //crossAxisAlignment: CrossAxisAlignment.start,
                              child: const Icon(
                                Icons.bookmark_border_rounded,
                                size: 30,
                                color: Color(0xffFFD717),
                              ),
                            ),
                          ],
                        ),
                        // 두 번째 줄 (재료 목록)
                        Row(children: [
                          Expanded(
                              child: Obx(
                            () => Text(
                              '${menuController.menuList[i].ingredients}',
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          )),
                        ]),
                        const SizedBox(
                          height: 12,
                        ),
                        // 세 번째 줄 (아이콘 - 시간, 난이도, 구성)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                const Icon(Icons.timer, size: 30),
                                Obx(() => Text(
                                    '${menuController.menuList[i].time}',
                                    style: const TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 14,
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal)))
                              ],
                            ),
                            Column(
                              children: [
                                const Icon(Icons.handshake_outlined, size: 30),
                                Obx(() => Text(
                                    '${menuController.menuList[i].difficulty}',
                                    style: const TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 14,
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal)))
                              ],
                            ),
                            Column(
                              children: [
                                const Icon(Icons.food_bank_rounded, size: 30),
                                Obx(() => Text(
                                    '${menuController.menuList[i].composition}',
                                    style: const TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 14,
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal)))
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ));
      },
    );
  }
}
