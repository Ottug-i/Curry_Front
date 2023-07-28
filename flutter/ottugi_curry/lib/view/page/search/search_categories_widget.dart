import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ottugi_curry/config/color_schemes.dart';
import 'package:ottugi_curry/config/config.dart';
import 'package:ottugi_curry/view/controller/search/text_search_controller.dart';
import 'package:ottugi_curry/view/page/list/list_page_button.dart';

class SearchCategoriesWidget extends StatelessWidget {
  const SearchCategoriesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(TextSearchController());
    final searchController = Get.find<TextSearchController>();

    return Container(
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          Obx(
            ()=> Row(
              children: [
                ListPageButton(
                  text: '요리 시간',
                  isButtonClicked:
                  searchController.selectedCategory.value == 'time',
                  themecolor: lightColorScheme.primary,
                  onPressed: () {
                    searchController.updateCategory('time');
                  },
                ),
                const SizedBox(width: 10),
                ListPageButton(
                    text: '난이도',
                    isButtonClicked:
                    searchController.selectedCategory.value == 'level',
                    themecolor: lightColorScheme.primary,
                    onPressed: () {
                      searchController.updateCategory('level');
                    }),
                const SizedBox(width: 10),
                ListPageButton(
                  text: '구성',
                  isButtonClicked:
                  searchController.selectedCategory.value == 'composition',
                  themecolor: lightColorScheme.primary,
                  onPressed: () {
                    searchController.updateCategory('composition');
                  },
                )
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Obx(
            () => Column(
              children: [
                if (searchController.selectedCategory.value == 'time')
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
                            searchController.searchTime.value == itemT,
                            themecolor: lightColorScheme.secondary,
                            onPressed: () {
                              searchController.toggleValue(searchController.searchTime, itemT);
                              searchController.handleTextSearch(name: searchController.searchName.value, time: searchController.searchTime.value);
                            },
                          )),
                        const SizedBox(width: 10)
                      ],
                    ),
                  ),
                if (searchController.selectedCategory.value == 'level')
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
                              searchController.searchDifficulty.value == itemL,
                              themecolor: lightColorScheme.secondary,
                              onPressed: () {
                                searchController.toggleValue(
                                    searchController.searchDifficulty, itemL);
                                searchController.handleTextSearch(name: searchController.searchName.value, difficulty: searchController.searchDifficulty.value
                                );
                              },
                            )),
                          const SizedBox(width: 10)
                        ],
                      )),
                if (searchController.selectedCategory.value == 'composition')
                  Center(
                      child: Wrap(
                        direction: Axis.horizontal,
                        alignment: WrapAlignment.start,
                        spacing: 7,
                        runSpacing: 5,
                        children: [
                          for (final itemC in Config().compoType)
                            Obx(() => ListPageButton(
                              text: itemC,
                              isButtonClicked:
                              searchController.searchComposition.value == itemC,
                              themecolor: lightColorScheme.secondary,
                              onPressed: () {
                                searchController.toggleValue(
                                    searchController.searchComposition, itemC);
                                searchController.handleTextSearch(name: searchController.searchName.value, composition: searchController.searchComposition.value);
                              },
                            )),
                          const SizedBox(width: 10)
                        ],
                      )),
              ],
            ),
          ),
        ],
      ),
    );
    
  }
}
