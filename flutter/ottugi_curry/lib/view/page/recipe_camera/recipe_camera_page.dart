import 'package:flutter/material.dart';
import 'package:ottugi_curry/view/comm/default_layout_widget.dart';
import 'package:ottugi_curry/view/page/list/recipe_recs_list.dart';

class RecipeCameraPage extends StatelessWidget {
  const RecipeCameraPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const DefaultLayoutWidget(
        appBarTitle: '촬영 결과 확인', body: ResultCheck());
  }
}

class ResultCheck extends StatefulWidget {
  const ResultCheck({super.key});

  @override
  State<ResultCheck> createState() => _ResultCheckState();
}

class _ResultCheckState extends State<ResultCheck> {
  bool _isCheckTuna = false;
  bool _isCheckRice = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            flex: 5,
            child: Image.asset(
              'assets/images/tuna.png',
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
                    barrierDismissible: true,
                    context: context,
                    builder: (context) {
                      return Dialog(
                          child: Center(
                              child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        //mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          checkList('참치', _isCheckTuna, (value) {
                            setState(() {
                              _isCheckTuna = value!;
                            });
                          }),
                          checkList('밥', _isCheckRice, (value) {
                            setState(() {
                              _isCheckRice = value!;
                            });
                          }),
                        ],
                      )));
                    });
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
        value: isCheck,
        onChanged: onChanged,
      ),
      Text(text)
    ],
  );
}
