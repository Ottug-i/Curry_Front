import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:ottugi_curry/config/config.dart';
import 'package:ottugi_curry/model/lately_response.dart';
import 'package:ottugi_curry/model/user.dart';
import 'package:ottugi_curry/repository/lately_repository.dart';
import 'package:ottugi_curry/repository/user_repository.dart';

class UserController extends GetxController {
  RxInt userId = 0.obs;
  RxString email = ''.obs;
  RxString nickName = ''.obs;

  final RxList<LatelyResponse> latelyList = RxList<LatelyResponse>([]);

  void updateUserNickName(String newNickName) async {
    try {
      Dio dio = Dio();
      UserRepository userRepository = UserRepository(dio);
      print('getUserid ${getUserId()}');
      final resp = await userRepository.setProfile(User(id: userId.value, nickName: newNickName));
      print(resp.nickName);
      userStorage.setItem('nickName', resp.nickName.toString());
      nickName.value =  resp.nickName.toString();
    } on DioError catch (e) {
      print('updateUserNickName: $e');
      return;
    }
  }

  void handleLatelyRecipe() async {
    try {
      Dio dio = Dio();
      LatelyRepository latelyRepository = LatelyRepository(dio);

      final resp = await latelyRepository.getLatelyAll(userId.value);
      latelyList.value = resp;
    } on DioError catch (e) {
      print('handleLatelyRecipe: $e');
      return;
    }
  }

  void handleLogout() async {
    // userStorage.deleteItem('id');
    await tokenStorage.delete(key: 'token');

    Get.offAndToNamed('/login');
  }

  void handleWithdraw() {

  }

}