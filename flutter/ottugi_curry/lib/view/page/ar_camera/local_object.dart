import 'dart:io';

import 'package:ar_flutter_plugin/managers/ar_location_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_session_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_object_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_anchor_manager.dart';
import 'package:ar_flutter_plugin/ar_flutter_plugin.dart';
import 'package:ar_flutter_plugin/datatypes/config_planedetection.dart';
import 'package:ar_flutter_plugin/datatypes/node_types.dart';
import 'package:ar_flutter_plugin/models/ar_node.dart';
import 'package:ottugi_curry/config/color_schemes.dart';
import 'package:share_plus/share_plus.dart';
import 'package:vector_math/vector_math_64.dart' as math;
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';

class LocalAndWebObjectsWidget extends StatefulWidget {
  const LocalAndWebObjectsWidget({Key? key}) : super(key: key);
  @override
  _LocalAndWebObjectsWidgetState createState() =>
      _LocalAndWebObjectsWidgetState();
}

class _LocalAndWebObjectsWidgetState extends State<LocalAndWebObjectsWidget> {
  ARSessionManager? arSessionManager;
  ARObjectManager? arObjectManager;
  ARNode? fileSystemNode;
  HttpClient? httpClient;

  ScreenshotController screenshotController = ScreenshotController();

  @override
  void dispose() {
    super.dispose();
    arSessionManager!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('AR 캐릭터와 인증샷 남기기'),
        ),
        body: Stack(children: [
          Screenshot(
            controller: screenshotController,
            child: ARView(
              onARViewCreated: onARViewCreated,
              planeDetectionConfig: PlaneDetectionConfig.horizontalAndVertical,
            ),
          ),
          Align(
              alignment: FractionalOffset.bottomCenter,
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: onFileSystemObjectAtOrigin,
                        child: Text("AR송이 추가하기",
                            style: Theme.of(context).textTheme.bodyMedium!)),
                    const SizedBox(
                      width: 10,
                    ),
                    FloatingActionButton(
                      onPressed: onTakeScreenshot,
                      backgroundColor: lightColorScheme.primary,
                      foregroundColor: Colors.black,
                      shape: const CircleBorder(),
                      child: const Icon(Icons.camera),
                    )
                    // ElevatedButton(
                    //     onPressed: onTakeScreenshot,
                    //     child: Text("사진 찍기",
                    //         style: Theme.of(context).textTheme.bodyMedium!))
                  ],
                ),
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
          showPlanes: false,
          // customPlaneTexturePath: "images/triangle.png",
          showWorldOrigin: false,
          handleTaps: false,
        );
    this.arObjectManager!.onInitialize();

    httpClient = HttpClient();
    _downloadFile(
        "https://github.com/Ottug-i/Curry_Front/raw/main/flutter/ottugi_curry/assets/3d_models/mushroom.glb",
        "LocalMushroom.glb");
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

  Future<void> onFileSystemObjectAtOrigin() async {
    if (fileSystemNode != null) {
      arObjectManager!.removeNode(fileSystemNode!);
      fileSystemNode = null;
    } else {
      var newNode = ARNode(
          type: NodeType.fileSystemAppFolderGLB,
          uri: "LocalMushroom.glb", //"LocalDuck.glb",
          scale: math.Vector3(0.08, 0.08, 0.08),
          rotation: math.Vector4(0, 0.5, 0, 0),
          position: math.Vector3(0, -0.4, -0.4),
          transformation: Matrix4.rotationY(-30));
      bool? didAddFileSystemNode = await arObjectManager!.addNode(newNode);
      fileSystemNode = (didAddFileSystemNode!) ? newNode : null;
    }
  }

  Future<void> onTakeScreenshot() async {
    final image = await screenshotController.capture();

    if (image == null) return;
    // await saveImage(image);
    // ignore: use_build_context_synchronously
    await showDialog(
        context: context,
        builder: (_) => Dialog(
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: MemoryImage(image), fit: BoxFit.cover)),
                  ),
                  Align(
                      alignment: FractionalOffset.bottomCenter,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FloatingActionButton(
                                  onPressed: () => onTakePicture(image),
                                  backgroundColor: lightColorScheme.primary,
                                  foregroundColor: Colors.black,
                                  shape: const CircleBorder(),
                                  child: const Icon(Icons.download),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                FloatingActionButton(
                                  onPressed: () => onSharePicture(image),
                                  backgroundColor: lightColorScheme.primary,
                                  foregroundColor: Colors.black,
                                  shape: const CircleBorder(),
                                  child: const Icon(Icons.share),
                                ),
                              ],
                            ),
                          ])),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ));
  }

  Future<void> onTakePicture(image) async {
    await saveImage(image);
  }

  Future onSharePicture(Uint8List bytes) async {
    final directory = await getApplicationDocumentsDirectory();
    final image = File('${directory.path}/flutter.png');
    image.writeAsBytesSync(bytes);

    await Share.shareXFiles([XFile(image.path)]);
    // await Share.shareFiles([image.path]);
  }

  Future<String> saveImage(Uint8List bytes) async {
    await [Permission.storage].request();

    final time = DateTime.now()
        .toIso8601String()
        .replaceAll('.', '-')
        .replaceAll(':', '-');
    final name = 'screenshot_$time';
    final result = await ImageGallerySaver.saveImage(bytes, name: name);

    return result['filePath'];
  }

  Future saveAndShare(Uint8List bytes) async {
    final directory = await getApplicationDocumentsDirectory();
    final image = File('${directory.path}/flutter.png');
    image.writeAsBytesSync(bytes);

    await Share.shareXFiles([XFile(image.path)]);
    // await Share.shareFiles([image.path]);
  }
}
