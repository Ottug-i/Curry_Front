import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ottugi_curry/config/color_schemes.dart';
import 'package:ottugi_curry/config/config.dart';
import 'package:ottugi_curry/view/page/recipe_list/recipe_list_page_button.dart';
import 'package:ottugi_curry/view/controller/bookmark/bookmark_list_controller.dart';

class BookmarkCategories extends StatefulWidget {
  const BookmarkCategories({super.key});

  @override
  BookmarkCategoriesState createState() => BookmarkCategoriesState();
}

class BookmarkCategoriesState extends State<BookmarkCategories> {
  final controller = Get.put(BookmarkListController());

  void updateCategory(value) {
    // 화면 UI 업데이트 위해서
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
              margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              child: Column(
                children: [
                  Row(
                    children: [
                      RecipeListPageButton(
                        text: '요리 시간',
                        isButtonClicked:
                            controller.selectedCategory.value == 'time',
                        themecolor: lightColorScheme.primary,
                        onPressed: () {
                          updateCategory('time');
                        },
                      ),
                      const SizedBox(width: 10),
                      RecipeListPageButton(
                          text: '난이도',
                          isButtonClicked:
                              controller.selectedCategory.value == 'level',
                          themecolor: lightColorScheme.primary,
                          onPressed: () {
                            updateCategory('level');
                          }),
                      const SizedBox(width: 10),
                      RecipeListPageButton(
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
                            Obx(() => RecipeListPageButton(
                                  text: itemT,
                                  isButtonClicked:
                                      controller.searchTime.value == itemT,
                                  themecolor: lightColorScheme.secondary,
                                  onPressed: () {
                                    controller.toggleValue(
                                        controller.searchTime, itemT);
                                    controller.searchData(
                                        userId: 1,
                                        page: controller
                                            .pageController.value.currentPage);
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
                          Obx(() => RecipeListPageButton(
                                text: itemL,
                                isButtonClicked:
                                    controller.searchDifficulty.value == itemL,
                                themecolor: lightColorScheme.secondary,
                                onPressed: () {
                                  controller.toggleValue(
                                      controller.searchDifficulty, itemL);
                                  controller.searchData(
                                      userId: 1,
                                      page: controller
                                          .pageController.value.currentPage);
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
                          Obx(() => RecipeListPageButton(
                                text: itmeC,
                                isButtonClicked:
                                    controller.searchComposition.value == itmeC,
                                themecolor: lightColorScheme.secondary,
                                onPressed: () {
                                  controller.toggleValue(
                                      controller.searchComposition, itmeC);
                                  controller.searchData(
                                      userId: 1,
                                      page: controller
                                          .pageController.value.currentPage);
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
