import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ottugi_curry/view/controller/recipe_detail/recipe_detail_controller.dart';

Widget recipeDetailTextListViewWidget() {
  Get.put(RecipeDetailController());
  final recipeDetailController = Get.find<RecipeDetailController>();

  return Expanded(
    child: ListView.builder(
        padding: const EdgeInsets.only(top: 10, bottom: 0),
        shrinkWrap: true,
        itemCount: recipeDetailController.orders.length,
        itemBuilder: (BuildContext context, int idx) {
          return Padding(
              padding: const EdgeInsets.only(bottom: 3),
              child: Text(recipeDetailController.orders[idx]));
        }),
  );
}