import 'package:flutter/material.dart';
import 'package:ottugi_curry/config/color_schemes.dart';
import 'package:ottugi_curry/config/config.dart';
import 'package:ottugi_curry/view/controller/recipe_detail/recipe_detail_controller.dart';
import 'package:ottugi_curry/view/controller/recipe_detail/recipe_detail_timer_controller.dart';
import 'package:ottugi_curry/view/page/recipe_detail/recipe_detail_gallery_view_widget.dart';
import 'package:get/get.dart';
import 'package:ottugi_curry/view/page/recipe_detail/recipe_detail_timer_widget.dart';

class RecipeDetailPage extends StatelessWidget {
  const RecipeDetailPage({Key? key}) : super(key: key);

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
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0.0,
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
              actions: [
                Container(
                  margin: const EdgeInsets.only(right: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.0),
                    color: lightColorScheme.primary,
                  ),
                  child: Obx(
                    () => Row(children: [
                      timerController.isRunning.value == true // 앱바 위의 타이머 위젯
                          ? Padding(
                              padding:
                                  const EdgeInsets.only(right: 7, left: 15),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 25,
                                    child: TextField(
                                      controller: timerController
                                          .minuteTextEditingController,
                                      decoration: const InputDecoration(
                                          isDense: true,
                                          border: InputBorder.none),
                                      enabled: true,
                                      readOnly: true,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium,
                                    ),
                                  ),
                                  Text(
                                    ': ',
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                  SizedBox(
                                    width: 25,
                                    child: TextField(
                                      controller: timerController
                                          .secondTextEditingController,
                                      decoration: const InputDecoration(
                                          isDense: true,
                                          border: InputBorder.none),
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
                                      borderRadius: BorderRadius.circular(25.0),
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
                        decoration:
                            BoxDecoration(shape: BoxShape.circle, boxShadow: [
                          BoxShadow(
                              blurRadius: 3,
                              color: Colors.black.withOpacity(0.2),
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
            extendBodyBehindAppBar: true, //body 위에 appBar

            body: DefaultTabController(
              initialIndex: 0,
              length: 2,
              child: Column(
                children: [
                  // const SizedBox(
                  //   height: 60,
                  // ),
                  // 레시피 사진
                  recipeDetailController.thumbnail.value.isNotEmpty
                      ? Image.network(
                          '${recipeDetailController.thumbnail}',
                          fit: BoxFit.fill,
                          height: 238,
                          width: 390,
                        )
                      : Image.asset('assets/images/defaultImage3.png'),

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
                                recipeDetailController.name.value,
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  recipeDetailController.updateBookmark(
                                      1, recipeDetailController.id.value);
                                },
                                icon: Obx(() => Icon(
                                      Icons.bookmark,
                                      color: recipeDetailController
                                                  .isBookmark.value ==
                                              true
                                          ? lightColorScheme.secondary
                                          : Colors.grey,
                                    )))
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
                              style: Theme.of(context).textTheme.bodySmall,
                            ),

                            // 난이도
                            const ImageIcon(
                              AssetImage('assets/icons/chef.png'),
                              size: 15,
                            ),
                            Text(
                              ' ${recipeDetailController.difficulty.value}  |  ',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),

                            // 구성
                            const ImageIcon(
                              AssetImage('assets/icons/meal.png'),
                              size: 15,
                            ),
                            Text(
                              ' ${recipeDetailController.composition.value}',
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
                        overlayColor:
                            MaterialStateProperty.all(Colors.transparent),
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

                  // 재료 정보, 조리 순서 tabView
                  ingredientsAndOrdersTabView(),

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
        });
  }

  Expanded ingredientsAndOrdersTabView() {
    Get.put(RecipeDetailController());
    final recipeDetailController = Get.find<RecipeDetailController>();

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: TabBarView(
          children: [
            // 재료 정보
            Container(
              padding: const EdgeInsets.only(
                  top: 15, bottom: 15, left: 15, right: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25.0),
                color: Colors.white,
              ),
              child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                          // 재료
                          const Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: Text(
                              '재료',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ] +
                        recipeDetailController.ingredients
                            .map((element) => Text(element))
                            .toList() +
                        [

                          const Padding(padding: EdgeInsets.only(top: 20)),
                          // 양념
                          const Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: Text(
                              '양념',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ] +
                        recipeDetailController.seasoning
                            .map((element) => Text(element))
                            .toList()),
              ),
            ),

            // 조리 순서
            Container(
              padding:
                  const EdgeInsets.only(top: 0, bottom: 0, left: 15, right: 15),
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
                            recipeDetailController
                                .orderViewOption(Config.soundView);
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
                              color: recipeDetailController
                                          .orderViewOption.value ==
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
                              color: recipeDetailController
                                          .orderViewOption.value ==
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
            ),
          ],
        ),
      ),
    );
  }

  SizedBox recipeDetailTextListViewWidget() {
    Get.put(RecipeDetailController());
    final recipeDetailController = Get.find<RecipeDetailController>();

    return SizedBox(
      height: 340,
      child: ListView.builder(
          padding: const EdgeInsets.only(top: 10, bottom: 0),
          shrinkWrap: true,
          itemCount: recipeDetailController.orders.length,
          itemBuilder: (BuildContext context, int idx) {
            return Padding(
                padding: const EdgeInsets.only(bottom: 3),
                child: Text(recipeDetailController.orders[idx]));
          }),
    );
  }
}
