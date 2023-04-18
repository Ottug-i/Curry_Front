// http 클라이언트와 상호 작용하고 데이터 가져오는 파일
import 'package:http/http.dart' as http;

class Services {
  // static? - 서버 연결하고 닫을 때마다 http 클라이언트를 생성하는 것은 비효율적
  static var client = http.Client();

  void fetchData() {}

/*
  static Future<List<MenuModel>?> fetchProducts() async {
    // 데이터를 받은 후에 실행되어야 할 메소드
    var response = await client.get(Uri.parse(
        'http://makeup-api.herokuapp.com/api/v1/products.json?brand=maybelline'));

    if (response.statusCode == 200) {
      // 데이터가 성공적으로 들어왔는가?
      var jsonData = response.body;
      return productFromJson(jsonData);
    } else {
      return null;
    }
  }

*/
}
