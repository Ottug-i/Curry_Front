import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ottugi_curry/model/receipe.dart';

class RecipeListViewModel extends GetxController {
  var recipeList = <Recipe>[].obs;

  Rx<String> selectedCategory = 'null'.obs;
  Rx<String> selectedCategoryValue = '0'.obs;


  @override // GetxController에서 복사해 온 메서드
  void onInit() {
    super.onInit();
    fetchData();
  }

  Future<List<Recipe>> fetchData() async {
    // http 클라이언트와 데이터들을 불러와야 함
    // 지금은 param이 없지만 param는 인식된 재료여야 함
    var url = Uri.parse('http://10.0.2.2:8080/api/recipe/get');
    var data = {
      "userId": 1,
      "recipeId": [6855278, 6909678]
    };

    http.Response response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(data)//json.encode(['6855278', '6909678']
    );

    if (response.statusCode == 200) {
      return (jsonDecode(response.body) as List)
          .map((e) => Recipe.fromJson(e))
          .toList();
    } else {
      throw Exception('Failed to load album');
    }
  }

  void updateCategory(String category) {
    selectedCategory.value = category;
    update(); // rebuild 하게 함
  }

  void updateCategoryValue(String newvalue) {
    selectedCategoryValue.value = newvalue;
    update();
  }

  bool checkData(Recipe e) {
    switch (selectedCategory.value) {
      case 'time':
        final datatime = int.tryParse(e.time ?? '0');
        final selctedValue = int.parse(selectedCategoryValue.value);
        if (selctedValue == 30) {
          if (datatime! >= 30) {
            return true;
          } else {
            return false;
          }
        } else if ((selctedValue - 10 < datatime!) &&
            (datatime < selctedValue + 10)) {
          return true;
        } else {
          return false;
        }
      case 'level':
        if (e.difficulty == selectedCategoryValue.value) {
          return true;
        } else {
          return false;
        }

      case 'composition':
        if (e.composition == selectedCategoryValue.value) {
          return true;
        } else {
          return false;
        }
      default:
        return true;
    }
  }

  void updateData() {
    print('updateData 실행');
    var filterData = recipeList.where((element) => checkData(element)).toList();
    print(filterData.length);
    recipeList.assignAll(filterData);
    //update();
  }




}
