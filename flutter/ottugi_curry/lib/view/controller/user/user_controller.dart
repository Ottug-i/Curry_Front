import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:ottugi_curry/config/config.dart';
import 'package:ottugi_curry/model/lately_response.dart';
import 'package:ottugi_curry/model/user.dart';
import 'package:ottugi_curry/repository/lately_repository.dart';
import 'package:ottugi_curry/repository/user_repository.dart';
import 'package:ottugi_curry/utils/user_profile_utils.dart';

class UserController {
  final RxList<LatelyResponse> latelyList = RxList<LatelyResponse>([]);

  void updateUserNickname(String newNickname) async {
    try {
      Dio dio = Dio();
      UserRepository userRepository = UserRepository(dio);
      print('getUserid ${getUserId()}');
      final resp = await userRepository.setProfile(User(id: getUserId(), nickname: newNickname));
      print(resp.nickname);
      userStorage.setItem('nickname', resp.nickname.toString());
    } on DioError catch (e) {
      print('$e');
      return;
    }
  }

  void handleLatelyRecipe() async {
    try {
      Dio dio = Dio();
      LatelyRepository latelyRepository = LatelyRepository(dio);

      final resp = await latelyRepository.getLatelyAll(1);
      latelyList.value = resp;
    } on DioError catch (e) {
      print('$e');
      return;
    }
  }

  void handleLogout() async {
    userStorage.deleteItem('id');
    await tokenStorage.delete(key: 'token');

    Get.offAndToNamed('/login');
  }

  void handleWithdraw() {

  }

}