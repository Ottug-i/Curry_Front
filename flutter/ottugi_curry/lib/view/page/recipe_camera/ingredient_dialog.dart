import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ottugi_curry/config/color_schemes.dart';
import 'package:ottugi_curry/view/controller/list/recipe_list_controller.dart';
import 'package:ottugi_curry/view/page/recipe_camera/ShakeAnimation.dart';

class IngredientDialog extends StatefulWidget {
  const IngredientDialog({super.key});

  @override
  _IngredientDialogState createState() => _IngredientDialogState();
}

class _IngredientDialogState extends State<IngredientDialog> {
  final GlobalKey dataKey = GlobalKey(); // 스크롤 포커싱을 위한 변수
  bool isTextFieldError = false;
  final textFieldErrorShakeKey = GlobalKey<ShakeAnimationState>();
  final textController = TextEditingController();
  final rListController = Get.find<RecipeListController>();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(40),
      backgroundColor: Colors.white,
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Obx(
            () => Column(
              children: [
                Text('촬영한 재료가 아니라면 선택을 해제하세요.',
                    style: Theme.of(context).textTheme.bodyMedium),
                Text('추가로 입력한 재료를 삭제하려면 길게 누르세요.',
                    style: Theme.of(context).textTheme.bodySmall),
                const SizedBox(
                  height: 20,
                ),
                Column(
                    children: rListController.ingredientList.map((favorite) {
                  return GestureDetector(
                    onLongPress: () {
                      if (favorite["ableToDelete"]) {
                        HapticFeedback.vibrate();
                        rListController.deleteIngredient(favorite["name"]);
                      }
                    },
                    child: CheckboxListTile(
                        activeColor: lightColorScheme.primary,
                        checkboxShape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        value: favorite["isChecked"],
                        title: Text(favorite["name"],
                            style: Theme.of(context).textTheme.titleMedium),
                        onChanged: (val) {
                          setState(() {
                            favorite["isChecked"] = val;
                          });
                        }),
                  );
                }).toList()),
                if (!rListController.isFull())
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        key: dataKey,
                        child: ShakeAnimation(
                          key: textFieldErrorShakeKey,
                          shakeCount: 3,
                          shakeOffset: 10,
                          child: TextField(
                              onChanged: (text) {
                                setState(() {
                                  isTextFieldError = (text.isEmpty);
                                });
                              },
                              keyboardType: TextInputType.text,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.allow(RegExp(
                                    r'[ㄱ-ㅎ|ㅏ-ㅣ|가-힣|ᆞ|ᆢ|ㆍ|ᆢ|ᄀᆞ|ᄂᆞ|ᄃᆞ|ᄅᆞ|ᄆᆞ|ᄇᆞ|ᄉᆞ|ᄋᆞ|ᄌᆞ|ᄎᆞ|ᄏᆞ|ᄐᆞ|ᄑᆞ|ᄒᆞ]'))
                              ],
                              controller: textController,
                              onTap: () {
                                print('>> Scrollable');
                                Scrollable.ensureVisible(
                                  // 입력 시 스크롤 자동 이동
                                  dataKey.currentContext!,
                                  // duration: const Duration(milliseconds: 300),
                                  // curve: Curves.easeInOut,
                                );
                              },
                              decoration: InputDecoration(
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: const BorderSide(
                                        color: Colors.red, width: 2.0),
                                  ),
                                  border: const OutlineInputBorder(),
                                  hintText: '추가할 식재료',
                                  errorText: isTextFieldError
                                      ? "입력란이 비었습니다." // Error message
                                      : null)),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      IconButton(
                        onPressed: () {
                          if (textController.text.trim().isEmpty) {
                            isTextFieldError = true;
                            print("비었음");
                          } else {
                            isTextFieldError = false;
                            print(textController.text);
                            rListController.setIngredient(textController.text);
                            textController.clear();
                          }
                        },
                        color: Colors.black,
                        highlightColor: lightColorScheme.primary, //<-- SEE HERE
                        iconSize: 20,
                        icon: const Icon(
                          Icons.add,
                        ),
                      ),
                    ],
                  ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: 100,
                  child: ElevatedButton(
                    onPressed: () {
                      isTextFieldError = false;
                      Navigator.of(context).pop();
                    },
                    child: const Text('완료'),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
