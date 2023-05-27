import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:ottugi_curry/config/config.dart';
import 'package:ottugi_curry/model/lately_response.dart';
import 'package:ottugi_curry/model/user_response.dart';
import 'package:ottugi_curry/repository/lately_repository.dart';
import 'package:ottugi_curry/repository/user_repository.dart';
import 'package:ottugi_curry/utils/user_profile_utils.dart';

class UserController extends GetxController {
  RxInt userId = 0.obs;
  RxString email = ''.obs;
  RxString nickName = ''.obs;

  final RxList<LatelyResponse> latelyList = RxList<LatelyResponse>([]);

  Future<void> loadUserProfile() async {
    //현재는 api로 회원정보 불러오는 것보다 storage에 저장한 값을 우선적으로 불러와서 사용중
    try {
      Dio dio = Dio();
      UserRepository userRepository = UserRepository(dio);
      print('getUserid ${getUserId()}');
      final resp = await userRepository.getProfile(getUserId());
      userId.value = resp.id!;
      email.value = resp.email!;
      nickName.value = resp.nickName!;
    } on DioError catch (e) {
      print('updateUserNickName: $e');
      return;
    }
  }

  void updateUserNickName(String newNickName) async {
    try {
      Dio dio = Dio();
      UserRepository userRepository = UserRepository(dio);
      print('getUserid ${getUserId()}');
      final resp = await userRepository.setProfile(UserResponse(id: userId.value, nickName: newNickName));
      print(resp.nickName);
      userStorage.setItem(Config.nickName, resp.nickName.toString());
      nickName.value =  resp.nickName.toString();
    } on DioError catch (e) {
      print('updateUserNickName: $e');
      return;
    }
  }

  Future<void> loadLatelyRecipe() async {
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
    
    userStorage.deleteItem(Config.id);
    userStorage.deleteItem(Config.email);
    userStorage.deleteItem(Config.nickName);

    Get.offAndToNamed('/login');
  }

  void handleWithdraw() {

  }
}