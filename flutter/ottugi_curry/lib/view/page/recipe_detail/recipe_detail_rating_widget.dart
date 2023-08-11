import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ottugi_curry/config/color_schemes.dart';
import 'package:ottugi_curry/view/controller/recommend/recommend_controller.dart';

class RecipeDetailRatingWidget extends StatelessWidget {
  final int recipeId;

  const RecipeDetailRatingWidget({Key? key, required this.recipeId})
      : super(key: key);

  Future _initUserRating() async {
    print('print recipeId: ${recipeId}');
    Get.put(RecommendController());
    final recommendController = Get.find<RecommendController>();
    await recommendController.loadUserRating(recipeId: recipeId);
    recommendController.rating.value = recommendController.ratingResponse.value.rating!; // 저장된 평점 받아와서 초기화
    recommendController.previousRating.value = 0.0; // 초기화
  }

  @override
  Widget build(BuildContext context) {
    Get.put(RecommendController());
    final recommendController = Get.find<RecommendController>();

    return Container(
      width: 300,
      height: 350,
      padding: const EdgeInsets.only(bottom: 50, left: 10, right: 10, top: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
          border: Border.all(
            color: lightColorScheme.primary,
            width: 5,
          ),
          color: Colors.white),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                iconSize: 23,
                icon: const Icon(Icons.arrow_back_ios),
                color: Colors.black,
                onPressed: () {
                  Get.back();
                },
              ),
              Text('평점', style: Theme.of(context).textTheme.bodyLarge,),
              const Padding(padding: EdgeInsets.only(left: 50)),
            ],
          ),
          // const Padding(padding: EdgeInsets.only(bottom: 50)),

          FutureBuilder(
              future: _initUserRating(),
              builder: (context, snap) {
                if (snap.connectionState != ConnectionState.done) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
                        .map((e) => ratingStarIconWidget(index: e))
                        .toList(),
                  ),
                );
              }),
          // 버튼
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: const Text('취소')),
              const Padding(padding: EdgeInsets.only(right: 20)),
              ElevatedButton(
                  onPressed: () async {
                    // AdditionalProp additionalProp = AdditionalProp(
                    //   additionalProp: 4.0
                    // );
                    Map additionalProp = {
                      '$recipeId' : recommendController.rating.value
                    };
                    bool isUpdated = await recommendController.updateUserRating(additionalPropMap: additionalProp);
                    if (isUpdated) Get.back(); // 업데이트 성공 시 닫기
                  },
                  child: const Text('완료')),
            ],
          )
        ],
      ),
    );
  }

  Widget ratingStarIconWidget({required int index}) {
    Get.put(RecommendController());
    final recommendController = Get.find<RecommendController>();

    return InkWell(
      onTap: () {
        print('print recommendControllerPreviousRatingValue: ${recommendController.previousRating.value}');
        print('print recommendControllerRatingValue: ${recommendController.rating.value}');
        // 평점 초기화(0점): 이전 선택된 평점 다시 선택 했을 때
        if (recommendController.previousRating.value == recommendController.rating.value && recommendController.previousRating.value != 0.0) {
          recommendController.rating.value = 0.0;
        } else { // 평점 변화
          recommendController.rating.value = index / 2;
          recommendController.previousRating.value = index / 2;
        }
      },
      child: Obx(
        ()=> Image.asset(
          'assets/icons/${index % 2 == 0 ? 'half_star_right' : 'half_star_left'}.png',
          width: 23,
          fit: BoxFit.fitWidth,
          color: (index / 2) <= (recommendController.rating.value)
              ? lightColorScheme.primary
              : Colors.grey,
        ),
      ),
    );
  }
}
