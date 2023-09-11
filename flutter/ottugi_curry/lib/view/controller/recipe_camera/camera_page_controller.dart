import 'dart:io';
import 'dart:ui' as ui;
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_vision/flutter_vision.dart';
import 'package:image/image.dart' as img;

class CameraPageController extends GetxController {
  late CameraDescription camera;
  Rx<bool> isCameraInitialized = false.obs;

  late FlutterVision vision;
  RxList<Map<String, dynamic>> yoloResults = <Map<String, dynamic>>[].obs;
  Rx<File> imageFile = File('').obs;
  Rx<int> imageHeight = 1280.obs;
  Rx<int> imageWidth = 1280.obs;
  Rx<bool> isLoaded = false.obs;

  late CameraController controller;
  CameraImage? cameraImage;
  Rx<bool> isDetecting = false.obs;

  Future<void> initializeCamera() async {
    WidgetsFlutterBinding.ensureInitialized();
    final cameras = await availableCameras();
    if (cameras.isNotEmpty) {
      camera = cameras.first;
      isCameraInitialized = true.obs;
    }
  }

  void initDetection() {
    print(">> initDetection");
    if (!isCameraInitialized.value) {
      initializeCamera();
    }
    vision = FlutterVision();
    loadYoloModel().then((value) {
      yoloResults.clear();
      isDetecting.value = false;
      isLoaded.value = false; // load 시작
    });
  }

  Future<void> loadYoloModel() async {
    await vision.loadYoloModel(
        labels: 'assets/ml_model/label.txt',
        modelPath: 'assets/ml_model/best-ver6.tflite',
        modelVersion: "yolov5",
        numThreads: 2,
        useGpu: true);
    isLoaded.value = true; // load 완료
  }

  Future<List<String>> detectImage() async {
    isDetecting.value = true;
    yoloResults.clear();

    Uint8List byte = await imageFile.value.readAsBytes();
    // final originalImage = await decodeImageFromList(byte);

    img.Image? original = img.decodeImage(byte);

    // 이미지 크기 변경
    img.Image resized = img.copyResize(original!, width: 1280, height: 1280);
    final newByte = Uint8List.fromList(img.encodePng(resized));
    final resizedImage = await decodeImageFromList(newByte);

    imageHeight.value = resizedImage.height;
    imageWidth.value = resizedImage.width;

    final result = await vision.yoloOnImage(
        bytesList: newByte,
        imageHeight: resizedImage.height,
        imageWidth: resizedImage.width,
        iouThreshold: 0.8,
        confThreshold: 0.4,
        classThreshold: 0.7);

    isDetecting.value = false;

    if (result.isNotEmpty) {
      // 추론 결과에서 클래스 정보 추출 (중복 결과는 추가되지 않도록 코드 약간 수정 필요)
      Set<String> detectedClasses = {};

      for (var recognition in result) {
        detectedClasses.add(recognition["tag"]);
      }
      // 추론 결과 활용 (예: 클래스 정보 출력)
      // -> 결과를 사용자에게 물어보고, 필요 없는 것을 삭제한 후 백엔드 서버에 요청
      yoloResults.value = result;
      // rListController.setIngredientList(detectedClasses.toList());
      update();
      return detectedClasses.toList();
    } else {
      return [];
    }
  }

  @override
  void dispose() async {
    super.dispose();
    await vision.closeYoloModel();
  }
}
