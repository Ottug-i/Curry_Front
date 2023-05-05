import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ottugi_curry/model/menu.dart';

class Services {
  // static? - 서버 연결하고 닫을 때마다 http 클라이언트를 생성하는 것은 비효율적
  static var client = http.Client();

  static Future<List<MenuModel>?> fetchMenus() async {
    print('fetchMenus 함수 실행');
    // 데이터를 받은 후에 실행되어야 할 메소드

    var client = http.Client();
    //const Uri.parse('http://localhost:8080/api/recipe/getRecipeList');
    try {
      /*var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      var uri = Uri.parse(decodedResponse['uri'] as String);

      await client.get(uri);
      print(response.statusCode);*/

      var url = Uri.parse('http://localhost:8080/api/recipe/getRecipeList');

      http.Response response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: <String, String>{
          'userId': '1',
          'recipeId': jsonEncode(['6855278', '6909678'])
        },
      );

      if (response.statusCode == 200) {
        // 데이터가 성공적으로 들어왔는가?
        var jsonData = response.body;
        return productFromJson(jsonData);
      } else {
        return null;
      }
    } finally {
      client.close();
    }
/*
    var listdata = {
      "userId": '1',
      "recipeId": jsonEncode(['6855278', '6909678'])
    };
    var response = await client.post(
        Uri.parse('http://localhost:8080/api/recipe/getRecipeList'),
        headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: listdata);
*/
  }
}
