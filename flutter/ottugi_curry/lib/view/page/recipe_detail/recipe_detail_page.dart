import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ottugi_curry/config/color_schemes.dart';
import 'package:ottugi_curry/config/config.dart';
import 'package:ottugi_curry/utils/screen_size_utils.dart';
import 'package:ottugi_curry/utils/user_profile_utils.dart';
import 'package:ottugi_curry/view/controller/recipe_detail/recipe_detail_controller.dart';
import 'package:ottugi_curry/view/controller/recipe_detail/recipe_detail_timer_controller.dart';
import 'package:ottugi_curry/view/page/chat/chat_page.dart';
import 'package:ottugi_curry/view/page/recipe_detail/recipe_detail_gallery_view_widget.dart';
import 'package:get/get.dart';
import 'package:ottugi_curry/view/page/recipe_detail/recipe_detail_rating_widget.dart';
import 'package:ottugi_curry/view/page/recipe_detail/recipe_detail_text_list_view_widget.dart';
import 'package:ottugi_curry/view/page/recipe_detail/recipe_detail_timer_widget.dart';

class RecipeDetailPage extends StatelessWidget {
  const RecipeDetailPage({Key? key}) : super(key: key);

  Future<void> _initRecipeDetail() async {
    print('print Get.arguments: ${Get.arguments}');
    Get.put(RecipeDetailTimerController());
    Get.put(RecipeDetailController());
    final recipeDetailController = Get.find<RecipeDetailController>();

    await recipeDetailController.loadRecipeDetail(Get.arguments);
    Get.find<RecipeDetailTimerController>().loadTimerAlarm();

    // tts 상태 초기화
    recipeDetailController.ttsStatus.value = Config.stopped;
    // 이전 페이지 루트 저장
    recipeDetailController.previousRoute.value = Get.previousRoute;
  }

  @override
  Widget build(BuildContext context) {
    Get.put(RecipeDetailTimerController());
    final timerController = Get.find<RecipeDetailTimerController>();
    Get.put(RecipeDetailController());
    final recipeDetailController = Get.find<RecipeDetailController>();

    return Scaffold(
      body: FutureBuilder(
          future: _initRecipeDetail(),
          builder: (context, snap) {
            if (snap.connectionState != ConnectionState.done) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return Scaffold(
              extendBodyBehindAppBar: true,
              body: DefaultTabController(
                  length: 2,
                  child: NestedScrollView(
                    headerSliverBuilder: (context, innerBoxIsScrolled) {
                      // 레시피 이미지, 제목, 옵션 / 탭바
                      return <Widget>[
                        SliverOverlapAbsorber(
                          handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                              context),
                          sliver: SliverAppBar(
                            backgroundColor: Colors.transparent,
                            elevation: 0.0,
                            pinned: true,
                            floating: false,
                            snap: false,
                            forceElevated: innerBoxIsScrolled,

                            // 앱바 좌측 - 뒤로가기 버튼
                            leading: Padding(
                              padding: const EdgeInsets.only(left: 25),
                              child: IconButton(
                                onPressed: () {
                                  recipeDetailController.tts.value.stop();

                                  // 이전 페이지가 재실행되는 효과 = 페이지 재로딩 (FutureBuilder 실행)
                                  // 평점이 변경되면, 변경된 추천 레시피를 바로 받아오기 위함
                                  print(
                                      'print recipeDetailControllerPreviousRouteValue: ${recipeDetailController.previousRoute.value}');
                                  Get.offAndToNamed(
                                      recipeDetailController.previousRoute.value);
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
                                                  timerController
                                                      .stopTimerAlarm();
                                                },
                                                child: Container(
                                                  padding: const EdgeInsets.only(
                                                      left: 15, right: 10),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            25.0),
                                                    color:
                                                        lightColorScheme.primary,
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
                        ),

                        // 레시피 정보들
                        SliverToBoxAdapter(
                          child: Column(
                            children: [
                              // 레시피 사진
                              recipeDetailController
                                          .recipeResponse.value.thumbnail !=
                                      null
                                  ? Image.network(
                                      '${recipeDetailController.recipeResponse.value.thumbnail}',
                                      fit: BoxFit.fill,
                                      height: isWidthMobile(context) == true
                                          ? 238
                                          : 400,
                                      width: double.infinity,
                                    )
                                  : Image.asset(
                                      'assets/images/defaultImage3.png'),

                              // 레시피 제목
                              Container(
                                padding: const EdgeInsets.only(
                                    top: 10, bottom: 15, left: 10, right: 5),
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
                                        IconButton(
                                          onPressed: () {
                                            Get.dialog(Dialog(
                                              child: RecipeDetailRatingWidget(
                                                recipeId: recipeDetailController
                                                    .recipeResponse
                                                    .value
                                                    .recipeId!,
                                              ),
                                            ));
                                          },
                                          icon: Icon(
                                            Icons.stars,
                                            color: lightColorScheme.secondary,
                                            size: 27,
                                          ),
                                        ),
                                        Center(
                                          child: Text(
                                            recipeDetailController
                                                    .recipeResponse.value.name ??
                                                '',
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleLarge,
                                          ),
                                        ),
                                        IconButton(
                                            onPressed: () {
                                              recipeDetailController
                                                  .updateBookmark(
                                                      getUserId(),
                                                      recipeDetailController
                                                          .recipeResponse
                                                          .value
                                                          .recipeId!);
                                            },
                                            icon: Obx(
                                              () => Icon(
                                                Icons.bookmark,
                                                color: recipeDetailController
                                                            .recipeResponse
                                                            .value
                                                            .isBookmark ==
                                                        true
                                                    ? lightColorScheme.secondary
                                                    : Colors.grey.shade300,
                                              ),
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
                                          ' ${recipeDetailController.recipeResponse.value.time}  |  ',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall,
                                        ),

                                        // 난이도
                                        const ImageIcon(
                                          AssetImage('assets/icons/chef2.png'),
                                          size: 14,
                                        ),
                                        Text(
                                          ' ${recipeDetailController.recipeResponse.value.difficulty}  |  ',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall,
                                        ),

                                        // 구성
                                        const ImageIcon(
                                          AssetImage('assets/icons/meal.png'),
                                          size: 19,
                                        ),
                                        Text(
                                          ' ${recipeDetailController.recipeResponse.value.composition}',
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
                onPressed: () {
                  // Get.to(() => const ChatPage());
                  /*showDialog(
                      context: context,
                      barrierDismissible: true, // 바깥 영역 터치시 닫을지 여부
                      builder: (BuildContext context) {
                        return AlertDialog(
                          content: const ChatPage(),
                          actions: [
                            TextButton(
                              child: const Text('확인'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      });?*/
                  showGeneralDialog(
                      context: context,
                      barrierDismissible: true,
                      barrierLabel: MaterialLocalizations.of(context)
                          .modalBarrierDismissLabel,
                      barrierColor: Colors.black.withOpacity(0.5),
                      transitionDuration: const Duration(milliseconds: 200),
                      pageBuilder: (BuildContext buildContext,
                          Animation animation, Animation secondaryAnimation) {
                        return const ChatPage();
                      });
                },
                backgroundColor: const Color(0xFF8BC6B8),
                foregroundColor: Colors.white,
                shape: const CircleBorder(),
                child: const Icon(Icons.chat),
              ),
            );
          }),
    );
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
                  Row(
                    children: [
                      ImageIcon(
                        const AssetImage('assets/icons/fork2.png'),
                        size: 17,
                        color: lightColorScheme.primary,
                      ),
                      const Padding(padding: EdgeInsets.only(right: 5)),
                      Container(
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: lightColorScheme.primary,
                                    width: 1.0))),
                        child: Text(
                          '${recipeDetailController.recipeResponse.value.servings.toString()} 기준',
                          style: const TextStyle(fontSize: 15),
                        ),
                      ),
                    ],
                  ),
                  const Padding(padding: EdgeInsets.only(bottom: 20)),
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // TTS 관련 버튼
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // 스피커
                    IconButton(
                      onPressed: () async {
                        if (recipeDetailController.ttsStatus.value ==
                            Config.playing) {
                          // 실행-> 정지
                          recipeDetailController.stopTTS();
                        } else {
                          // 정지 -> 실행
                          recipeDetailController.speakTTS();
                        }
                      },
                      icon: const ImageIcon(
                        AssetImage('assets/icons/speaker.png'),
                        size: 20,
                      ),
                      color: recipeDetailController.ttsStatus.value !=
                              Config.stopped
                          ? lightColorScheme.primary
                          : Colors.grey,
                    ),

                    // 일시 정지는 iOS에서만 지원 (안드로이드 제대로 지원 안돼서 제외함)
                   Platform.isIOS == true && recipeDetailController.ttsStatus.value !=
                              Config.stopped
                          ? Container(
                              height: 37,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: lightColorScheme.primary,
                                ),
                                borderRadius: BorderRadius.circular(25.0),
                                // color: Colors.grey.shade200,
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  // 시작, 일시정지 버튼
                                  IconButton(
                                    iconSize: 23,
                                    onPressed: () async {
                                      if (recipeDetailController
                                              .ttsStatus.value ==
                                          Config.playing) {
                                        // 실행-> 일시정지
                                        recipeDetailController.pauseTTS();
                                        print(
                                            'print recipeDetailControllerTtsStatus: ${recipeDetailController.ttsStatus}');
                                      } else {
                                        // 일시 정지 -> 실행
                                        recipeDetailController.speakTTS();
                                      }
                                    },
                                    icon: recipeDetailController
                                                .ttsStatus.value ==
                                            Config.playing
                                        ? const Icon(Icons.pause)
                                        : const Icon(Icons.play_arrow),
                                    color: Colors.black,
                                  ),
                                  // 정지 버튼
                                  IconButton(
                                    iconSize: 23,
                                    onPressed: () async {
                                      // 일시정지, 실행 -> 정지
                                      recipeDetailController.stopTTS();
                                    },
                                    icon: const Icon(Icons.stop),
                                    color: Colors.black,
                                  ),
                                ],
                              ),
                            )
                          : const SizedBox(),
                  ],
                ),

                // 갤러리 뷰
                Row(
                  children: [
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
                // 텍스트 뷰
              ],
            ),

            // 조리 순서 보여주는 탭
            if (recipeDetailController.orderViewOption.value ==
                Config.textListView) ...[
              const RecipeDetailTextListViewWidget()
            ] else ...[
              const RecipeDetailGalleryViewWidget(),
            ],
          ],
        ),
      ),
    );
  }
}
