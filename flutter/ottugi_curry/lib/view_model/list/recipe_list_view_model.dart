import 'package:get/get.dart';
import 'package:ottugi_curry/model/recipe.dart';

class RecipeListViewModel extends GetxController {
  var recipeList = <Recipe>[].obs;

  Rx<String> selectedCategory = 'null'.obs;
  Rx<String> selectedCategoryValue = '0'.obs;

  @override // GetxController에서 복사해 온 메서드
  void onInit() {
    super.onInit();
    fetchData();
  }

/*void fetchData() async {
    //Future<List<Recipe>> fetchData() async
    // http 클라이언트와 데이터들을 불러와야 함
    // 지금은 param이 없지만 param는 인식된 재료여야 함
    var url = Uri.parse('http://10.0.2.2:8000/api/recipe/getRecipeList');
    var data = {
      "userId": 1,
      "recipeId": [6855278, 6909678]
    };

    http.Response response = await http
        .post(url,
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
  }*/

  void fetchData() {
    var menuData = [
      Recipe(
          name: '치즈 계란말이',
          time: '10',
          difficulty: '초급',
          composition: '가볍게',
          ingredients: '계란, 치즈, 당근, 대파, 양파',
          thumbnail: 'eggroll.png',
          isBookmark: true),
      Recipe(
          name: '치즈 감자전',
          time: '30',
          difficulty: '중급',
          composition: '든든하게',
          ingredients: '감자, 파, 부추, 올리브유, 소금, 모짜렐라 치즈',
          thumbnail: 'cheesePotato.png',
          isBookmark: false),
      Recipe(
          name: '시저 샐러드',
          time: '10',
          difficulty: '왕초보',
          composition: '가볍게',
          ingredients:
              '닭가슴살, 마늘, 메추리알, 베이컨, 로메인상추, 계란노른자, 엔초비, 치즈',
          thumbnail: 'salad.jpg',
          isBookmark: false),
      Recipe(
          name: '치킨마요',
          time: '30',
          difficulty: '초급',
          composition: '가볍게',
          ingredients: '순살치킷(너겟), 양파, 계란, 김가루, 마요네즈',
          thumbnail: 'chicken-mayo.jpg',
          isBookmark: false),
      Recipe(
          name: '소세지 콘감자 크로켓',
          time: '20',
          difficulty: '중급',
          composition: '가볍게',
          ingredients:
              '소세지, 감자 삶은것, 빵가루, 밀가루, 양파, 계란, 옥수수통조림',
          thumbnail: 'sausageCorn.png',
          isBookmark: true),
      Recipe(
          name: '두부스테이크',
          time: '40',
          difficulty: '고급',
          composition: '든든하게',
          ingredients:
              '두부, 닭가슴살, 당근, 양파, 대파, 계란',
          thumbnail: 'tofuSteak.png',
          isBookmark: false)
    ];
    recipeList.assignAll(menuData);
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
