import 'package:flutter/material.dart';
import 'package:ottugi_curry/config/color_schemes.dart';
import 'package:ottugi_curry/view/controller/recipe_detail/recipe_detail_timer_controller.dart';
import 'package:ottugi_curry/view/page/recipe_detail/recipe_detail_cooking_order_widget.dart';
import 'package:get/get.dart';
import 'package:ottugi_curry/view/page/recipe_detail/recipe_detail_timer_widget.dart';

class RecipeDetailPage extends StatelessWidget {
  const RecipeDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(RecipeDetailTimerController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: Padding(
          padding: EdgeInsets.only(left: 25),
          child: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () {
              Get.back();
            },
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 25),
            child: CircleAvatar(
              backgroundColor: lightColorScheme.primary,
              child: IconButton(
                icon: const Icon(Icons.timer_sharp),
                color: Colors.black,
                onPressed: () {
                  Get.dialog(const Dialog(
                    child: RecipeDetailTimerWidget(),
                  ));
                },
              ),
            ),
          ),
        ],
      ),
      extendBodyBehindAppBar: true, //body 위에 appBar
      body: DefaultTabController(
        initialIndex: 0,
        length: 2,
        child: Column(
          children: [
            // 레시피 사진
            Image.asset(
              'assets/images/eggroll.png',
              fit: BoxFit.fitWidth,
              height: 238,
              width: 390,
            ),

            //레시피 제목
            Container(
              padding: const EdgeInsets.only(top: 10, bottom: 15),
              decoration: BoxDecoration(
                color: lightColorScheme.primary,
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(25.0),
                    bottomRight: Radius.circular(25.0)),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(
                        height: 50,
                        width: 50,
                      ),
                      //iconButton과 동일한 크기 지정하기 위함
                      Center(
                        child: Text(
                          '치즈 계란말이',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.bookmark,
                            color: lightColorScheme.secondary,
                          ))
                    ],
                  ),
                  const Padding(
                      padding: EdgeInsets.only(
                    top: 10,
                  )),

                  //(레시피 제목) 요리 옵션
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // 시간
                      const Icon(
                        Icons.alarm,
                        size: 15,
                      ),
                      Text(
                        ' 10분  |  ',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),

                      // 난이도
                      const ImageIcon(
                        AssetImage('assets/icons/chef.png'),
                        size: 15,
                      ),
                      Text(
                        ' 초급  |  ',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),

                      // 구성
                      const ImageIcon(
                        AssetImage('assets/icons/meal.png'),
                        size: 15,
                      ),
                      Text(
                        ' 가볍게',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // 재료 정보, 조리 순서 tabBar
            Padding(
              padding: const EdgeInsets.only(
                  left: 20, right: 20, top: 27, bottom: 10),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.0),
                  color: Colors.white,
                ),
                child: TabBar(
                  labelColor: lightColorScheme.onPrimary,
                  labelPadding: const EdgeInsets.only(top: 5, bottom: 5),
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.0),
                    color: lightColorScheme.primary,
                  ),
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorPadding: const EdgeInsets.only(
                      left: 10, right: 10, top: 3, bottom: 3),
                  dividerColor: Colors.transparent,
                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                  tabs: const <Widget>[
                    Tab(
                      text: '재료 정보',
                      height: 30,
                    ),
                    Tab(
                      text: '조리 순서',
                      height: 30,
                    )
                  ],
                ),
              ),
            ),

            // 재료 정보, 조리 순서 tabView
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: TabBarView(
                  children: [
                    // 재료 정보
                    Container(
                      padding: const EdgeInsets.only(
                          top: 15, bottom: 15, left: 10, right: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.0),
                        color: Colors.white,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // 재료
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Text(
                              '재료',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ),
                          ingredientListWidget('계란', '4개'),
                          ingredientListWidget('양파', '1/2개'),
                          ingredientListWidget('당근', '1/4개'),
                          ingredientListWidget('쪽파', '약간'),
                          ingredientListWidget('피자치즈', '두 주먹'),

                          const Padding(padding: EdgeInsets.only(top: 20)),
                          // 양념
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Text(
                              '양념',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ),
                          ingredientListWidget('다진마늘', '1/2큰술'),
                          ingredientListWidget('소금', '1꼬집'),
                          ingredientListWidget('설탕', '1/2큰술'),
                        ],
                      ),
                    ),

                    // 조리 순서
                    Container(
                      padding: const EdgeInsets.only(
                          top: 5, bottom: 15, left: 10, right: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.0),
                        color: Colors.white,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // 조리 순서 보기 방식 아이콘
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: const ImageIcon(
                                  AssetImage('assets/icons/speaker.png'),
                                  color: Colors.grey,
                                  size: 20,
                                ),
                              ),
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.photo,
                                    color: Colors.black,
                                  )),
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.list,
                                    color: Colors.grey,
                                  ))
                            ],
                          ),
                          // 조리 순서 보여주는 수평 방향 tab widget
                          RecipeDetailCookingOrderWidget(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Padding(padding: EdgeInsets.only(bottom: 30)),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: const Color(0xFF8BC6B8),
        foregroundColor: Colors.white,
        shape: const CircleBorder(),
        child: const Icon(Icons.chat),
      ),
    );
  }

  // 재료 정보의 재료 이름/양 row list
  Row ingredientListWidget(String ingredientName, String ingredientAmount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(ingredientName),
        Text(ingredientAmount),
      ],
    );
  }
}
