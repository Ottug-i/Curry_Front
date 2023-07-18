import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ottugi_curry/config/color_schemes.dart';
import 'package:ottugi_curry/config/config.dart';
import 'package:ottugi_curry/view/page/list/list_page_button.dart';
import 'package:ottugi_curry/view/controller/bookmark/bookmark_controller.dart';

class CategoriesWidget extends StatefulWidget {
  const CategoriesWidget({super.key});

  @override
  CategoriesWidgetState createState() => CategoriesWidgetState();
}

class CategoriesWidgetState extends State<CategoriesWidget> {
  //final controller = Get.put(MenuListController());
  final controller = Get.put(BookmarkListController());
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
    return GetBuilder<BookmarkListController>(
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
                        themecolor: lightColorScheme.primary,
                        onPressed: () {
                          updateCategory('time');
                        },
                      ),
                      const SizedBox(width: 10),
                      ListPageButton(
                          text: '난이도',
                          isButtonClicked:
                              controller.selectedCategory.value == 'level',
                          themecolor: lightColorScheme.primary,
                          onPressed: () {
                            updateCategory('level');
                          }),
                      const SizedBox(width: 10),
                      ListPageButton(
                        text: '구성',
                        isButtonClicked:
                            controller.selectedCategory.value == 'composition',
                        themecolor: lightColorScheme.primary,
                        onPressed: () {
                          updateCategory('composition');
                        },
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  if (controller.selectedCategory.value == 'time')
                    Center(
                      child: Wrap(
                        direction: Axis.horizontal,
                        alignment: WrapAlignment.start,
                        spacing: 4,
                        runSpacing: 5,
                        children: [
                          for (final itemT in Config().timeType)
                            Obx(() => ListPageButton(
                                  text: itemT,
                                  isButtonClicked:
                                      controller.time.value == itemT,
                                  themecolor: lightColorScheme.secondary,
                                  onPressed: () {
                                    controller.toggleValue(
                                        controller.time, itemT);
                                    controller.serachByOption(1);
                                  },
                                )),
                          const SizedBox(width: 10)
                        ],
                      ),
                    ),
                  if (controller.selectedCategory.value == 'level')
                    Center(
                        child: Wrap(
                      direction: Axis.horizontal,
                      alignment: WrapAlignment.start,
                      spacing: 7,
                      runSpacing: 5,
                      children: [
                        for (final itemL in Config().levelType)
                          Obx(() => ListPageButton(
                                text: itemL,
                                isButtonClicked:
                                    controller.difficulty.value == itemL,
                                themecolor: lightColorScheme.secondary,
                                onPressed: () {
                                  controller.toggleValue(
                                      controller.difficulty, itemL);
                                  controller.serachByOption(1);
                                },
                              )),
                        const SizedBox(width: 10)
                      ],
                    )),
                  if (controller.selectedCategory.value == 'composition')
                    Center(
                        child: Wrap(
                      direction: Axis.horizontal,
                      alignment: WrapAlignment.start,
                      spacing: 7,
                      runSpacing: 5,
                      children: [
                        for (final itmeC in Config().compoType)
                          Obx(() => ListPageButton(
                                text: itmeC,
                                isButtonClicked:
                                    controller.composition.value == itmeC,
                                themecolor: lightColorScheme.secondary,
                                onPressed: () {
                                  controller.toggleValue(
                                      controller.composition, itmeC);
                                  controller.serachByOption(1);
                                },
                              )),
                        const SizedBox(width: 10)
                      ],
                    )),
                ],
              ),
            ));
  }
}
