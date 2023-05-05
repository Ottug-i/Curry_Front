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

  void fetchData() async {
    //Future<List<Recipe>> fetchData() async
    // http 클라이언트와 데이터들을 불러와야 함
    // 지금은 param이 없지만 param는 인식된 재료여야 함
    var url = Uri.parse('http://10.0.2.2:8080/api/recipe/getRecipeList');
    var data = {
      "userId": 1,
      "recipeId": [6855278, 6909678]
    };

    http.Response response = await http.post(url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(data));

    if (response.statusCode == 200) {
      List result = jsonDecode(response.body) as List;
      var menuData = result.map((e) => Recipe.fromJson(e)).toList();
      print(menuData);
      recipeList.assignAll(menuData);
    } else {
      throw Exception('Failed to load album');
    }
  }

  /*void fetchData() {
    var menuData = [
      Recipe(
          name: '시저 샐러드',
          time: '10',
          difficulty: '왕초보',
          composition: '가볍게',
          ingredients:
          '닭가슴살 250 g, 마늘 2~3쪽, 메추리알 12개, 베이컨 4장, 로메인상추 적당히, 계란노른자 1개, 엔초비 1.5스푼',
          thumbnail: 'egg-benedict.jpeg'),
      Recipe(
          name: '치킨마요',
          time: '30',
          difficulty: '초급',
          composition: '가볍게',
          ingredients: '샐러드  적당히,  계란  2개',
          thumbnail: 'hangtown-fry.jpeg'),
      Recipe(
          name: '계란말이',
          time: '10',
          difficulty: '초급',
          composition: '가볍게',
          ingredients: '계란  4개,  당근 (다진것)  3숟가락,  대파 (송송썬것)  2숟가락, 양파  1/4개(대)',
          thumbnail: 'sandwich.jpeg'),
      Recipe(
          name: '소세지 콘감자 크로켓',
          time: '20',
          difficulty: '중급',
          composition: '가볍게',
          ingredients:
          '소세지  4개 , 감자 삶은것  2개,  빵가루  25 g,  밀가루  10 g,  양파  1/4 개(대),  계란  1 개,  옥수수통조림  180 g',
          thumbnail: 'taco.jpeg'),
      Recipe(
          name: '감자전',
          time: '30',
          difficulty: '중급',
          composition: '든든하게',
          ingredients: '감자  적당히,  파  적당히, 부추  적당히, 올리브유  적당히, 소금  적당히',
          thumbnail: 'taco.jpeg'),
      Recipe(
          name: '두부스테이크',
          time: '40',
          difficulty: '고급',
          composition: '든든하게',
          ingredients:
          '두부  1 모,  닭가슴살  한 조각,  당근  1/3 개,  양파  1/2 개(대),  대파  1/2 개',
          thumbnail: 'egg-benedict.jpeg')
    ];
    recipeList.assignAll(menuData);
  }*/

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
