import 'dart:io';

import 'package:ar_flutter_plugin/managers/ar_location_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_session_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_object_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_anchor_manager.dart';
import 'package:flutter/material.dart';
import 'package:ar_flutter_plugin/ar_flutter_plugin.dart';
import 'package:ar_flutter_plugin/datatypes/config_planedetection.dart';
import 'package:ar_flutter_plugin/datatypes/node_types.dart';
import 'package:ar_flutter_plugin/models/ar_node.dart';
import 'package:vector_math/vector_math_64.dart';

class LocalAndWebObjectsWidget extends StatefulWidget {
  const LocalAndWebObjectsWidget({Key? key}) : super(key: key);
  @override
  _LocalAndWebObjectsWidgetState createState() =>
      _LocalAndWebObjectsWidgetState();
}

class _LocalAndWebObjectsWidgetState extends State<LocalAndWebObjectsWidget> {
  ARSessionManager? arSessionManager;
  ARObjectManager? arObjectManager;
  //String localObjectReference;
  ARNode? localObjectNode;
  //String webObjectReference;
  ARNode? webObjectNode;
  ARNode? fileSystemNode;
  HttpClient? httpClient;

  @override
  void dispose() {
    super.dispose();
    arSessionManager!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Local & Web Objects'),
        ),
        body: Stack(children: [
          ARView(
            onARViewCreated: onARViewCreated,
            planeDetectionConfig: PlaneDetectionConfig.horizontalAndVertical,
          ),
          Align(
              alignment: FractionalOffset.bottomCenter,
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //   children: [
                //     ElevatedButton(
                //         onPressed: onFileSystemObjectAtOriginButtonPressed,
                //         child: const Text(
                //             "Add/Remove Filesystem\nObject at Origin")),
                //   ],
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                        onPressed: onLocalObjectAtOriginButtonPressed,
                        child:
                            const Text("Add/Remove Local\nObject at Origin")),
                  ],
                )
              ]))
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
          showPlanes: true,
          customPlaneTexturePath: "images/triangle.png",
          showWorldOrigin: true,
          handleTaps: false,
        );
    this.arObjectManager!.onInitialize();
  }

  Future<void> onLocalObjectAtOriginButtonPressed() async {
    if (localObjectNode != null) {
      arObjectManager!.removeNode(localObjectNode!);
      localObjectNode = null;
    } else {
      var newNode = ARNode(
          type: NodeType.localGLTF2,
          uri: "character_blender.gltf", // "Models/Chicken_01/Chicken_01.gltf",
          scale: Vector3(0.2, 0.2, 0.2),
          position: Vector3(0.0, 0.0, 0.0),
          rotation: Vector4(1.0, 0.0, 0.0, 0.0));
      bool? didAddLocalNode = await arObjectManager!.addNode(newNode);
      localObjectNode = (didAddLocalNode!) ? newNode : null;
    }
  }

  // Future<void> onFileSystemObjectAtOriginButtonPressed() async {
  //   if (fileSystemNode != null) {
  //     arObjectManager!.removeNode(fileSystemNode!);
  //     fileSystemNode = null;
  //   } else {
  //     var newNode = ARNode(
  //         type: NodeType
  //             .fileSystemAppFolderGLTF2, // NodeType.fileSystemAppFolderGLB,
  //         uri: "3d_models/character_seperate.gltf", //"Astronaut.glb",
  //         scale: Vector3(0.2, 0.2, 0.2));
  //     //Alternative to use type fileSystemAppFolderGLTF2:
  //     //var newNode = ARNode(
  //     //    type: NodeType.fileSystemAppFolderGLTF2,
  //     //    uri: "Chicken_01.gltf",
  //     //    scale: Vector3(0.2, 0.2, 0.2));
  //     bool? didAddFileSystemNode = await arObjectManager!.addNode(newNode);
  //     fileSystemNode = (didAddFileSystemNode!) ? newNode : null;
  //   }
  // }

  // Future<void> onLocalObjectShuffleButtonPressed() async {
  //   if (localObjectNode != null) {
  //     var newScale = Random().nextDouble() / 3;
  //     var newTranslationAxis = Random().nextInt(3);
  //     var newTranslationAmount = Random().nextDouble() / 3;
  //     var newTranslation = Vector3(0, 0, 0);
  //     newTranslation[newTranslationAxis] = newTranslationAmount;
  //     var newRotationAxisIndex = Random().nextInt(3);
  //     var newRotationAmount = Random().nextDouble();
  //     var newRotationAxis = Vector3(0, 0, 0);
  //     newRotationAxis[newRotationAxisIndex] = 1.0;

  //     final newTransform = Matrix4.identity();

  //     newTransform.setTranslation(newTranslation);
  //     newTransform.rotate(newRotationAxis, newRotationAmount);
  //     newTransform.scale(newScale);

  //     localObjectNode!.transform = newTransform;
  //   }
  // }
}
