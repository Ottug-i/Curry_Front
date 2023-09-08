import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:ottugi_curry/config/color_schemes.dart';
import 'package:ottugi_curry/view/comm/default_layout_widget.dart';
import 'package:ottugi_curry/view/controller/list/recipe_list_controller.dart';
import 'package:ottugi_curry/view/controller/recipe_camera/camera_page_controller.dart';
import 'package:ottugi_curry/view/page/recipe_camera/ShakeAnimation.dart';

class ResultCheckPage extends StatefulWidget {
  const ResultCheckPage({super.key});

  @override
  State<ResultCheckPage> createState() => _ResultCheckPageState();
}

class _ResultCheckPageState extends State<ResultCheckPage> {
  // 인식 결과로 받아온 변수
  // var ingredient = ["달걀", "베이컨", "감자", "치즈"];
  //var imagePath = Get.arguments;

  final RecipeListController rListController = Get.put(RecipeListController());
  CameraPageController cameraPageController = Get.find<CameraPageController>();

  // dialog 변수들
  final GlobalKey dataKey = GlobalKey(); // 스크롤 포커싱을 위한 변수
  bool isTextFieldError = false;
  final textFieldErrorShakeKey = GlobalKey<ShakeAnimationState>();
  final textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    initIngredients();
  }

  void initIngredients() async {
    // 감지 결과 반환
    List<String> ingredient = await cameraPageController.detectImage();
    // 인식 결과로 받아온 변수를 controller에 저장
    rListController.setIngredientList(ingredient);
  }

  @override
  Widget build(BuildContext context) {
    final Size screen = MediaQuery.of(context).size;

    return DefaultLayoutWidget(
      backToMain: true,
      appBarTitle: '촬영 결과 확인',
      body: Obx(
        () => Stack(fit: StackFit.expand, children: [
          Column(
            children: [
              Expanded(
                flex: 5,
                child: Image.file(cameraPageController.imageFile.value,
                    fit: BoxFit.fitHeight),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return Dialog(
                            insetPadding: const EdgeInsets.all(40),
                            backgroundColor: Colors.white,
                            child: SingleChildScrollView(
                              physics: const ClampingScrollPhysics(),
                              child: Stack(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(20),
                                    child: Obx(
                                      () => Column(
                                        children: [
                                          Text('촬영한 재료가 아니라면 선택을 해제하세요.',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium),
                                          Text('추가로 입력한 재료를 삭제하려면 길게 누르세요.',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Column(
                                              children: rListController
                                                  .ingredientList
                                                  .map((favorite) {
                                            return GestureDetector(
                                              onLongPress: () {
                                                if (favorite["ableToDelete"]) {
                                                  HapticFeedback.vibrate();
                                                  rListController
                                                      .deleteIngredient(
                                                          favorite["name"]);
                                                }
                                              },
                                              child: CheckboxListTile(
                                                  activeColor:
                                                      lightColorScheme.primary,
                                                  checkboxShape:
                                                      RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5)),
                                                  value: favorite["isChecked"],
                                                  title: Text(favorite["name"],
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .titleMedium),
                                                  onChanged: (val) {
                                                    if (val == true) {
                                                      if (rListController
                                                              .currentSelected <
                                                          rListController
                                                              .maxSelected) {
                                                        favorite["isChecked"] =
                                                            true;
                                                        rListController
                                                            .currentSelected += 1;
                                                      } else {
                                                        Get.showSnackbar(
                                                          const GetSnackBar(
                                                            title: '갯수 초과',
                                                            message:
                                                                '최대 5개의 재료를 선택할 수 있습니다.',
                                                            icon: Icon(
                                                              Icons.check_box,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                            backgroundColor:
                                                                Colors.orange,
                                                            duration: Duration(
                                                                seconds: 3),
                                                          ),
                                                        );
                                                      }
                                                    } else {
                                                      favorite["isChecked"] =
                                                          false;
                                                      rListController
                                                          .currentSelected -= 1;
                                                    }
                                                  }),
                                            );
                                          }).toList()),
                                          if (!rListController.isFull())
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Flexible(
                                                  key: dataKey,
                                                  child: ShakeAnimation(
                                                    key: textFieldErrorShakeKey,
                                                    shakeCount: 3,
                                                    shakeOffset: 10,
                                                    child: TextField(
                                                        onChanged: (text) {
                                                          setState(() {
                                                            isTextFieldError =
                                                                (text.isEmpty);
                                                          });
                                                        },
                                                        keyboardType:
                                                            TextInputType.text,
                                                        inputFormatters: <TextInputFormatter>[
                                                          FilteringTextInputFormatter
                                                              .allow(RegExp(
                                                                  r'[ㄱ-ㅎ|ㅏ-ㅣ|가-힣|ᆞ|ᆢ|ㆍ|ᆢ|ᄀᆞ|ᄂᆞ|ᄃᆞ|ᄅᆞ|ᄆᆞ|ᄇᆞ|ᄉᆞ|ᄋᆞ|ᄌᆞ|ᄎᆞ|ᄏᆞ|ᄐᆞ|ᄑᆞ|ᄒᆞ]'))
                                                        ],
                                                        controller:
                                                            textController,
                                                        onTap: () {
                                                          print(
                                                              '>> Scrollable');
                                                          Scrollable
                                                              .ensureVisible(
                                                            // 입력 시 스크롤 자동 이동
                                                            dataKey
                                                                .currentContext!,
                                                            // duration: const Duration(milliseconds: 300),
                                                            // curve: Curves.easeInOut,
                                                          );
                                                        },
                                                        decoration:
                                                            InputDecoration(
                                                                errorBorder:
                                                                    OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10.0),
                                                                  borderSide: const BorderSide(
                                                                      color: Colors
                                                                          .red,
                                                                      width:
                                                                          2.0),
                                                                ),
                                                                border:
                                                                    const OutlineInputBorder(),
                                                                hintText:
                                                                    '추가할 식재료',
                                                                errorText:
                                                                    isTextFieldError
                                                                        ? "입력란이 비었습니다." // Error message
                                                                        : null)),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                IconButton(
                                                  onPressed: () {
                                                    if (textController.text
                                                        .trim()
                                                        .isEmpty) {
                                                      isTextFieldError = true;
                                                      print("비었음");
                                                    } else {
                                                      isTextFieldError = false;
                                                      if (rListController
                                                          .canAddIngredient(
                                                              textController
                                                                  .text)) {
                                                        Get.showSnackbar(
                                                            const GetSnackBar(
                                                          title: '중복 알림',
                                                          message:
                                                              '이미 있는 재료입니다',
                                                          icon: Icon(
                                                            Icons.check_box,
                                                            color: Colors.white,
                                                          ),
                                                          backgroundColor:
                                                              Colors.red,
                                                          duration: Duration(
                                                              seconds: 3),
                                                        ));
                                                      } else {
                                                        rListController
                                                            .setIngredient(
                                                                textController
                                                                    .text);
                                                        textController.clear();
                                                      }
                                                    }
                                                  },
                                                  color: Colors.black,
                                                  highlightColor: lightColorScheme
                                                      .primary, //<-- SEE HERE
                                                  iconSize: 20,
                                                  icon: const Icon(
                                                    Icons.add,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          // SizedBox(
                                          //   width: 100,
                                          //   child: ElevatedButton(
                                          //     onPressed: () {
                                          //       isTextFieldError = false;
                                          //       Navigator.of(context).pop();
                                          //     },
                                          //     child: const Text('닫기'),
                                          //   ),
                                          // ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 10,
                                    right: 10,
                                    child: IconButton(
                                      color: Colors.black,
                                      icon: const Icon(Icons.close),
                                      onPressed: () {
                                        isTextFieldError = false;
                                        // Dialog를 닫기 위한 로직을 추가하세요.
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child: const Text('수정'),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // 모달창을 열지 않고 바로 완료를 눌렀을 때까지 커버함
                      rListController.changeIngredients();
                      // 리스트 페이지로 이동
                      Get.toNamed('/camera_rec');
                    },
                    child: const Text('완료'),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
          ...displayBoxesAroundRecognizedObjects(screen, cameraPageController),
          Offstage(
              offstage:
                  !rListController.isLoading.value, // isLoading이 false면 감춰~
              child: Stack(children: <Widget>[
                //다시 stack
                const Opacity(
                  //뿌옇게~
                  opacity: 0.5,
                  child: ModalBarrier(
                      dismissible: false, color: Colors.black), //클릭 못하게
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const CircularProgressIndicator(),
                      const SizedBox(height: 16.0),
                      cameraPageController.isLoaded.value
                          ? remarks("인공지능 모델 로딩 중...", context)
                          : cameraPageController.isDetecting.value
                              ? remarks("사진 분석 중...", context)
                              : remarks("탐지 결과 표시 중...", context),
                    ],
                  ),
                ),
              ]))
        ]),
      ),
    );
  }
}

Text remarks(String text, context) {
  return Text(text,
      style: Theme.of(context)
          .textTheme
          .bodyMedium!
          .copyWith(color: lightColorScheme.primary));
}

List<Widget> displayBoxesAroundRecognizedObjects(
    Size screen, CameraPageController controller) {
  final yoloResults = controller.yoloResults;
  final imageWidth = controller.imageWidth.value;
  final imageHeight = controller.imageHeight.value;

  if (yoloResults.isEmpty) {
    return [];
  }

  double factorX = screen.width / 1280;
  double imgRatio = imageWidth / imageHeight;
  double newWidth = 1280 * factorX;
  double newHeight = newWidth / imgRatio;
  double factorY = newHeight / 1280;

  double pady = (screen.height - newHeight) / 2;

  Color colorPick = Colors.pink;

  return yoloResults.map((result) {
    return Positioned(
      left: result["box"][0] * factorX,
      top: result["box"][1] * factorY + pady,
      width: (result["box"][2] - result["box"][0]) * factorX,
      height: (result["box"][3] - result["box"][1]) * factorY,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          border: Border.all(color: Colors.pink, width: 2.0),
        ),
        child: Text(
          "${result['tag']} ${(result['box'][4] * 100).toStringAsFixed(0)}%",
          style: TextStyle(
            background: Paint()..color = colorPick,
            color: Colors.white,
            fontSize: 18.0,
          ),
        ),
      ),
    );
  }).toList();
}
