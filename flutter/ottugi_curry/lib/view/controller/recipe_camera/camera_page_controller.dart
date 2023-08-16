import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CameraPageController extends GetxController {
  late CameraDescription camera;
  Rx<bool> isCameraInitialized = false.obs;

  Future<void> initializeCamera() async {
    WidgetsFlutterBinding.ensureInitialized();
    final cameras = await availableCameras();
    if (cameras.isNotEmpty) {
      camera = cameras.first;
      isCameraInitialized = true.obs;
    }
  }
}
