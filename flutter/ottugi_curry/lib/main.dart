import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:ottugi_curry/config/config.dart';
import 'package:ottugi_curry/config/custom_theme_data.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ottugi_curry/config/local_notifications_controller.dart';
import 'package:ottugi_curry/view/page/ar_camera/ar_camera_page.dart';
import 'package:ottugi_curry/view/controller/recipe_camera/camera_page_controller.dart';
import 'firebase_options.dart';

void main() async {
  // splash screen
  WidgetsFlutterBinding.ensureInitialized(); // 초기화 보장
  await Future.delayed(const Duration(seconds: 2)); // 지연

  // Local Notification 시간 설정
  LocalNotificationsController localNotificationsController = LocalNotificationsController();
  localNotificationsController.setNotifications(hour: 8, messageId: 0); // 아침 알림
  localNotificationsController.setNotifications(hour: 12, messageId: 1); // 점심 알림
  localNotificationsController.setNotifications(hour: 18, messageId: 2); // 저녁 알림

  // firebase (google)
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // kakao Flutter SDK
  KakaoSdk.init(nativeAppKey: 'f058e8e5bc00f59848d0eb05b04aa3b6');
  await userStorage.ready;

  // ChatGpt API Key
  await dotenv.load(fileName: "assets/config/.env");

  // init camera
  await Get.put(CameraPageController()).initializeCamera();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: '카레',
      theme: CustomThemeData.themeDataLight,
      initialRoute: '/login', // login
      getPages: Config.routers,
      // home: const ArCameraPage(),
    );
  }
}
