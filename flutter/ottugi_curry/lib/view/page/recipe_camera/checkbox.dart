import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckBoxController extends GetxController {
  RxBool checkValue = false.obs;

  void updateCheckValue(bool value) {
    checkValue.value = value;
  }
}

class CheckboxWidget extends StatelessWidget {
  final String label;
  final CheckBoxController controller;

  const CheckboxWidget(
      {super.key, required this.label, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Row(
        children: [
          Checkbox(
            value: controller.checkValue.value,
            onChanged: (value) {
              controller.updateCheckValue(value!);
            },
          ),
          Text(label),
        ],
      ),
    );
  }
}
