import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ottugi_curry/config/color_schemes.dart';
import 'package:ottugi_curry/view/controller/list/recipe_list_controller.dart';
import 'package:ottugi_curry/view/comm/default_layout_widget.dart';

class RecipeCameraPage extends StatelessWidget {
  const RecipeCameraPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const DefaultLayoutWidget(
      backToMain: true,
        appBarTitle: '촬영 결과 확인', body: ResultCheck());
  }
}

class ResultCheck extends StatefulWidget {
  const ResultCheck({super.key});

  @override
  State<ResultCheck> createState() => _ResultCheckState();
}

class _ResultCheckState extends State<ResultCheck> {
  // 인식 결과로 받아온 변수
  var ingredient = ["달걀", "베이컨", "감자", "치즈"];

  late final RecipeListController rListController;

  @override
  void initState() {
    super.initState();
    rListController = Get.put(RecipeListController());
    // 인식 결과로 받아온 변수를 controller에 저장
    rListController.setIngredientList(ingredient);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            flex: 5,
            child: Image.asset(
              'assets/images/ingredients.png',
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
                        return Dialog(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const Text('촬영한 재료가 아니라면 선택을 해제하세요.'),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Column(
                                      children: rListController
                                          .ingredientList
                                          .map((favorite) {
                                    return CheckboxListTile(
                                        activeColor: lightColorScheme.primary,
                                        checkboxShape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        value: favorite["isChecked"],
                                        title: Text(favorite["name"],
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium),
                                        onChanged: (val) {
                                          setState(() {
                                            favorite["isChecked"] = val;
                                          });
                                        });
                                  }).toList()),
                                  SizedBox(
                                    width: 100,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('완료'),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
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

void init() {
  // 인자로 재료들이 들어오면
  // check 여부를 저장하고 전달할 변수 생성
}

Row checkList(String text, bool isCheck, ValueChanged<bool?> onChanged) {
  return Row(
    children: [
      Checkbox(
        checkColor: Colors.white,
        // fillColor: MaterialStateProperty.resolveWith(getColor),
        value: isCheck,
        onChanged: onChanged,
      ),
      Text(text)
    ],
  );
}
