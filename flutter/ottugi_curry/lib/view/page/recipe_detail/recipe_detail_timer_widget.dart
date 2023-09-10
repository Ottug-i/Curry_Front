import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ottugi_curry/config/color_schemes.dart';
import 'package:ottugi_curry/utils/screen_size_utils.dart';
import 'package:ottugi_curry/view/controller/recipe_detail/recipe_detail_timer_controller.dart';

class RecipeDetailTimerWidget extends StatelessWidget {
  const RecipeDetailTimerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(RecipeDetailTimerController());
    final timerController = Get.find<RecipeDetailTimerController>();

    return Container(
      width: widthSize(context) / 1.3,
      padding: const EdgeInsets.only(bottom: 50, left: 10, right: 10, top: 30),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
          border: Border.all(
            color: lightColorScheme.primary,
            width: 5,
          ),
          color: Colors.white),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
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
                  // 알람 종료
                  timerController.stopTimerAlarm();
                },
              ),
              Text(
                '타이머',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const Padding(padding: EdgeInsets.only(left: 50)),
            ],
          ),
          const Padding(padding: EdgeInsets.only(bottom: 50)),

          // 타이머 분:초 Row
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Row(
              children: [
                // 분
                Flexible(
                  child: Obx(
                    () => TextField(
                      controller: timerController.minuteTextEditingController,
                      decoration: InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              width: 5,
                              color: lightColorScheme.primary,
                            ),
                          ),
                          enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                            width: 5,
                            color: Colors.grey,
                          ))),
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(2),
                      ],
                      readOnly: timerController.isRunning.value == true
                          ? true
                          : false,
                      showCursor: timerController.isRunning.value == true
                          ? false
                          : true, // 수정 가능 여부에 맞춘 커서 유무
                    ),
                  ),
                ),
                Text(":", style: Theme.of(context).textTheme.titleLarge),
                // 초
                Flexible(
                  child: Obx(
                    () => TextField(
                      controller: timerController.secondTextEditingController,
                      decoration: InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              width: 5,
                              color: lightColorScheme.primary,
                            ),
                          ),
                          enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                            width: 5,
                            color: Colors.grey,
                          ))),
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(2),
                      ],
                      readOnly: timerController.isRunning.value == true
                          ? true
                          : false,
                      // 수정 가능 여부
                      showCursor: timerController.isRunning.value == true
                          ? false
                          : true, // 수정 가능 여부에 맞춘 커서 유무
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Padding(padding: EdgeInsets.only(bottom: 50)),

          // 버튼
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {
                    timerController.stopTimer();
                  },
                  child: const Text('취소')),
              const Padding(padding: EdgeInsets.only(right: 20)),
              Obx(
                () => ElevatedButton(
                    onPressed: () {
                      if (timerController.startButtonText.value == '일시정지') {
                        //일시정지
                        timerController.pauseTimer();
                      } else {
                        //시작, 재개
                        timerController.startTimer();
                      }
                    },
                    child: Text('${timerController.startButtonText}')),
              ),
            ],
          )
        ],
      ),
    );
  }
}
