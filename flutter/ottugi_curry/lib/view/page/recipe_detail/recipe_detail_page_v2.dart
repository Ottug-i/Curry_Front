import 'package:flutter/material.dart';
import 'package:ottugi_curry/config/color_schemes.dart';
import 'package:ottugi_curry/config/config.dart';
import 'package:ottugi_curry/view/controller/recipe_detail/recipe_detail_controller.dart';
import 'package:ottugi_curry/view/controller/recipe_detail/recipe_detail_timer_controller.dart';
import 'package:ottugi_curry/view/page/recipe_detail/recipe_detail_gallery_view_widget.dart';
import 'package:get/get.dart';
import 'package:ottugi_curry/view/page/recipe_detail/recipe_detail_timer_widget.dart';

import 'recipe_detail_text_list_view_widget.dart';

class RecipeDetailPageV2 extends StatelessWidget {
  const RecipeDetailPageV2({Key? key}) : super(key: key);

  Future<void> _initRecipeDetail() async {
    print('print Get.arguments: ${Get.arguments}');
    await Get.find<RecipeDetailController>().loadRecipeDetail(Get.arguments);
    Get.find<RecipeDetailTimerController>().loadTimerAlarm();
  }

  @override
  Widget build(BuildContext context) {
    Get.put(RecipeDetailTimerController());
    final timerController = Get.find<RecipeDetailTimerController>();
    Get.put(RecipeDetailController());
    final recipeDetailController = Get.find<RecipeDetailController>();

    return FutureBuilder(
        future: _initRecipeDetail(),
        builder: (context, snap) {
          if (snap.connectionState != ConnectionState.done) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return Scaffold(
            body: DefaultTabController(
                length: 2,
                child: NestedScrollView(
                  // floatHeaderSlivers: true,
                  headerSliverBuilder: (context, innerBoxIsScrolled) {
                    // 레시피 이미지, 제목, 옵션 / 탭바
                    return <Widget>[
                      SliverAppBar(
                        backgroundColor: Colors.transparent,
                        elevation: 0.0,
                        // expandedHeight: 360,
                        pinned: true,
                        floating: false,
                        snap: false,
                        // stretch: false,
                        forceElevated: innerBoxIsScrolled,

                        // 앱바 좌측
                        leading: Padding(
                          padding: const EdgeInsets.only(left: 25),
                          child: IconButton(
                            onPressed: () {
                              Get.back();
                            },
                            icon: const Icon(
                              Icons.arrow_back_ios,
                              color: Colors.black,
                            ),
                          ),
                        ),

                        // 앱바 우측 - 타이머
                        actions: [
                          Container(
                            margin: const EdgeInsets.only(right: 15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25.0),
                              color: lightColorScheme.primary,
                            ),
                            child: Obx(
                              () => Row(children: [
                                timerController.isRunning.value ==
                                        true // 앱바 위의 타이머 위젯
                                    ? Padding(
                                        padding: const EdgeInsets.only(
                                            right: 7, left: 15),
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              width: 25,
                                              child: TextField(
                                                controller: timerController
                                                    .minuteTextEditingController,
                                                decoration:
                                                    const InputDecoration(
                                                        isDense: true,
                                                        border:
                                                            InputBorder.none),
                                                enabled: true,
                                                readOnly: true,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleMedium,
                                              ),
                                            ),
                                            Text(
                                              ': ',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium,
                                            ),
                                            SizedBox(
                                              width: 25,
                                              child: TextField(
                                                controller: timerController
                                                    .secondTextEditingController,
                                                decoration:
                                                    const InputDecoration(
                                                        isDense: true,
                                                        border:
                                                            InputBorder.none),
                                                enabled: true,
                                                readOnly: true,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleMedium,
                                              ),
                                            )
                                          ],
                                        ))
                                    : timerController.isRingingAlarm.value ==
                                            true // 알림 종료 버튼 보여주기
                                        ? InkWell(
                                            onTap: () {
                                              timerController.stopTimerAlarm();
                                            },
                                            child: Container(
                                              padding: const EdgeInsets.only(
                                                  left: 15, right: 10),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(25.0),
                                                color: lightColorScheme.primary,
                                              ),
                                              child: Text(
                                                '종료',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleMedium,
                                              ),
                                            ),
                                          )
                                        : const SizedBox(),
                                Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                            blurRadius: 3,
                                            color:
                                                Colors.black.withOpacity(0.2),
                                            spreadRadius: 0,
                                            offset: const Offset(-3, 5))
                                      ]),
                                  child: CircleAvatar(
                                    backgroundColor: lightColorScheme.primary,
                                    child: IconButton(
                                      icon: const Icon(Icons.timer_sharp),
                                      color: Colors.black,
                                      onPressed: () {
                                        // 알림 울리는 중이면 종료
                                        timerController.stopTimerAlarm();
                                        Get.dialog(const Dialog(
                                          child: RecipeDetailTimerWidget(),
                                        ));
                                      },
                                    ),
                                  ),
                                ),
                              ]),
                            ),
                          ),
                          // ),
                        ],
                      ),
                      SliverToBoxAdapter(
                        child: Column(
                          children: [
                            // 레시피 사진
                            recipeDetailController.thumbnail.value.isNotEmpty
                                ? Image.network(
                                    '${recipeDetailController.thumbnail}',
                                    fit: BoxFit.fill,
                                    height: 238,
                                    width: 390,
                                  )
                                : Image.asset(
                                    'assets/images/defaultImage3.png'),

                            // 레시피 제목
                            Container(
                              padding:
                                  const EdgeInsets.only(top: 10, bottom: 15),
                              decoration: BoxDecoration(
                                color: lightColorScheme.primary,
                                borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(25.0),
                                    bottomRight: Radius.circular(25.0)),
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const SizedBox(
                                        height: 50,
                                        width: 50,
                                      ),
                                      //iconButton과 동일한 크기 지정하기 위함
                                      Center(
                                        child: Text(
                                          recipeDetailController.name.value,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge,
                                        ),
                                      ),
                                      IconButton(
                                          onPressed: () {},
                                          icon: Icon(
                                            Icons.bookmark,
                                            color: recipeDetailController
                                                        .isBookmark.value ==
                                                    true
                                                ? lightColorScheme.secondary
                                                : Colors.grey,
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
                                        ' ${recipeDetailController.time.value}  |  ',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall,
                                      ),

                                      // 난이도
                                      const ImageIcon(
                                        AssetImage('assets/icons/chef.png'),
                                        size: 15,
                                      ),
                                      Text(
                                        ' ${recipeDetailController.difficulty.value}  |  ',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall,
                                      ),

                                      // 구성
                                      const ImageIcon(
                                        AssetImage('assets/icons/meal.png'),
                                        size: 15,
                                      ),
                                      Text(
                                        ' ${recipeDetailController.composition.value}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall,
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
                                  labelPadding:
                                      const EdgeInsets.only(top: 5, bottom: 5),
                                  indicator: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25.0),
                                    color: lightColorScheme.primary,
                                  ),
                                  indicatorSize: TabBarIndicatorSize.tab,
                                  indicatorPadding: const EdgeInsets.only(
                                      left: 10, right: 10, top: 3, bottom: 3),
                                  dividerColor: Colors.transparent,
                                  overlayColor: MaterialStateProperty.all(
                                      Colors.transparent),
                                  tabs: const <Widget>[
                                    Tab(
                                      text: '재료 정보',
                                      height: 30,
                                    ),
                                    Tab(
                                      text: '조리 순서',
                                      height: 30,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ];
                  },

                  // 재료 정보, 요리 순서 탭뷰
                  body: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: TabBarView(
                      children: [
                        // 재료 정보 탭뷰
                        ingredientsTabView(),
                        // 조리 순서 탭뷰
                        ordersTabView(),
                      ],
                    ),
                  ),
                )),

            // 챗봇 플로팅 버튼
            floatingActionButton: FloatingActionButton(
              onPressed: () {},
              backgroundColor: const Color(0xFF8BC6B8),
              foregroundColor: Colors.white,
              shape: const CircleBorder(),
              child: const Icon(Icons.chat),
            ),
          );
        });
  }

  // 재료 정보 탭뷰
  Container ingredientsTabView() {
    Get.put(RecipeDetailController());
    final recipeDetailController = Get.find<RecipeDetailController>();

    return Container(
      padding: const EdgeInsets.only(top: 15, bottom: 15, left: 15, right: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.white,
      ),
      child: SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
                  Text(
                    '${recipeDetailController.servings.toString()} 기준',
                    style: const TextStyle(fontSize: 14),
                  ),
                  const Padding(padding: EdgeInsets.only(bottom: 10)),
                ] +
                recipeDetailController.ingredientsTitle.map((element) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                          // 제목 (대괄호)
                          Text(
                            element,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                        ] +
                        // 내용
                        recipeDetailController.ingredientsContentList[
                                recipeDetailController.ingredientsTitle
                                    .indexOf(element)]
                            .map((element) => Text(element))
                            .toList() +
                        [const Padding(padding: EdgeInsets.only(bottom: 20))],
                  );
                }).toList()),
      ),
    );
  }

  // 조리 순서 탭뷰
  Container ordersTabView() {
    Get.put(RecipeDetailController());
    final recipeDetailController = Get.find<RecipeDetailController>();

    return Container(
      padding: const EdgeInsets.only(top: 0, bottom: 0, left: 15, right: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.white,
      ),
      child: Obx(
        () => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 조리 순서 보기 방식 아이콘
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () {
                    recipeDetailController.orderViewOption(Config.soundView);
                  },
                  icon: const ImageIcon(
                    AssetImage('assets/icons/speaker.png'),
                    size: 20,
                  ),
                  color: recipeDetailController.orderViewOption.value ==
                          Config.soundView
                      ? Colors.black
                      : Colors.grey,
                ),
                IconButton(
                    onPressed: () {
                      recipeDetailController
                          .orderViewOption(Config.galleryView);
                    },
                    icon: Icon(
                      Icons.photo,
                      color: recipeDetailController.orderViewOption.value ==
                              Config.galleryView
                          ? Colors.black
                          : Colors.grey,
                    )),
                IconButton(
                    onPressed: () {
                      recipeDetailController
                          .orderViewOption(Config.textListView);
                    },
                    icon: Icon(
                      Icons.list,
                      color: recipeDetailController.orderViewOption.value ==
                              Config.textListView
                          ? Colors.black
                          : Colors.grey,
                    ))
              ],
            ),

            if (recipeDetailController.orderViewOption.value ==
                Config.soundView) ...[
              const Text('Sound')
              // (추후) 화면은 갤러리 뷰에 + 음성 나오게 설정
            ] else if (recipeDetailController.orderViewOption.value ==
                Config.textListView) ...[
              recipeDetailTextListViewWidget()
            ] else ...[
              const RecipeDetailGalleryViewWidget(),
            ],

            // 조리 순서 보여주는 수평 방향 tab widget
          ],
        ),
      ),
    );
  }
}
