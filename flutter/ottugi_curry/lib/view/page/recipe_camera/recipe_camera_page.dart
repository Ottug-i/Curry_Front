import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ottugi_curry/view/comm/default_layout_widget.dart';
import 'package:ottugi_curry/view/controller/recipe_camera/camera_page_controller.dart';
import 'package:ottugi_curry/view/page/recipe_camera/take_picture_paeg.dart';

class RecipeCameraPage extends StatefulWidget {
  const RecipeCameraPage({Key? key}) : super(key: key);

  @override
  _RecipeCameraPageState createState() => _RecipeCameraPageState();
}

class _RecipeCameraPageState extends State<RecipeCameraPage> {
  final controller = Get.put(CameraPageController());

  Future<void> _initCamera() async {
    await Get.find<CameraPageController>().initializeCamera();
  }

  @override
  void initState() {
    super.initState();
    _initCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => DefaultLayoutWidget(
          backToMain: true,
          appBarTitle: '식재료 촬영하기',
          body: controller.isCameraInitialized.value // 카메라가 초기화되었을 때만 사용
              ? TakePicturePage(camera: controller.camera)
              : const Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [CircularProgressIndicator()]),
                ),
        ));
  }
}
