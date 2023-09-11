import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:ottugi_curry/config/color_schemes.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

class ARCameraController {
  Rx<ScreenshotController> screenshotController = ScreenshotController().obs;
  RxBool existARNode = false.obs; // AR 모델 추가/삭제 버튼 텍스트 결정

  // (캡쳐 이후) 이미지 바이트 데이터 얻어오기 - iOS
  Future<Uint8List> loadImageData(
      ImageProvider imageProvider, BuildContext context) async {
    // ImageStream을 생성하여 이미지를 로드합니다.
    final ImageStream stream =
        imageProvider.resolve(createLocalImageConfiguration(context));

    // 이미지 데이터를 저장할 변수
    final Completer<Uint8List> completer = Completer<Uint8List>();

    // 이미지가 로드되면 데이터를 추출합니다.
    stream.addListener(
        ImageStreamListener((ImageInfo imageInfo, bool synchronousCall) async {
      final ByteData? byteData =
          await imageInfo.image.toByteData(format: ImageByteFormat.png);
      if (byteData != null) {
        final Uint8List uint8list = byteData.buffer.asUint8List();
        completer.complete(uint8list);
      }
    }));

    return completer.future;
  }

  // 캡쳐하기 - Android
  void captureScreenshot(BuildContext context) async {
    final image = await screenshotController.value.capture();

    if (image == null) {
      // null 방지
      return print("captureScreenshot 오류 발생. $image");
    }

    takeScreenshot(context, image);
  }

  // 캡쳐한 이미지 데이터로 추후 처리 (dialog 보여주기, 저장, 공유)
  Future<void> takeScreenshot(BuildContext context, Uint8List snapshot) async {
    Get.dialog(Dialog(
      insetPadding: const EdgeInsets.all(30),
      backgroundColor: Colors.white,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: MemoryImage(snapshot), fit: BoxFit.cover)),
            // image: snapshot, fit: BoxFit.cover)),
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
                      FloatingActionButton(
                        onPressed: () async {
                          bool result = await saveImage(snapshot);

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
                              icon: Icon(Icons.sentiment_very_dissatisfied,
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
                        onPressed: () => sharePicture(snapshot, context),
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
                Get.back();
              },
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    ));
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

  Future sharePicture(Uint8List bytes, context) async {
    final directory = await getTemporaryDirectory(); // 임시 저장소에 저장
    final image = File('${directory.path}/flutter.png');

    image.writeAsBytesSync(bytes);
    // final box = context.findRenderObject() as RenderBox?;

    await Share.shareXFiles([XFile(image.path)],
        // iPad 추가 설정 - 공유 상자 위치 지정
        sharePositionOrigin: const Rect.fromLTWH(0, 0, 300, 300));
  }
}
