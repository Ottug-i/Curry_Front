import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:ottugi_curry/config/color_schemes.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

class ArCameraController {
  Rx<ScreenshotController> screenshotController = ScreenshotController().obs;

  Future<void> takeScreenshot(context) async {
    Uint8List? image = await screenshotController.value.capture();

    if (image == null) {
      // null 방지
      return print("takeScreenshot 오류 발생. $image");
    }
    print('print image: ${image}');
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
                                  onPressed: () => sharePicture(image, context),
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

  // Future<bool> savePicture(image) async {
  //   final result = await saveImage(image);
  //   return result;
  // }

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

  Future sharePicture(Uint8List bytes, context) async {
    final directory = await getApplicationDocumentsDirectory();
    final image = File('${directory.path}/flutter.png');
    image.writeAsBytesSync(bytes);

    final box = context.findRenderObject() as RenderBox?;

    await Share.shareXFiles([XFile(image.path)],
        // iPad 추가 설정
        sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,);
    // await Share.shareFiles([image.path]);
  }
  //
  // Future saveAndShare(Uint8List bytes) async {
  //   final directory = await getApplicationDocumentsDirectory();
  //   final image = File('${directory.path}/flutter.png');
  //   image.writeAsBytesSync(bytes);
  //
  //   await Share.shareXFiles([XFile(image.path)]);
  //   // await Share.shareFiles([image.path]);
  // }
}