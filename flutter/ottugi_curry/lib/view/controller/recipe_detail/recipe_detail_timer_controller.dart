import 'dart:async';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class RecipeDetailTimerController {
  RxBool isRunning = false.obs;
  RxInt totalSeconds = 0.obs;
  RxInt remainingSeconds = 0.obs;
  Timer? timer;
  TextEditingController minuteTextEditingController =
      TextEditingController(text: '00');
  TextEditingController secondTextEditingController =
      TextEditingController(text: '00');
  RxString startButtonText = '시작'.obs;

  final AssetsAudioPlayer timerAlarmPlayer = AssetsAudioPlayer.newPlayer();
  RxBool isRingingAlarm = false.obs;

  void startTimer() {
    //시작, 재개
    // 입력한 시간초 기반 total Seconds 설정
    totalSeconds.value = int.parse(minuteTextEditingController.text) * 60 +
        int.parse(secondTextEditingController.text);
    // 시간초 미지정 시에 시작하지 않음
    if (totalSeconds.value == 0) return;

    // start 버튼 텍스트 변경
    startButtonText.value = '일시정지';

    // 타이머 시작
    isRunning.value = true;
    const duration = Duration(seconds: 1);
    remainingSeconds.value = totalSeconds.value;
    timer = Timer.periodic(duration, (timer) {
      print('remainingSeconds: $remainingSeconds');
      if (remainingSeconds.value == 0) {
        stopTimer();
        // 알림 시작
        timerAlarmPlayer.play();
        isRingingAlarm.value = true;
      } else {
        // 타이머 시간초 텍스트 변경
        minuteTextEditingController.text =
            (remainingSeconds.value ~/ 60).toString().padLeft(2, "0");
        secondTextEditingController.text =
            (remainingSeconds.value % 60).toString().padLeft(2, "0");
        remainingSeconds--;
      }
    });
  }

  void stopTimer() {
    // 취소
    // 시간초 리셋
    totalSeconds.value = 0;
    minuteTextEditingController.text = '00';
    secondTextEditingController.text = '00';

    // 타이머 종료
    isRunning.value = false;
    timer?.cancel();
    // 알람 종료
    stopTimerAlarm();

    // start 버튼 텍스트 변경
    startButtonText.value = '시작';
  }

  void pauseTimer() {
    // 일시정지
    // 타이머 종료 - isRunning == true
    timer?.cancel();

    // start 버튼 텍스트 변경
    startButtonText.value = '재개';
  }

  void loadTimerAlarm() {
    timerAlarmPlayer.open(
      Audio("assets/audios/timerAlarm.mp3"),
      loopMode: LoopMode.single, //반복 여부 (LoopMode.none : 없음)
      autoStart: false, //자동 시작 여부
      showNotification: false, //스마트폰 알림 창에 띄울지 여부
    );
  }

  void stopTimerAlarm() {
    if (isRingingAlarm.value) {
      timerAlarmPlayer.stop();
      isRingingAlarm.value = false;
    }
  }
}
