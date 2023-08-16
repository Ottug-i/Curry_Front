import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:ottugi_curry/view/comm/default_layout_widget.dart';
import 'package:ottugi_curry/view/page/recipe_camera/result_check_page.dart';

class TakePicturePage extends StatefulWidget {
  const TakePicturePage({
    super.key,
    required this.camera,
  });

  final CameraDescription camera;

  @override
  TakePicturePageState createState() => TakePicturePageState();
}

class TakePicturePageState extends State<TakePicturePage> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    print("widget.camera: ${widget.camera}");
    super.initState();
    // 카메라 output 확인하기 위해 controller 생성
    _controller = CameraController(
      // 가능한 카메라 목록에서 특정 카메라 가져옴
      widget.camera,
      // 해상도 지정
      ResolutionPreset.max,
    );

    // controller 초기화. Future를 반환한다.
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    //위젯이 dispose되면 controller도 해제
    _controller.dispose();
    super.dispose();
  }

  void takePicture() async {
    // try-catch 문에서 사진을 찍는다. 오류가 생기면 catch에서 잡을 것.
    try {
      // 카메라가 초기화 되었는지 확인
      await _initializeControllerFuture;

      // 사진을 찍고 저장된 image 파일을 가져옴
      final image = await _controller.takePicture();

      if (!mounted) return;

      // 사진이 찍혔으면 새로운 화면에 띄운다.
      await Navigator.of(context).push(
        MaterialPageRoute(
            builder: (context) => DefaultLayoutWidget(
                  backToMain: true,
                  appBarTitle: '촬영 결과 확인',
                  body: ResultCheck(
                    // DisplayPictureScreen 위젯에 자동생성된 위치 전달.
                    imagePath: image.path,
                  ),
                )),
      );
    } catch (e) {
      // 오류 발생 시 log에 에러 메세지 출력
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Take a picture')),
      // 카메라 미리보기를 displaying하기 전에 controller가 초기화 되기를 기다려야 함.
      // controller 초기화가 끝나기 전까지 FutureBuilder를 사용해서 로딩 스피너를 띄운다.
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // Future가 끝나면, 미리보기를 표시한다.
            return CameraPreview(_controller);
          } else {
            // 그렇지 않으면, 로딩 인디케이터를 띄운다.
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          takePicture();
        },
        child: const Icon(Icons.camera_alt),
      ),
    );
  }
}
