import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ottugi_curry/view/page/list/list_page_button.dart';
import 'package:ottugi_curry/view_model/bookmark/bookmark_view_model.dart';

class CategoriesWidget extends StatefulWidget {
  const CategoriesWidget({super.key});

  @override
  CategoriesWidgetState createState() => CategoriesWidgetState();
}

class CategoriesWidgetState extends State<CategoriesWidget> {
  //final controller = Get.put(MenuListViewModel());
  final controller = Get.put(BookmarkListViewModel());
  //late String categories = controller.selectedCategory.value;

  void updateCategory(value) {
    if (controller.selectedCategory.value == value) {
      controller.updateCategory('');
    } else {
      controller.updateCategory(value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookmarkListViewModel>(
        builder: (controller) => Container(
              margin: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Row(
                    children: [
                      ListPageButton(
                        text: '요리 시간',
                        isButtonClicked:
                            controller.selectedCategory.value == 'time',
                        themecolor: const Color(0xffFFD717),
                        onPressed: () {
                          updateCategory('time');
                        },
                      ),
                      const SizedBox(width: 10),
                      ListPageButton(
                          text: '난이도',
                          isButtonClicked:
                              controller.selectedCategory.value == 'level',
                          themecolor: const Color(0xffFFD717),
                          onPressed: () {
                            updateCategory('level');
                          }),
                      const SizedBox(width: 10),
                      ListPageButton(
                        text: '구성',
                        isButtonClicked:
                            controller.selectedCategory.value == 'composition',
                        themecolor: const Color(0xffFFD717),
                        onPressed: () {
                          updateCategory('composition');
                        },
                      )
                    ],
                  ),
                  if (controller.selectedCategory.value == 'time')
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Obx(() => ListPageButton(
                                    text: '15분',
                                    isButtonClicked:
                                        controller.time.value == '15분',
                                    themecolor: const Color(0xffFFA517),
                                    onPressed: () {
                                      controller.toggleValue(
                                          controller.time, '15분');
                                      controller.serachByOption(1);
                                    },
                                  )),
                              const SizedBox(width: 10),
                              Obx(() => ListPageButton(
                                    text: '20분',
                                    isButtonClicked:
                                        controller.time.value == '20분',
                                    themecolor: const Color(0xffFFA517),
                                    onPressed: () {
                                      controller.toggleValue(
                                          controller.time, '20분');
                                      controller.serachByOption(1);
                                    },
                                  )),
                              const SizedBox(width: 10),
                              Obx(() => ListPageButton(
                                    text: '30분 이상',
                                    isButtonClicked:
                                        controller.time.value == '30분',
                                    themecolor: const Color(0xffFFA517),
                                    onPressed: () {
                                      controller.toggleValue(
                                          controller.time, '30분');
                                      controller.serachByOption(1);
                                    },
                                  )),
                            ],
                          ),
                        )
                      ],
                    )
                  else if (controller.selectedCategory.value == 'level')
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Obx(() => ListPageButton(
                                    text: '왕초보',
                                    isButtonClicked:
                                        controller.difficulty.value == '왕초보',
                                    themecolor: const Color(0xffFFA517),
                                    onPressed: () {
                                      controller.toggleValue(
                                          controller.difficulty, '왕초보');
                                      controller.serachByOption(1);
                                    },
                                  )),
                              const SizedBox(width: 10),
                              Obx(() => ListPageButton(
                                    text: '초급',
                                    isButtonClicked:
                                        controller.difficulty.value == '초급',
                                    themecolor: const Color(0xffFFA517),
                                    onPressed: () {
                                      controller.toggleValue(
                                          controller.difficulty, '초급');
                                      controller.serachByOption(1);
                                    },
                                  )),
                              const SizedBox(width: 10),
                              Obx(
                                () => ListPageButton(
                                  text: '중급',
                                  isButtonClicked:
                                      controller.difficulty.value == '중급',
                                  themecolor: const Color(0xffFFA517),
                                  onPressed: () {
                                    controller.toggleValue(
                                        controller.difficulty, '중급');
                                    controller.serachByOption(1);
                                  },
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    )
                  else if (controller.selectedCategory.value == 'composition')
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Obx(() => ListPageButton(
                                    text: '가볍게',
                                    isButtonClicked:
                                        controller.composition.value == '가볍게',
                                    themecolor: const Color(0xffFFA517),
                                    onPressed: () {
                                      controller.toggleValue(
                                          controller.composition, '가볍게');
                                      controller.serachByOption(1);
                                    },
                                  )),
                              const SizedBox(width: 10),
                              Obx(() => ListPageButton(
                                    text: '든든하게',
                                    isButtonClicked:
                                        controller.composition.value == '든든하게',
                                    themecolor: const Color(0xffFFA517),
                                    onPressed: () {
                                      controller.toggleValue(
                                          controller.composition, '든든하게');
                                      controller.serachByOption(1);
                                    },
                                  )),
                            ],
                          ),
                        )
                      ],
                    )
                ],
              ),
            ));
  }
}
