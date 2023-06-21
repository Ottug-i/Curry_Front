import 'package:get/get.dart';
import 'package:ottugi_curry/view/controller/recipe_detail/recipe_detail_controller.dart';

// 수직바 포함된 문자열을 리스트로 분핧하기
List<String> splitToVerBar(String longText) {
 longText = longText.replaceFirst('|', '');
 return longText.split('|');
}

// 대괄호(제목)와 수직바(내용) 포함된 문자열을 제목 리스트와 내용 리스트로 분할하기
void splitTitleAndContent(String longText, RxList<String> titleList, RxList<String> contentList) {
 longText = longText.replaceFirst('[', '');
 List<String> text = longText.split(' [');
 List<String> titleText = [];
 List<String> contentText = [];

 text.map((e) {
  List<String> unitText = e.split('] ');
  // unitText.length == 1 이면 대괄호(제목 없음)
  if (unitText.length == 1) {
   // 내용만 저장
   contentText = unitText[0].replaceFirst('|', '').split('|');
  } else if (unitText.length > 1) { // unitText.length > 1 이면 대괄호 있음
   // 제목과 내용 저장
   titleText.add(unitText[0]);
   contentText.add(unitText[1]);
  }
 }).toList();

 titleList.value = titleText;
 contentList.value = contentText;
}

void splitIngredientsContent() {
 final controller = Get.find<RecipeDetailController>();
 controller.ingredientsContentList.clear();

 controller.ingredientsContent.map((e) {
  controller.ingredientsContentList.add(e.split('| '));
 }).toList();
}
