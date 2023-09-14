import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ottugi_curry/view/comm/default_layout_widget.dart';
import 'package:ottugi_curry/view/controller/recipe_camera/camera_page_controller.dart';
import 'package:ottugi_curry/view/page/recipe_camera/result_check_page.dart';

class RecipeCameraPage extends StatefulWidget {
  const RecipeCameraPage({Key? key}) : super(key: key);

  @override
  _RecipeCameraPageState createState() => _RecipeCameraPageState();
}

class _RecipeCameraPageState extends State<RecipeCameraPage> {
  CameraPageController pageController = Get.put(CameraPageController());
  late CameraController controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    if (pageController.isCameraInitialized.value == false) {
      // main.dart 에서 초기화가 안되었으면
      pageController.initializeCamera();
    }
    controller = CameraController(pageController.camera, ResolutionPreset.max);
    _initializeControllerFuture = controller.initialize();
  }

  void takePicture() async {
    // try-catch 문에서 사진을 찍는다. 오류가 생기면 catch에서 잡을 것.
    try {
      // 카메라가 초기화 되었는지 확인
      await _initializeControllerFuture;
      // capture 속도 느려지는 문제 해결
      await controller.setFocusMode(FocusMode.locked);
      await controller.setExposureMode(ExposureMode.locked);

      // 사진을 찍고 저장된 image 파일을 가져옴
      final image = await controller.takePicture();

      await controller.setFocusMode(FocusMode.auto);
      await controller.setExposureMode(ExposureMode.auto);

      if (!mounted) return;

      // controller에 사진 저장
      pageController.imageFile.value = File(image.path);

      pageController.initDetection();
      // 찍힌 사진을 새로운 화면에 띄운다.
      Get.to(() => const ResultCheckPage());
    } catch (e) {
      // 오류 발생 시 log에 에러 메세지 출력
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => DefaultLayoutWidget(
        backToMain: true,
        appBarTitle: '식재료 촬영하기',
        body: !pageController.isCameraInitialized.value // 카메라가 초기화되지 않았다면
            ? const Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [CircularProgressIndicator()]),
              )
            : Center(
                heightFactor: MediaQuery.of(context).size.height,
                child: Stack(children: [
                  FutureBuilder<void>(
                    // 카메라 미리보기를 displaying하기 전에 controller가 초기화 되기를 기다려야 함.
                    // controller 초기화가 끝나기 전까지 FutureBuilder를 사용해서 로딩 스피너를 띄운다.
                    future: _initializeControllerFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        // Future가 끝나면, 미리보기를 표시한다.
                        return Center(
                          child: CameraPreview(controller),
                        );
                      } else {
                        // 그렇지 않으면, 로딩 인디케이터를 띄운다.
                        return const Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: InkWell(
                            onTap: () {
                              takePicture();
                            },
                            child: const Stack(
                              alignment: Alignment.center,
                              children: [
                                Icon(
                                  Icons.circle,
                                  color: Colors.white38,
                                  size: 80,
                                ),
                                Icon(
                                  Icons.circle,
                                  color: Colors.white,
                                  size: 65,
                                ),
                              ],
                            ),
                          ))),
                  // 노랑 버튼 ver
                  // Align(
                  //   alignment: Alignment.bottomCenter,
                  //   child: Padding(
                  //     padding: const EdgeInsets.only(bottom: 40),
                  //     child: SizedBox(
                  //       width: 80,
                  //       child: FloatingActionButton(
                  //         backgroundColor: lightColorScheme.primary,
                  //         onPressed: () {
                  //           takePicture();
                  //         },
                  //         child: const Icon(Icons.camera_alt),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ]),
              )));
  }
}
