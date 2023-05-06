
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:ottugi_curry/config/config.dart';
import 'package:ottugi_curry/model/lately_response.dart';
import 'package:ottugi_curry/repository/lately_repository.dart';

class UserController {
  final RxList<LatelyResponse> latelyList = RxList<LatelyResponse>([]);

  void handleLatelyRecipe() async {
    try {
      Dio dio = Dio();
      LatelyRepository latelyRepository = LatelyRepository(dio);

      final resp = await latelyRepository.getLatelyAll(1);
      latelyList.value = resp;
    } on DioError catch (e) {
      print('DioError: $e');
    }
  }

  void handleLogout() async {
    await userSecureStorage.delete(key: 'id');
    await userSecureStorage.delete(key: 'token');

    Get.offAndToNamed('/login');
  }

  void handleWithdraw() {

  }

}