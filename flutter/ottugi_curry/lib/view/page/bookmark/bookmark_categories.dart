import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ottugi_curry/config/color_schemes.dart';
import 'package:ottugi_curry/config/config.dart';
import 'package:ottugi_curry/utils/user_profile_utils.dart';
import 'package:ottugi_curry/view/page/recipe_list/recipe_list_page_button.dart';
import 'package:ottugi_curry/view/controller/bookmark/bookmark_list_controller.dart';

class BookmarkCategories extends StatefulWidget {
  final VoidCallback callback; // 클릭 이벤트 콜백 함수
  const BookmarkCategories({super.key, required this.callback});

  @override
  BookmarkCategoriesState createState() => BookmarkCategoriesState();
}

class BookmarkCategoriesState extends State<BookmarkCategories> {

  void updateCategory(value) {
    Get.put(BookmarkListController());
    final controller = Get.find<BookmarkListController>();

    // 화면 UI 업데이트 위해서
    if (controller.selectedCategory.value == value) {
      controller.updateCategory('');
    } else {
      controller.updateCategory(value);
    }
  }

  @override
  Widget build(BuildContext context) {
    Get.put(BookmarkListController());

    return GetBuilder<BookmarkListController>(
        builder: (controller) => Container(
              margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              child: Column(
                children: [
                  Obx(
                    () => Row(
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
                          isButtonClicked: controller.selectedCategory.value ==
                              'composition',
                          themecolor: lightColorScheme.primary,
                          onPressed: () {
                            updateCategory('composition');
                          },
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Obx(
                    () {
                      if (controller.selectedCategory.value == 'time') {
                        return Center(
                          child: Wrap(
                            direction: Axis.horizontal,
                            alignment: WrapAlignment.start,
                            spacing: 4,
                            runSpacing: 5,
                            children: [
                              for (final itemT in Config().timeType)
                                RecipeListPageButton(
                                  text: itemT,
                                  isButtonClicked:
                                      controller.searchTime.value == itemT,
                                  themecolor: lightColorScheme.secondary,
                                  onPressed: () {
                                    controller.toggleValue(
                                        controller.searchTime, itemT);
                                    widget.callback();
                                    controller.searchData(
                                        userId: getUserId(),
                                        page: controller.currentPage.value);
                                  },
                                ),
                              const SizedBox(width: 10)
                            ],
                          ),
                        );
                      } else if (controller.selectedCategory.value == 'level') {
                        return Center(
                            child: Wrap(
                          direction: Axis.horizontal,
                          alignment: WrapAlignment.start,
                          spacing: 7,
                          runSpacing: 5,
                          children: [
                            for (final itemL in Config().levelType)
                              RecipeListPageButton(
                                text: itemL,
                                isButtonClicked:
                                    controller.searchDifficulty.value == itemL,
                                themecolor: lightColorScheme.secondary,
                                onPressed: () {
                                  controller.toggleValue(
                                      controller.searchDifficulty, itemL);
                                  widget.callback();
                                  controller.searchData(
                                      userId: getUserId(),
                                      page: controller.currentPage.value);
                                },
                              ),
                            const SizedBox(width: 10)
                          ],
                        ));
                      } else if (controller.selectedCategory.value ==
                          'composition') {
                        return Center(
                            child: Wrap(
                          direction: Axis.horizontal,
                          alignment: WrapAlignment.start,
                          spacing: 7,
                          runSpacing: 5,
                          children: [
                            for (final itmeC in Config().compoType)
                              RecipeListPageButton(
                                text: itmeC,
                                isButtonClicked:
                                    controller.searchComposition.value == itmeC,
                                themecolor: lightColorScheme.secondary,
                                onPressed: () {
                                  controller.toggleValue(
                                      controller.searchComposition, itmeC);
                                  widget.callback();
                                  controller.searchData(
                                      userId: getUserId(),
                                      page: controller.currentPage.value);
                                },
                              ),
                            const SizedBox(width: 10)
                          ],
                        ));
                      } else {
                        return const SizedBox();
                      }
                    },
                  ),
                ],
              ),
            ));
  }
}
