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
            )
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
                    // ElevatedButton(
                    //     onPressed: () {
                    //       // 버튼 눌러서 노드 추가/삭제 - 로딩 시간이 느림
                    //       arkitController.onAddNodeForAnchor = _handleAddAnchor;
                    //     },
                    //     child: Text("AR송이 추가하기",
                    //         style: Theme.of(context).textTheme.bodyMedium!)),
                    // const SizedBox(
                    //   width: 10,
                    // ),
                    FloatingActionButton(
                      onPressed: () async {
                        // 캡쳐
                        final ImageProvider snapshot = await arkitController.snapshot();
                        final Uint8List snapshotData = await arCameraController.loadImageData(snapshot, context);

                        arCameraController.takeScreenshot(context, snapshotData);
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
      ]),
    );
  }

  void onARKitViewCreated(ARKitController arkitController) {
    this.arkitController = arkitController;
    arkitController.addCoachingOverlay(CoachingOverlayGoal.horizontalPlane);

    // // 자동으로 노드 추가
    _addNode(arkitController);
  }

  void _handleAddAnchor(ARKitAnchor anchor) {
    if (anchor is ARKitPlaneAnchor) {
      _addPlane(arkitController, anchor);
    }
  }

  void _addPlane(ARKitController controller, ARKitPlaneAnchor anchor) {
    if (node != null) {
      controller.remove(node!.name);
    }
    node = ARKitReferenceNode(
      url: 'models.scnassets/confirm_1_lying.usdc',
      position: vector.Vector3(0, 0, 0),
      scale: vector.Vector3.all(0.08),
    );
    controller.add(node!, parentNodeName: anchor.nodeName);
  }

  void _addNode(ARKitController arkitController) {
    // if (node != null) {
    //   controller.remove(node!.name);
    // }
    final node = ARKitReferenceNode(
      url: 'models.scnassets/confirm_1_lying.usdc',
      position: vector.Vector3(0, 0, 0),
      scale: vector.Vector3.all(0.08),

    );
    arkitController.add(node);
  }


}
