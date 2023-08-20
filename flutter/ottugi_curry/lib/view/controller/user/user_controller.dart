import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:ottugi_curry/config/config.dart';
import 'package:ottugi_curry/config/dio_config.dart';
import 'package:ottugi_curry/model/lately_response.dart';
import 'package:ottugi_curry/model/user_response.dart';
import 'package:ottugi_curry/repository/lately_repository.dart';
import 'package:ottugi_curry/repository/user_repository.dart';
import 'package:ottugi_curry/utils/user_profile_utils.dart';
import 'package:ottugi_curry/view/controller/login/login_controller.dart';

class UserController extends GetxController {
  RxInt userId = 0.obs;
  RxString email = ''.obs;
  RxString nickName = ''.obs;

  final RxList<LatelyResponse> latelyList = <LatelyResponse>[].obs;

  // 회원 정보 수정
  Future<void> updateUserNickName(String newNickName) async {
    try {
      final dio = createDio();
      UserRepository userRepository = UserRepository(dio);
      final resp = await userRepository.setProfile(UserResponse(id: getUserId(), nickName: newNickName));
      print('print newNickName: ${resp.nickName}');
      // 변경된 닉네임 저장
      await userStorage.setItem(Config.nickName, resp.nickName.toString());
      nickName.value =  resp.nickName.toString();
    } on DioException catch (e) {
      print('updateUserNickName: $e');
      return;
    }
  }

  // 최근 본 레시피
  Future<void> loadLatelyRecipe() async {
    try {
      final dio = createDio();
      LatelyRepository latelyRepository = LatelyRepository(dio);

      final resp = await latelyRepository.getLatelyList(getUserId());
      latelyList.value = resp;
    } on DioException catch (e) {
      print('loadLatelyRecipe: $e');
      return;
    }
  }

  // 회원 탈퇴
  Future<void> handleWithdraw() async {
    try {
      final dio = createDio();
      UserRepository userRepository = UserRepository(dio);
      // print('print userIdValue: ${userId.value}');
      bool resp = await userRepository.setWithdraw(getUserId());
      if (resp) {
        Get.find<LoginController>().handleLogout();
      }
    } on DioException catch (e) {
      print('handleWithdraw: $e');
      return;
    }
  }
}