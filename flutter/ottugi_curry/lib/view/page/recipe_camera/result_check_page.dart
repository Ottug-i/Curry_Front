import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ottugi_curry/view/controller/list/recipe_list_controller.dart';
import 'package:ottugi_curry/view/page/recipe_camera/ingredient_dialog.dart';

class ResultCheck extends StatefulWidget {
  final String imagePath;
  const ResultCheck({super.key, required this.imagePath});

  @override
  State<ResultCheck> createState() => _ResultCheckState();
}

class _ResultCheckState extends State<ResultCheck> {
  // 인식 결과로 받아온 변수
  var ingredient = ["달걀", "베이컨", "감자", "치즈"];

  final dataKey = GlobalKey(); // 스크롤 포커싱을 위한 변수

  final RecipeListController rListController = Get.put(RecipeListController());

  @override
  void initState() {
    super.initState();
    // 인식 결과로 받아온 변수를 controller에 저장
    rListController.setIngredientList(ingredient);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            flex: 5,
            child: //Image.file(File(widget.imagePath)),
                Image.asset(
              widget.imagePath,
              fit: BoxFit.fitHeight,
            )),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return StatefulBuilder(
                      builder: (BuildContext context, StateSetter setState) {
                        return const IngredientDialog();
                      },
                    );
                  },
                );
              },
              child: const Text('수정'),
            ),
            const SizedBox(
              width: 10,
            ),
            ElevatedButton(
              onPressed: () {
                // 모달창을 열지 않고 바로 완료를 눌렀을 때까지 커버함
                rListController.changeIngredients();
                // 리스트 페이지로 이동
                Get.toNamed('/camera_rec');
              },
              child: const Text('완료'),
            )
          ],
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
