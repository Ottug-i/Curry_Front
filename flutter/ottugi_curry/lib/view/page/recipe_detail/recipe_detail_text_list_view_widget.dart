import 'package:flutter/cupertino.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:ottugi_curry/view/controller/recipe_detail/recipe_detail_controller.dart';

// Expanded recipeDetailTextListViewWidget() {
//   Get.put(RecipeDetailController());
//   final recipeDetailController = Get.find<RecipeDetailController>();
//
//   return Expanded(
//     child: ListView.builder(
//         padding: const EdgeInsets.only(top: 10, bottom: 0),
//         shrinkWrap: true,
//         itemCount: recipeDetailController.orders.length,
//         itemBuilder: (BuildContext context, int idx) {
//           // tts.speak(recipeDetailController.orders[idx]);
//           return Padding(
//               padding: const EdgeInsets.only(bottom: 3),
//               child: Text(recipeDetailController.orders[idx]));
//         }),
//   );
// }

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
            // recipeDetailController.tts.value.speak(recipeDetailController.orders.toString());
            // recipeDetailController.speakTTS(recipeDetailController.orders.toString());

            // print('print recipeDetailControllerOrdersIdx: ${recipeDetailController.orders[idx]}');
            // recipeDetailController.speakTTS(recipeDetailController.orders[idx]);
            // if (recipeDetailController.ttsStatus.value == true) {
            //   recipeDetailController.tts.value.speak(recipeDetailController.orders[idx]); // tts 실행
            // } else {
            //   recipeDetailController.tts.value.stop();
            // }
            return Padding(
                padding: const EdgeInsets.only(bottom: 3),
                child: Text(recipeDetailController.ordersList[idx]));
          }),
    );
  }
}
