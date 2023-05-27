import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ottugi_curry/view/comm/default_layout_widget.dart';

class RecipeCameraPage extends StatelessWidget {
  const RecipeCameraPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultLayoutWidget(body: Column(
      children: [
        Text('recipe detail 로 연결'),
        ElevatedButton(onPressed: () {
          Get.toNamed('/recipe_detail');
        }, child: Text('1'))
      ],
    ));
  }
}
