import 'dart:io';

import 'package:ar_flutter_plugin/managers/ar_location_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_session_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_object_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_anchor_manager.dart';
import 'package:ar_flutter_plugin/ar_flutter_plugin.dart';
import 'package:ar_flutter_plugin/datatypes/config_planedetection.dart';
import 'package:ar_flutter_plugin/datatypes/node_types.dart';
import 'package:ar_flutter_plugin/models/ar_node.dart';
import 'package:get/get.dart';
import 'package:ottugi_curry/config/color_schemes.dart';
import 'package:ottugi_curry/view/comm/default_layout_widget.dart';
import 'package:ottugi_curry/view/controller/ar_camera/ar_camera_controller.dart';
import 'package:vector_math/vector_math_64.dart' as math;
import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';

class ARCameraPageAndroid extends StatefulWidget {
  const ARCameraPageAndroid({Key? key}) : super(key: key);
  @override
  ARCameraPageAndroidState createState() => ARCameraPageAndroidState();
}

class ARCameraPageAndroidState extends State<ARCameraPageAndroid> {
  ARSessionManager? arSessionManager;
  ARObjectManager? arObjectManager;
  ARNode? webObjectNode;
  HttpClient? httpClient;

  @override
  void initState() {
    Get.put(ARCameraController()).loadModelFunction();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    arSessionManager!.dispose();
    webObjectNode = null;
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
            child: ARView(
              onARViewCreated: onARViewCreated,
              planeDetectionConfig: PlaneDetectionConfig.horizontalAndVertical,
            ),
          ),
          Align(
              alignment: FractionalOffset.bottomCenter,
              child: Container(
                margin: const EdgeInsets.only(bottom: 20.0),
                child:
                    Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          // onPressed: onFileSystemObjectAtOrigin,
                          onPressed: onWebObjectAtOriginButtonPressed,
                          child: Obx(
                            () => Text(
                                arCameraController.existARNode.value == true
                                    ? 'AR 캐릭터 숨기기'
                                    : 'AR 캐릭터 추가하기',
                                style: Theme.of(context).textTheme.bodyMedium!),
                          )),
                      const SizedBox(
                        width: 10,
                      ),
                      FloatingActionButton(
                        onPressed: () {
                          arCameraController.captureScreenshot(context);
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
        ]));
  }

  void onARViewCreated(
      ARSessionManager arSessionManager,
      ARObjectManager arObjectManager,
      ARAnchorManager arAnchorManager,
      ARLocationManager arLocationManager) async {
    this.arSessionManager = arSessionManager;
    this.arObjectManager = arObjectManager;

    this.arSessionManager!.onInitialize(
          showFeaturePoints: false,
          showPlanes: false,
          showWorldOrigin: false,
          handleTaps: false,
        );
    this.arObjectManager!.onInitialize();
  }

  // 네트워크 이미지 불러오기
  Future<void> onWebObjectAtOriginButtonPressed() async {
    if (webObjectNode != null) {
      arObjectManager!.removeNode(webObjectNode!);
      webObjectNode = null;
      Get.put(ARCameraController()).existARNode.value = false;
    } else {
      final url = Get.put(ARCameraController()).modelFilesPath.value;

      var newNode = ARNode(
          type: NodeType.webGLB,
          uri: url,
          scale: math.Vector3.all(0.07),
          eulerAngles: math.Vector3(-30, 0, 0));
      bool? didAddWebNode = await arObjectManager!.addNode(newNode);
      webObjectNode = (didAddWebNode!) ? newNode : null;
      Get.put(ARCameraController()).existARNode.value = true;
    }
  }
}
