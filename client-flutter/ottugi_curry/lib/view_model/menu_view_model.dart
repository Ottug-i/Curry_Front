import 'package:get/get.dart';
import 'package:ottugi_curry/model/menu.dart';

class MenuViewModel extends GetxController {
  var menuList = <MenuModel>[].obs;

  //List<Menu> get menuList => _menuList;

  @override // GetxController에서 복사해온 메서드
  void onInit() {
    super.onInit();
    fetchData();
  }

  void fetchData() {
    var menuData = [
      MenuModel(
          name: '시저 샐러드',
          time: '10분',
          difficulty: '왕초보',
          composition: '가볍게',
          ingredients:
              '닭가슴살 250 g, 마늘 2~3쪽, 메추리알 12개, 베이컨 4장, 로메인상추 적당히, 계란노른자 1개, 엔초비 1.5스푼',
          seasoning:
              '소금 약간, 후추 약간, 올리브 오일 3~4스푼, 머스터드소스 0.2스푼, 레몬즙 1.5스푼, 땅콩기름 7~8스푼, 파마산치즈 30 g'),
      MenuModel(
          name: '치킨마요',
          time: '30분',
          difficulty: '초급',
          composition: '가볍게',
          ingredients: '샐러드  적당히,  계란  2개',
          seasoning: '  마요네즈  적당히,  스테이크 소스  적당히'),
      MenuModel(
          name: '계란말이',
          time: '10분',
          difficulty: '초급',
          composition: '가볍게',
          ingredients: '계란  4개,  당근 (다진것)  3숟가락,  대파 (송송썬것)  2숟가락, 양파  1/4개(대)',
          seasoning: '소금  1ts,  식용유  3숟가락'),
      MenuModel(
          name: '소세지 콘감자 크로켓',
          time: '20분',
          difficulty: '중급',
          composition: '가볍게',
          ingredients:
              '소세지  4개 , 감자 삶은것  2개,  빵가루  25 g,  밀가루  10 g,  양파  1/4 개(대),  계란  1 개,  옥수수통조림  180 g'),
      MenuModel(
          name: '감자전',
          time: '30분',
          difficulty: '중급',
          composition: '든든하게',
          ingredients: '감자  적당히,  파  적당히, 부추  적당히, 올리브유  적당히, 소금  적당히',
          seasoning: '진간장  적당히, 식초  적당히, 고추가루  적당히'),
      MenuModel(
          name: '두부스테이크',
          time: '40분',
          difficulty: '고급',
          composition: '든든하게',
          ingredients:
              '두부  1 모,  닭가슴살  한 조각,  당근  1/3 개,  양파  1/2 개(대),  대파  1/2 개',
          seasoning:
              '<양념> 감자전분  3 숟가락,  소금  적당히,  후추  적당히,  계란  1 개,  빵가루  한 컵,  참기름  1/2 숟가락,  <데리야끼소스 양념>,  진간장  1/2 컵,  건다시마  1 조각,  백설탕  4 숟가락,  대파  적당히,  물  300ml,  양파  1/10 개(대),  마늘  2 쪽(대),  생강가루(생강) 2 숟가락, 미림(소주)  2 숟가락, 사과  1/10 개(중)  녹말물약간  적당히')
    ];

    menuList.assignAll(menuData);
  }
  /*void fetchData() async {
    // http 클라이언트와 데이터들을 불러와야 함
    var products = await Services.fetchProducts();
    if (products != null) {
      productList.value = products;
    }
  }*/
}
