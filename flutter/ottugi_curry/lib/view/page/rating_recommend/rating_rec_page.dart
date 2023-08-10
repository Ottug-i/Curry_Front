import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ottugi_curry/config/color_schemes.dart';
import 'package:ottugi_curry/model/recipe_response.dart';
import 'package:ottugi_curry/utils/long_string_to_list_utils.dart';
import 'package:ottugi_curry/utils/user_profile_utils.dart';
import 'package:ottugi_curry/view/comm/default_layout_widget.dart';
import 'package:ottugi_curry/view/controller/recommend/recommend_controller.dart';

class RatingRecPage extends StatelessWidget {
  const RatingRecPage({Key? key}) : super(key: key);

  Future _initRatingRec() async {
    Get.put(RecommendController());
    await Get.find<RecommendController>().getBookmarkList(1);
  }

  @override
  Widget build(BuildContext context) {
    Get.put(RecommendController());
    final recommendController = Get.find<RecommendController>();

    return DefaultLayoutWidget(
        appBarTitle: '추천 레시피',
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
                children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Text('${getUserNickname()} 님의 레시피 평점과 선호 장르를 분석하여 추천하는 레시피 입니다. ', // 멘트 수정하기
                      style: TextStyle(fontSize: 13, color: Colors.grey.shade700)),
                    ),
                    recommendController.ratingRecList.isNotEmpty
                        ? Obx(
                            () => ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount:
                                    recommendController.ratingRecList.length,
                                itemBuilder: (BuildContext context, int i) {
                                  return ratingRecListItemWidget(
                                      recipeResponse: recommendController.ratingRecList[i],
                                    index: i,
                                    controller: recommendController,
                                    context: context,
                                  );
                                }),
                          )
                        : const Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                          child: Text('추천 레시피가 없습니다.'),
                        ))
                ],
              ),
                  ));
            }));
  }

  Widget ratingRecListItemWidget({required RecipeResponse recipeResponse, required int index, controller, context}) {
    return GestureDetector(
      onTap: () {
        Get.toNamed('/recipe_detail',
            arguments: recipeResponse.recipeId);
      },
      child: Container(
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.symmetric(vertical: 8,),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(24)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 15, top: 25),
                child: Text('${index+1}',
                  style: Theme.of(context).textTheme.titleMedium,),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(24.0),
                child: Image.network(
                  '${recipeResponse.thumbnail}',
                  fit: BoxFit.fill,
                  height: 80,
                  width: 80,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // 첫 번째 줄 (메뉴 이름, 북마크 아이콘)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // 음식 이름
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${recipeResponse.name}',
                                  style:
                                  Theme.of(context).textTheme.titleMedium,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                          // 북마크 아이콘
                          IconButton(
                            icon: Icon(recipeResponse.isBookmark!
                                ? Icons.bookmark_rounded
                                : Icons.bookmark_border_rounded),
                            iconSize: 30,
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            color: lightColorScheme.primary,
                            onPressed: () {
                              // 공통 위젯을 위한 컨트롤러 변수 사용
                              controller.updateBookmark(
                                  1, recipeResponse.recipeId
                              );
                            },
                          )
                        ],
                      ),
                      // 두 번째 줄 (재료 목록)
                      Row(
                          children: [
                        Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Text(
                                extractOnlyContent(recipeResponse.ingredients ?? ''),
                                style: Theme.of(context).textTheme.bodySmall,
                                overflow: TextOverflow.ellipsis,
                              ),
                            )),
                      ]),
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
