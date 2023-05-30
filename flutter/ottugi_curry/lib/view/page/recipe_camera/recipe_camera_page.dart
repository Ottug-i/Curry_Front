import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ottugi_curry/view/comm/default_layout_widget.dart';
import 'package:ottugi_curry/view/page/list/recipe_recs_list.dart';

class RecipeCameraPage extends StatelessWidget {
  const RecipeCameraPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultLayoutWidget(
        body: Column(
      children: [
        const Text('recipe detail 로 연결(임시)'),
        ElevatedButton(
            onPressed: () {
              Get.toNamed('/recipe_detail',
                  arguments: 6909678); // 6909678 // 6916853
            },
            child: const Text('1'))
      ],
    ));
  }
}

class ResultCheck extends StatefulWidget {
  const ResultCheck({super.key});

  @override
  State<ResultCheck> createState() => _ResultCheckState();
}

class _ResultCheckState extends State<ResultCheck> {
  bool _isCheckTuna = true;
  bool _isCheckRice = true;
  bool _isCheckCheese = true;

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
                                  checkList('감자', _isCheckTuna, (value) {
                                    setState(() {
                                      _isCheckTuna = value!;
                                    });
                                  }),
                                  checkList('치즈', _isCheckRice, (value) {
                                    setState(() {
                                      _isCheckRice = value!;
                                    });
                                  }),
                                  checkList('계란', _isCheckCheese, (value) {
                                    setState(() {
                                      _isCheckCheese = value!;
                                    });
                                  }),
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
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RecipeRecs()));
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
