import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ottugi_curry/view/controller/recipe_detail/recipe_detail_controller.dart';

class RecipeDetailTextListViewWidget extends StatefulWidget {
  const RecipeDetailTextListViewWidget({Key? key}) : super(key: key);

  @override
  State<RecipeDetailTextListViewWidget> createState() => _RecipeDetailTextListViewWidgetState();
}

class _RecipeDetailTextListViewWidgetState extends State<RecipeDetailTextListViewWidget> {

  @override
  void initState() {
    super.initState();
    Get.put(RecipeDetailController);
    Get.find<RecipeDetailController>().setTTS(); //TTS 설정
  }

  @override
  Widget build(BuildContext context) {
    Get.put(RecipeDetailController());
    final recipeDetailController = Get.find<RecipeDetailController>();

    return Expanded(
      child: ListView.builder(
          padding: const EdgeInsets.only(top: 10, bottom: 0),
          shrinkWrap: true,
          itemCount: recipeDetailController.ordersList.length,
          itemBuilder: (BuildContext context, int idx) {

            return Padding(
                padding: const EdgeInsets.only(bottom: 3),
                child: Text(recipeDetailController.ordersList[idx]));
          }),
    );
  }
}