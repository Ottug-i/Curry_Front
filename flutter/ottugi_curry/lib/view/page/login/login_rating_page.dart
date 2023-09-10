import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ottugi_curry/config/color_schemes.dart';
import 'package:ottugi_curry/model/recipe_response.dart';
import 'package:ottugi_curry/utils/long_string_to_list_utils.dart';
import 'package:ottugi_curry/view/controller/login/login_rating_controller.dart';
import 'package:ottugi_curry/view/controller/recommend/recommend_controller.dart';

class LoginRatingPage extends StatelessWidget {
  const LoginRatingPage({Key? key}) : super(key: key);

  Future _initRandomRating() async {
    Get.put(LoginRatingController());
    final loginRatingController = Get.find<LoginRatingController>();
    await loginRatingController.loadRandomRating();

    // 평점 정보 저장하는 리스트 초기화
    loginRatingController.rating.clear();

    List<double> initRating = [ 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0 ];
    loginRatingController.rating.value = initRating;
  }

  @override
  Widget build(BuildContext context) {
    Get.put(LoginRatingController());
    final loginRatingController = Get.find<LoginRatingController>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: lightColorScheme.background,
        title: Text(
          '기본 평점 매기기',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
      body: FutureBuilder(
          future: _initRandomRating(),
          builder: (context, snap) {
            if (snap.connectionState != ConnectionState.done) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                child: Column(
                  children: [
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Text(
                        '하위 10개 레시피에 대한 평점을 매겨주세요.',
                      ),
                    ),
                    loginRatingController.randomRatingList.isNotEmpty
                        ? ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount:
                                loginRatingController.randomRatingList.length,
                            itemBuilder: (BuildContext context, int i) {
                              return randomRatingListItemWidget(
                                recipeResponse:
                                    loginRatingController.randomRatingList[i],
                                index: i,
                                controller: loginRatingController,
                                context: context,
                              );
                            })
                        : const Center(
                            child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            child: Text('레시피가 없습니다.'),
                          )),
                    Obx(() => loginRatingController.isEmptyRating.value == true
                        ? const Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: Text(
                              '모든 레시피에 대한 평점을 매겨주세요.',
                              style: TextStyle(color: Colors.red, fontSize: 15),
                            ),
                        )
                        : const SizedBox()),
                    const Padding(padding: EdgeInsets.only(bottom: 10)),
                    ElevatedButton(
                        onPressed: () async {
                          if (loginRatingController.rating.contains(0.0)) {
                            // 평점을 매기지 않은 경우 경고문 보여주기
                            loginRatingController.isEmptyRating.value = true;
                            return;
                          } else {
                            // 추가할 레시피 평점 맵 변수 저장
                            Map additionalProp = {};
                            for (int i = 0; i < 10; i++) {
                              additionalProp.addAll({
                                loginRatingController
                                    .randomRatingList[i].recipeId
                                    .toString(): loginRatingController.rating[i]
                              });
                            }
                            print('print additionalProp: ${additionalProp}');
                            Get.put(RecommendController());
                            bool isUpdated =
                                await Get.find<RecommendController>()
                                    .updateRating(
                                        additionalPropMap: additionalProp);
                            if (isUpdated) {
                              // 업데이트 성공 시 메인으로
                              Get.offAndToNamed('/main');
                            }
                          }
                        },
                        child: const Text('완료')),
                  ],
                ),
              ),
            );
          }),
    );
  }

  Container randomRatingListItemWidget(
      {required RecipeResponse recipeResponse,
      required int index,
      controller,
      context}) {
    return Container(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.only(
          top: 16,
        ),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(24)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 15, top: 25),
              child: Text(
                '${index + 1}',
                style: Theme.of(context).textTheme.titleMedium,
              ),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 첫 번째 줄 (메뉴 이름, 북마크 아이콘)
                    Text(
                      '${recipeResponse.name}',
                      style: Theme.of(context).textTheme.titleMedium,
                      overflow: TextOverflow.ellipsis,
                    ),
                    // 두 번째 줄 (재료 목록)
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0, top: 5),
                      child: Text(
                        extractOnlyContent(recipeResponse.ingredients ?? ''),
                        style: Theme.of(context).textTheme.bodySmall,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    // 세 번째 줄 (평점)
                    Padding(
                        padding: const EdgeInsets.only(right: 7, top: 5),
                        child: ratingStarsRowWidget(index)),
                  ],
                ),
              ),
            ),
          ],
        ));
  }

  Row ratingStarsRowWidget(int listIndex) {
    return Row(mainAxisAlignment: MainAxisAlignment.start, children: [
      for (double i = 0.0; i < 10.0; i++) ...[
        ratingStarIconWidgetSmall(starIndex: i, listIndex: listIndex)
      ],
    ]);
  }

  InkWell ratingStarIconWidgetSmall(
      {required double starIndex, required int listIndex}) {
    Get.put(LoginRatingController());
    final loginRatingController = Get.find<LoginRatingController>();

    return InkWell(
      onTap: () {
        print(
            '----print 이전 평점: ${loginRatingController.rating[listIndex]} -> 지금 선택한 평점 ${(starIndex + 1) / 2}');

        // 평점 초기화(0점): 이전 선택된 평점 다시 선택 했을 때
        if ((loginRatingController.rating[listIndex] != 0.0) &&
            (loginRatingController.rating[listIndex] ==
                ((starIndex + 1) / 2))) {
          print('print 평점 초기화');
          loginRatingController.rating[listIndex] = 0.0;
        } else {
          // 평점 변화
          print('print 평점 변화');
          loginRatingController.rating[listIndex] = ((starIndex + 1) / 2);
        }
        print('print 평점 저장 완료: ${loginRatingController.rating[listIndex]}----');
      },
      child: Obx(
        () => Image.asset(
          'assets/icons/${(starIndex + 1) % 2 == 0 ? 'half_star_right' : 'half_star_left'}.png',
          width: 17,
          fit: BoxFit.fitWidth,
          color:
              ((starIndex + 1) / 2) <= loginRatingController.rating[listIndex]
                  ? lightColorScheme.primary
                  : Colors.grey,
        ),
      ),
    );
  }
}
