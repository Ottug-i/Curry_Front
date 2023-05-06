import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ottugi_curry/config/color_schemes.dart';
import 'package:ottugi_curry/view/controller/recipe_detail/recipe_detail_timer_controller.dart';

class RecipeDetailTimerWidget extends StatefulWidget {
  const RecipeDetailTimerWidget({Key? key}) : super(key: key);

  @override
  State<RecipeDetailTimerWidget> createState() =>
      _RecipeDetailTimerWidgetState();
}

class _RecipeDetailTimerWidgetState extends State<RecipeDetailTimerWidget> {
  @override
  Widget build(BuildContext context) {
    Get.put(RecipeDetailTimerController());
    final timerController = Get.find<RecipeDetailTimerController>();

    return Container(
      width: 300,
      height: 350,
      padding: const EdgeInsets.only(bottom: 50, left: 30, right: 30, top: 50),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
          border: Border.all(
            color: lightColorScheme.primary,
            width: 5,
          ),
          color: Colors.white),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 타이머 분:초 Row
          Row(
            children: [
              // 분
              Flexible(
                child: TextField(
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
                  readOnly:
                      timerController.isRunning.value == true ? true : false,
                ),
              ),
              Text(":", style: Theme.of(context).textTheme.titleLarge),
              // 초
              Flexible(
                child: TextField(
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
                  readOnly:
                      timerController.isRunning.value == true ? true : false, // 수정 가능 여부
                ),
              ),
            ],
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
                ()=> ElevatedButton(
                    onPressed: () {
                      if (timerController.startButtonText.value == '일시정지') { //일시정지
                        timerController.pauseTimer();
                      } else { //시작, 재개
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
