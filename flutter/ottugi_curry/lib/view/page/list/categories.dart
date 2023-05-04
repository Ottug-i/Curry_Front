import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ottugi_curry/view/page/list/list_page_button.dart';
import 'package:ottugi_curry/view_model/list/menu_view_model.dart';

class CategoriesWidget extends StatefulWidget {
  const CategoriesWidget({super.key});

  @override
  CategoriesWidgetState createState() => CategoriesWidgetState();
}

class CategoriesWidgetState extends State<CategoriesWidget> {
  final menuController = Get.put(MenuViewModel());

  void toggleCategory(value) {
    if (menuController.selectedCategory.value == value) {
      menuController.updateCategory('');
    } else {
      menuController.updateCategory(value);
    }
  }

  void toggleValue(value) {
    if (menuController.selectedCategoryValue.value == value) {
      menuController.updateCategoryValue('');
    } else {
      menuController.updateCategoryValue(value);
    }
    menuController.updateData();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MenuViewModel>(
        builder: (menuController) => Container(
              margin: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Row(
                    children: [
                      ListPageButton(
                        text: '요리 시간',
                        isButtonClicked:
                            menuController.selectedCategory.value == 'time'
                                ? true
                                : false,
                        themecolor: const Color(0xffFFD717),
                        onPressed: () {
                          toggleCategory('time');
                        },
                      ),
                      const SizedBox(width: 10),
                      ListPageButton(
                          text: '난이도',
                          isButtonClicked:
                              menuController.selectedCategory.value == 'level',
                          themecolor: const Color(0xffFFD717),
                          onPressed: () {
                            toggleCategory('level');
                          }),
                      const SizedBox(width: 10),
                      ListPageButton(
                        text: '구성',
                        isButtonClicked:
                            menuController.selectedCategory.value ==
                                'composition',
                        themecolor: const Color(0xffFFD717),
                        onPressed: () {
                          toggleCategory('composition');
                        },
                      )
                    ],
                  ),
                  if (menuController.selectedCategory.value == 'time')
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ListPageButton(
                                text: '10분',
                                isButtonClicked: menuController
                                        .selectedCategoryValue.value ==
                                    '10',
                                themecolor: const Color(0xffFFA517),
                                onPressed: () {
                                  toggleValue('10');
                                },
                              ),
                              const SizedBox(width: 10),
                              ListPageButton(
                                text: '20분',
                                isButtonClicked: menuController
                                        .selectedCategoryValue.value ==
                                    '20',
                                themecolor: const Color(0xffFFA517),
                                onPressed: () {
                                  toggleValue('20');
                                },
                              ),
                              const SizedBox(width: 10),
                              ListPageButton(
                                text: '30분 이상',
                                isButtonClicked: menuController
                                        .selectedCategoryValue.value ==
                                    '30',
                                themecolor: const Color(0xffFFA517),
                                onPressed: () {
                                  toggleValue('30');
                                },
                              ),
                            ],
                          ),
                        )
                      ],
                    )
                  else if (menuController.selectedCategory.value == 'level')
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ListPageButton(
                                text: '왕초보',
                                isButtonClicked: menuController
                                        .selectedCategoryValue.value ==
                                    '왕초보',
                                themecolor: const Color(0xffFFA517),
                                onPressed: () {
                                  toggleValue('왕초보');
                                },
                              ),
                              const SizedBox(width: 10),
                              ListPageButton(
                                text: '초급',
                                isButtonClicked: menuController
                                        .selectedCategoryValue.value ==
                                    '초급',
                                themecolor: const Color(0xffFFA517),
                                onPressed: () {
                                  // "초급" 버튼 눌렀을 때 동작 구현
                                  toggleValue('초급');
                                },
                              ),
                              const SizedBox(width: 10),
                              ListPageButton(
                                text: '중급',
                                isButtonClicked: menuController
                                        .selectedCategoryValue.value ==
                                    '중급',
                                themecolor: const Color(0xffFFA517),
                                onPressed: () {
                                  // "중급" 버튼 눌렀을 때 동작 구현
                                  toggleValue('중급');
                                },
                              ),
                            ],
                          ),
                        )
                      ],
                    )
                  else if (menuController.selectedCategory.value ==
                      'composition')
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ListPageButton(
                                text: '가볍게',
                                isButtonClicked: menuController
                                        .selectedCategoryValue.value ==
                                    '가볍게',
                                themecolor: const Color(0xffFFA517),
                                onPressed: () {
                                  // "가볍게" 버튼 눌렀을 때 동작 구현
                                  toggleValue('가볍게');
                                },
                              ),
                              const SizedBox(width: 10),
                              ListPageButton(
                                text: '든든하게',
                                isButtonClicked: menuController
                                        .selectedCategoryValue.value ==
                                    '든든하게',
                                themecolor: const Color(0xffFFA517),
                                onPressed: () {
                                  // "든든하게" 버튼 눌렀을 때 동작 구현
                                  toggleValue('든든하게');
                                },
                              ),
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
