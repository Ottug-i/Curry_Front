import 'package:get/get.dart';
import 'package:ottugi_curry/model/menu.dart';
import 'package:ottugi_curry/view_model/list/service.dart';

class MenuViewModel extends GetxController {
  var menuList = <MenuModel>[].obs;

  Rx<String> selectedCategory = 'null'.obs;
  Rx<String> selectedCategoryValue = '0'.obs;

  void updateCategory(String category) {
    selectedCategory.value = category;
    update(); // rebuild 하게 함
  }

  void updateCategoryValue(String newvalue) {
    selectedCategoryValue.value = newvalue;
    update();
  }

  bool checkData(MenuModel e) {
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
    var filterData = menuList.where((element) => checkData(element)).toList();
    print(filterData.length);
    menuList.assignAll(filterData);
    //update();
  }

  @override // GetxController에서 복사해온 메서드
  void onInit() {
    super.onInit();
    fetchData();
  }

  void fetchData() async {
    // http 클라이언트와 데이터들을 불러와야 함
    // 지금은 param이 없지만 param는 인식된 재료여야 함
    var products = await Services.fetchMenus();
    if (products != null) {
      //menuList.value = products;
      menuList.assignAll(products);
    }
  }

/*
  void fetchData() {
    var menuData = [
      MenuModel(
          name: '시저 샐러드',
          time: '10',
          difficulty: '왕초보',
          composition: '가볍게',
          ingredients:
              '닭가슴살 250 g, 마늘 2~3쪽, 메추리알 12개, 베이컨 4장, 로메인상추 적당히, 계란노른자 1개, 엔초비 1.5스푼',
          seasoning:
              '소금 약간, 후추 약간, 올리브 오일 3~4스푼, 머스터드소스 0.2스푼, 레몬즙 1.5스푼, 땅콩기름 7~8스푼, 파마산치즈 30 g',
          photo: 'egg-benedict.jpeg'),
      MenuModel(
          name: '치킨마요',
          time: '30',
          difficulty: '초급',
          composition: '가볍게',
          ingredients: '샐러드  적당히,  계란  2개',
          seasoning: '  마요네즈  적당히,  스테이크 소스  적당히',
          photo: 'hangtown-fry.jpeg'),
      MenuModel(
          name: '계란말이',
          time: '10',
          difficulty: '초급',
          composition: '가볍게',
          ingredients: '계란  4개,  당근 (다진것)  3숟가락,  대파 (송송썬것)  2숟가락, 양파  1/4개(대)',
          seasoning: '소금  1ts,  식용유  3숟가락',
          photo: 'sandwich.jpeg'),
      MenuModel(
          name: '소세지 콘감자 크로켓',
          time: '20',
          difficulty: '중급',
          composition: '가볍게',
          ingredients:
              '소세지  4개 , 감자 삶은것  2개,  빵가루  25 g,  밀가루  10 g,  양파  1/4 개(대),  계란  1 개,  옥수수통조림  180 g',
          photo: 'taco.jpeg'),
      MenuModel(
          name: '감자전',
          time: '30',
          difficulty: '중급',
          composition: '든든하게',
          ingredients: '감자  적당히,  파  적당히, 부추  적당히, 올리브유  적당히, 소금  적당히',
          seasoning: '진간장  적당히, 식초  적당히, 고추가루  적당히',
          photo: 'taco.jpeg'),
      MenuModel(
          name: '두부스테이크',
          time: '40',
          difficulty: '고급',
          composition: '든든하게',
          ingredients:
              '두부  1 모,  닭가슴살  한 조각,  당근  1/3 개,  양파  1/2 개(대),  대파  1/2 개',
          seasoning:
              '<양념> 감자전분  3 숟가락,  소금  적당히,  후추  적당히,  계란  1 개,  빵가루  한 컵,  참기름  1/2 숟가락,  <데리야끼소스 양념>,  진간장  1/2 컵,  건다시마  1 조각,  백설탕  4 숟가락,  대파  적당히,  물  300ml,  양파  1/10 개(대),  마늘  2 쪽(대),  생강가루(생강) 2 숟가락, 미림(소주)  2 숟가락, 사과  1/10 개(중)  녹말물약간  적당히',
          photo: 'egg-benedict.jpeg')
    ];

    menuList.assignAll(menuData);
  }
  */

}
