import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ottugi_curry/config/color_schemes.dart';
import 'package:ottugi_curry/model/recipe_response.dart';
import 'package:ottugi_curry/view/controller/recommend/recommend_controller.dart';

class MainPageV2 extends StatelessWidget {
  const MainPageV2({Key? key}) : super(key: key);

  Future _initRatingRec() async {
    Get.put(RecommendController());
    await Get.find<RecommendController>().getBookmarkList(1);
  }

  @override
  Widget build(BuildContext context) {
    Get.put(RecommendController());
    final recommendController = Get.find<RecommendController>();
    final rowWidgetWidth = MediaQuery.of(context).size.width / 2 - 30;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: lightColorScheme.background,
        title: Image.asset(
          'assets/images/curry_logo.png',
          height: 30,
        ),
        leading: const SizedBox(),
      ),
      body: FutureBuilder(
          future: _initRatingRec(),
          builder: (context, snap) {
            if (snap.connectionState != ConnectionState.done) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(
                      ()=> recommendController.ratingRecList.isNotEmpty
                          ? Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: Container(
                                width: double.infinity,
                                padding: const EdgeInsets.only(
                                    top: 20, bottom: 7, left: 20, right: 20),
                                margin: const EdgeInsets.only(top: 15),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25.0),
                                  color: Colors.white,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Get.toNamed('/rating');
                                      },
                                      child: Text(
                                        '오늘의 추천 레시피',
                                        style:
                                            Theme.of(context).textTheme.titleMedium,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 160,
                                      child: ListView.builder(
                                          padding: const EdgeInsets.only(
                                              top: 10, bottom: 10),
                                          shrinkWrap: true,
                                          scrollDirection: Axis.horizontal,
                                          itemCount: recommendController
                                              .ratingRecList.length,
                                          itemBuilder:
                                              (BuildContext context, int idx) {
                                            return ratingRecCardWidget(
                                                recommendController
                                                    .ratingRecList[idx]);
                                          }),
                                    )
                                  ],
                                ),
                              ),
                          )
                          : const SizedBox(),
                    ),

                    // 재료 찍고 레시피 추천 받기 버튼
                    Container(
                      width: double.infinity,
                      height: 140,
                      padding: const EdgeInsets.only(
                          top: 20, bottom: 20, left: 20, right: 0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.0),
                        color: Colors.white,
                      ),
                      child: InkWell(
                        onTap: () {
                          Get.toNamed('/recipe');
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '재료 찍고\n레시피 추천 받기',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            Image.asset(
                              'assets/images/main_camera.png',
                              width: 120,
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
                          width: rowWidgetWidth,
                          height: 150,
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
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium),
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

                        //레시피 검색 버튼
                        Container(
                          width: rowWidgetWidth,
                          height: 150,
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
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium),
                                Image.asset(
                                  'assets/images/main_search.png',
                                  height: 70,
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
                          width: rowWidgetWidth,
                          height: 150,
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
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: Image.asset(
                                    'assets/images/main_bookmark.png',
                                    width: 110,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        // 마이페이지 버튼
                        Container(
                          width: rowWidgetWidth,
                          height: 150,
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
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: Image.asset(
                                    'assets/images/main_user.png',
                                    height: 85,
                                  ),
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
            );
          }),
    );
  }

  InkWell ratingRecCardWidget(RecipeResponse recipeResponse) {
    return InkWell(
      onTap: () {
        Get.toNamed('/recipe_detail', arguments: recipeResponse.recipeId);
      },
      child: Container(
        margin: const EdgeInsets.only(right: 15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25.0),
            border: Border.all(
              color: lightColorScheme.primary,
              width: 2,
            ),
            color: Colors.white),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 15.0, left: 15, right: 15, bottom: 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25.0),
                child: Image.network(
                  '${recipeResponse.thumbnail}',
                  fit: BoxFit.fill,
                  height: 80,
                  width: 80,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Container(
                constraints: const BoxConstraints(
                  maxWidth: 100,
                ),
                child: Text(
                  '${recipeResponse.name}',
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
