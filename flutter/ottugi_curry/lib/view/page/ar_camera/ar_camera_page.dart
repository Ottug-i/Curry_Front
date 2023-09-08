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
import 'package:share_plus/share_plus.dart';
import 'package:vector_math/vector_math_64.dart' as math;
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';

class ArCameraPage extends StatefulWidget {
  const ArCameraPage({Key? key}) : super(key: key);
  @override
  _ArCameraPageState createState() => _ArCameraPageState();
}

class _ArCameraPageState extends State<ArCameraPage> {
  ARSessionManager? arSessionManager;
  ARObjectManager? arObjectManager;
  ARNode? fileSystemNode;
  ARNode? webObjectNode;
  HttpClient? httpClient;

  ScreenshotController screenshotController = ScreenshotController();

  // GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final successAlert = const SnackBar(
    content: Text('기기의 앨범에 저장되었습니다.'),
    backgroundColor: Colors.green,
  );
  final failAlert = const SnackBar(
    content: Text('사진 저장에 실패했습니다.'),
    backgroundColor: Colors.red,
  );

  @override
  void dispose() {
    super.dispose();
    arSessionManager!.dispose();
    arObjectManager!.removeNode(fileSystemNode!);
    fileSystemNode = null;
    webObjectNode = null;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayoutWidget(
        backToMain: true,
        appBarTitle: '인증샷 남기기',
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
                          child: Text("AR송이 추가하기",
                              style: Theme.of(context).textTheme.bodyMedium!)),
                      const SizedBox(
                        width: 10,
                      ),
                      FloatingActionButton(
                        onPressed: () => takeScreenshot(context),
                        backgroundColor: lightColorScheme.primary,
                        foregroundColor: Colors.black,
                        shape: const CircleBorder(),
                        child: const Icon(Icons.camera),
                      )
                    ],
                  ),
                ]),
              )),
          //     Offstage(
          // offstage: !chatContorller.isLoading.value, // isLoading이 false면 감춰~
          // child: const Stack(children: <Widget>[
          //   //다시 stack
          //   Opacity(
          //     //뿌옇게~
          //     opacity: 0.5,
          //     child: ModalBarrier(
          //         dismissible: false, color: Colors.black), //클릭 못하게
          //   ),
          //   Center(
          //     child: CircularProgressIndicator(),
          //   ),
          // ]))
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
          // customPlaneTexturePath: "assets/3d_models/mushroom_final.glb",
          showWorldOrigin: true,
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

  Future<void> onWebObjectAtOriginButtonPressed() async {
    if (webObjectNode != null) {
      arObjectManager!.removeNode(webObjectNode!);
      webObjectNode = null;
    } else {
      var newNode = ARNode(
          type: NodeType.webGLB,
          uri:
          // "https://github.com/Ottug-i/Curry_Front/raw/main/flutter/ottugi_curry/assets/3d_models/mushroom.glb",
          "https://github.com/Ottug-i/Curry_Front/blob/main/flutter/ottugi_curry/assets/3d_models/mushroom_final_7.glb?raw=true",
          scale: math.Vector3(0.2, 0.2, 0.2));
      print('hi');
      bool? didAddWebNode = await arObjectManager!.addNode(newNode);
      webObjectNode = (didAddWebNode!) ? newNode : null;
    }
  }

  Future<void> onFileSystemObjectAtOrigin() async {
    if (fileSystemNode != null) {
      print('hi22');
      arObjectManager!.removeNode(fileSystemNode!);
      fileSystemNode = null;
    } else {
      print('hi1');
      var newNode = ARNode(
          type: NodeType.fileSystemAppFolderGLB,
          uri: "LocalMushroom.glb",
          scale: math.Vector3.all(0.08),
          rotation: math.Vector4(0, 0, 0, 0),
          position: math.Vector3(0, 0.4, 0.4),
          // transformation: Matrix4.rotationY(-30)
      );

      bool? didAddFileSystemNode = await arObjectManager!.addNode(newNode);
      fileSystemNode = (didAddFileSystemNode!) ? newNode : null;
    }
  }

  Future<void> takeScreenshot(context) async {
    final image = await screenshotController.capture();

    if (image == null) {
      // null 방지
      return print("takeScreenshot 오류 발생. $image");
    }
    // await saveImage(image);
    // ignore: use_build_context_synchronously
    await showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            insetPadding: const EdgeInsets.all(40),
            backgroundColor: Colors.white,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: MemoryImage(image), fit: BoxFit.cover)),
                ),
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
                                    bool result = await saveImage(image);

                                    if (result) {
                                      Get.showSnackbar(
                                        const GetSnackBar(
                                          title: '저장 성공',
                                          message: '기기에 사진을 저장했습니다.',
                                          icon: Icon(
                                            Icons.tag_faces,
                                            color: Colors.white,
                                          ),
                                          backgroundColor: Colors.green,
                                          duration: Duration(seconds: 3),
                                        ),
                                      );
                                    } else {
                                      Get.showSnackbar(const GetSnackBar(
                                        title: '저장 실패',
                                        message:
                                            '사진 저장에 실패했습니다. 화면에 재접속하여 새로고침 후 다시 시도해주세요.',
                                        icon: Icon(
                                            Icons.sentiment_very_dissatisfied,
                                            color: Colors.white),
                                        backgroundColor: Colors.red,
                                        duration: Duration(seconds: 3),
                                      ));
                                    }
                                  },
                                  backgroundColor: lightColorScheme.primary,
                                  foregroundColor: Colors.black,
                                  shape: const CircleBorder(),
                                  child: const Icon(Icons.download),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                FloatingActionButton(
                                  onPressed: () => sharePicture(image),
                                  backgroundColor: lightColorScheme.primary,
                                  foregroundColor: Colors.black,
                                  shape: const CircleBorder(),
                                  child: const Icon(Icons.share),
                                ),
                              ],
                            ),
                          ]),
                    )),
                Positioned(
                  top: 10,
                  right: 10,
                  child: IconButton(
                    color: Colors.white,
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      // Dialog를 닫기 위한 로직을 추가하세요.
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          );
        });
  }

  Future<bool> savePicture(image) async {
    final result = await saveImage(image);
    return result;
  }

  Future<bool> saveImage(Uint8List bytes) async {
    await [Permission.storage].request();

    final time = DateTime.now()
        .toIso8601String()
        .replaceAll('.', '-')
        .replaceAll(':', '-');
    final name = 'screenshot_$time';
    final result = await ImageGallerySaver.saveImage(bytes, name: name);
    print(">>>Raw result: $result");

    if (result != null && result['isSuccess']) {
      return result['isSuccess'];
    } else {
      return false;
    }
  }

  Future sharePicture(Uint8List bytes) async {
    final directory = await getApplicationDocumentsDirectory();
    final image = File('${directory.path}/flutter.png');
    image.writeAsBytesSync(bytes);

    await Share.shareXFiles([XFile(image.path)]);
    // await Share.shareFiles([image.path]);
  }

  Future saveAndShare(Uint8List bytes) async {
    final directory = await getApplicationDocumentsDirectory();
    final image = File('${directory.path}/flutter.png');
    image.writeAsBytesSync(bytes);

    await Share.shareXFiles([XFile(image.path)]);
    // await Share.shareFiles([image.path]);
  }
}
