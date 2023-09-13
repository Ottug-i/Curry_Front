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
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';

class ARCameraPageAndroid extends StatefulWidget {
  const ARCameraPageAndroid({Key? key}) : super(key: key);
  @override
  ARCameraPageAndroidState createState() => ARCameraPageAndroidState();
}

class ARCameraPageAndroidState extends State<ARCameraPageAndroid> {
  ARSessionManager? arSessionManager;
  ARObjectManager? arObjectManager;
  ARNode? fileSystemNode;
  ARNode? webObjectNode;
  HttpClient? httpClient;

  @override
  void dispose() {
    super.dispose();
    arSessionManager!.dispose();
    // arObjectManager!.removeNode(fileSystemNode!);
    // fileSystemNode = null;
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
                                ()=> Text(arCameraController.existARNode.value == true? 'AR송이 숨기기': 'AR송이 추가하기',
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
      ARLocationManager arLocationManager) {
    this.arSessionManager = arSessionManager;
    this.arObjectManager = arObjectManager;

    this.arSessionManager!.onInitialize(
      showFeaturePoints: false,
      showPlanes: false,
      showWorldOrigin: false,
      handleTaps: false,
    );
    this.arObjectManager!.onInitialize();

    // // 다운로드
    // httpClient = HttpClient();
    // _downloadFile(
    //     "https://github.com/Ottug-i/Curry_Front/raw/main/flutter/ottugi_curry/assets/3d_models/light_mushroom.glb",
    //     "LocalMushroom.glb");
  }

  // 네트워크 이미지 불러오기
  Future<void> onWebObjectAtOriginButtonPressed() async {
    if (webObjectNode != null) {
      arObjectManager!.removeNode(webObjectNode!);
      webObjectNode = null;
      Get.put(ARCameraController()).existARNode.value = false;
    } else {
      var newNode = ARNode(
          type: NodeType.webGLB,
          uri:
          "https://github.com/Ottug-i/Curry_Front/raw/main/flutter/ottugi_curry/assets/3d_models/light_mushroom.glb",
          scale: math.Vector3.all(0.07));
      bool? didAddWebNode = await arObjectManager!.addNode(newNode);
      webObjectNode = (didAddWebNode!) ? newNode : null;
      Get.put(ARCameraController()).existARNode.value = true;
    }
  }

  Future<File> _downloadFile(String url, String filename) async {
    var request = await httpClient!.getUrl(Uri.parse(url));
    var response = await request.close();
    var bytes = await consolidateHttpClientResponseBytes(response);
    String dir = (await getApplicationDocumentsDirectory()).path;
    File file = File('$dir/$filename');
    await file.writeAsBytes(bytes);
    print("Downloading finished, path: " '$dir/$filename');
    return file;
  }

  // 파일 이미지 불러오기
  Future<void> onFileSystemObjectAtOrigin() async {

    if (fileSystemNode != null) {
      arObjectManager!.removeNode(fileSystemNode!);
      fileSystemNode = null;
      Get.put(ARCameraController()).existARNode.value = false;
    } else {
      var newNode = ARNode(
        type: NodeType.fileSystemAppFolderGLB,
        uri: "LocalMushroom.glb",
        scale: math.Vector3.all(0.08),
        rotation: math.Vector4(0, 0, 0, 0),
        position: math.Vector3(0, 0.4, 0.4),
      );

      bool? didAddFileSystemNode = await arObjectManager!.addNode(newNode);
      fileSystemNode = (didAddFileSystemNode!) ? newNode : null;
      Get.put(ARCameraController()).existARNode.value = true;
    }
  }
}