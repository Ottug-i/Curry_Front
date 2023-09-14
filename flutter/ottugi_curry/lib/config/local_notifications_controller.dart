import 'dart:math';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import 'config.dart';

class LocalNotificationsController {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  void setNotifications(
      {required int hour, int? minutes, required int messageId}) async {
    // Time, Notification Initialization
    _init();

    // 이전 알람 삭제
    await _cancelNotification();
    // 권한 요청
    await _requestPermissions();

    // 식사 시간대에 맞는 메세지 멘트 설정
    String message = '';
    int randomNum = Random().nextInt(3);
    switch (messageId) {
      case 0:
        message = Config().breakfastMessage[randomNum];
        break;
      case 1:
        message = Config().lunchMessage[randomNum];
        break;
      case 2:
        message = Config().dinnerMessage[randomNum];
        break;
    }
    // 메세지 설정
    await _registerMessage(
      // 요청한 시간 정각에 보여줌
      hour: hour,
      minutes: 0,
      message: message,
      messageId: messageId,
    );
    print('알림 Local Notification 설정 완료 $messageId');
  }

  Future<void> _init() async {
    await _configureLocalTimeZone();
    await _initializeNotification();
  }

  Future<void> _configureLocalTimeZone() async {
    tz.initializeTimeZones();
    final String timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName));
  }

  Future<void> _initializeNotification() async {
    const DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('ic_notification');

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      // onDidReceiveNotificationResponse: (NotificationResponse details) {
      //  print('details $details');
      //  FlutterAppBadger.removeBadge();
      // }
    );
  }

  // 메세지 등록 취소 - 새로운 메시지 등록할 때, 이전에 등록된 메시지를 모두 취소하기 위함
  Future<void> _cancelNotification() async {
    await _flutterLocalNotificationsPlugin.cancelAll();
  }

  // 권한 요청
  Future<void> _requestPermissions() async {
    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  Future<void> _registerMessage({
    required int hour,
    required int minutes,
    required String message,
    required int messageId,
  }) async {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minutes,
    );

    await _flutterLocalNotificationsPlugin.zonedSchedule(
      messageId, // Id: 동일하게 설정하면, 동일한 메시지가 현재 표시중이면 메시지 중복하여 표시하지 않음
      '카레', // title
      message, // body
      scheduledDate,
      NotificationDetails(
        android: AndroidNotificationDetails(
          'curry',
          'name',
          importance: Importance.max,
          priority: Priority.high,
          ongoing: true,
          // 앱을 실행 해야만 메시지가 사라지도록 설정
          styleInformation: BigTextStyleInformation(message),
          icon: 'ic_notification',
        ),
        iOS: const DarwinNotificationDetails(
          badgeNumber: 1,
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }
}
