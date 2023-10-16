import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:get/get.dart';
import 'package:ottugi_curry/config/color_schemes.dart';
import 'package:ottugi_curry/view/comm/default_layout_widget.dart';
import 'package:ottugi_curry/view/controller/ar_camera/ar_camera_controller.dart';
import 'package:screenshot/screenshot.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class ARCameraPageIos extends StatefulWidget {
  const ARCameraPageIos({super.key});

  @override
  ARCameraPageIosState createState() => ARCameraPageIosState();
}

class ARCameraPageIosState extends State<ARCameraPageIos> {
  late ARKitController arkitController;
  ARKitReferenceNode? node;

  @override
  void initState() {
    Get.put(ARCameraController()).loadModelFunction();
    super.initState();
  }

  @override
  void dispose() {
    arkitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Get.put(ARCameraController());
    final arCameraController = Get.find<ARCameraController>();

    return DefaultLayoutWidget(
        backToMain: true,
        appBarTitle: '인증샷 남기기',
        body: Stack(children: [
              Screenshot(
                  controller: arCameraController.screenshotController.value,
                  child: ARKitSceneView(
                    planeDetection: ARPlaneDetection.horizontal,
                    onARKitViewCreated: onARKitViewCreated,
                    showWorldOrigin: false,
                  )),
              Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 20.0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FloatingActionButton(
                                onPressed: () async {
                                  // 캡쳐
                                  final ImageProvider snapshot =
                                      await arkitController.snapshot();
                                  final Uint8List snapshotData =
                                      await arCameraController.loadImageData(
                                          snapshot, context);

                                  arCameraController.takeScreenshot(
                                      context, snapshotData);
                                },
                                backgroundColor: lightColorScheme.primary,
                                foregroundColor: Colors.black,
                                shape: const CircleBorder(),
                                child: const Icon(Icons.camera),
                              )
                            ],
                          ),
                        ]),
                  )),
            ])
    );
  }

  void onARKitViewCreated(ARKitController arkitController) {
    this.arkitController = arkitController;
    arkitController.addCoachingOverlay(CoachingOverlayGoal.horizontalPlane);

    // // 자동으로 노드 추가
    _addNode(arkitController);
  }

  void _addNode(ARKitController arkitController) {
    final url = Get.put(ARCameraController()).modelFilesPath.value;
    final node = ARKitReferenceNode(
      url: url,
      position: vector.Vector3(0, 0, 0),
      scale: vector.Vector3.all(0.08),
      eulerAngles: vector.Vector3(200, 180, 90)
    );
    arkitController.add(node);
  }
}
