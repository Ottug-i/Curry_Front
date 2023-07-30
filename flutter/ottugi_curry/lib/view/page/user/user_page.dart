import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ottugi_curry/config/color_schemes.dart';
import 'package:ottugi_curry/model/lately_response.dart';
import 'package:ottugi_curry/utils/user_profile_utils.dart';
import 'package:ottugi_curry/view/comm/default_layout_widget.dart';
import 'package:ottugi_curry/view/controller/user/user_controller.dart';

class UserPage extends StatelessWidget {
  const UserPage({Key? key}) : super(key: key);

  Future _initUserInfo() async {
    Get.find<UserController>().userId.value = getUserId();
    Get.find<UserController>().email.value = 'smcurry2023@gmail.com'; //수정
    Get.find<UserController>().nickName.value = getUserNickname();
    await Get.find<UserController>().loadLatelyRecipe();
  }

  @override
  Widget build(BuildContext context) {
    Get.put(UserController());
    final userController = Get.find<UserController>();

    return DefaultLayoutWidget(
      appBarTitle: '마이페이지',
      body: FutureBuilder(
          future: _initUserInfo(),
          builder: (context, snap) {
            if (snap.connectionState != ConnectionState.done) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 30, right: 30, top: 10, bottom: 10),
                child: Column(
                  children: [
                    // 프로필
                    Container(
                      padding: const EdgeInsets.only(
                          top: 20, bottom: 20, left: 30, right: 30),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.0),
                        color: Colors.white,
                      ),
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/images/rubberduck.png',
                            fit: BoxFit.fill,
                            height: 75,
                            width: 75,
                          ),
                          const Padding(padding: EdgeInsets.only(right: 25)),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    constraints: const BoxConstraints(
                                      maxWidth: 145,
                                    ),
                                    child: Obx(
                                          () => Text(
                                        userController.nickName.value,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                  const Padding(
                                      padding: EdgeInsets.only(right: 10)),
                                  InkWell(
                                    onTap: () {
                                      // 닉네임 수정
                                      updateUserNickNameDialog();
                                    },
                                    child: const ImageIcon(
                                      AssetImage('assets/icons/revise.png'),
                                      size: 15,
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                width: 150,
                                child: Obx(
                                      () => Text(
                                    userController.email.value,
                                    style:
                                    Theme.of(context).textTheme.titleSmall,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),

                    // 최근 본 레시피
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.only(
                          top: 20, bottom: 20, left: 20, right: 20),
                      margin: const EdgeInsets.only(top: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.0),
                        color: Colors.white,
                      ),
                      child: Obx(
                            () => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '최근 본 레시피',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),

                            // 최근 본 레시피 리스트
                            userController.latelyList.isNotEmpty
                                ? SizedBox(
                              height: 180,
                              child: ListView.builder(
                                  padding: const EdgeInsets.only(
                                      top: 14, bottom: 14),
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount:
                                  userController.latelyList.length,
                                  itemBuilder:
                                      (BuildContext context, int idx) {
                                    return latelyRecipeCardWidget(
                                        userController.latelyList[idx]);
                                  }),
                            )
                                : const Padding(
                              padding: EdgeInsets.only(top: 10),
                              child: Text('최근 본 레시피가 없습니다.'),
                            )
                          ],
                        ),
                      ),
                    ),

                    // 설정 버튼 들
                    Container(
                      padding: const EdgeInsets.only(
                          top: 10, bottom: 10, left: 20, right: 10),
                      margin: const EdgeInsets.only(top: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.0),
                        color: Colors.white,
                      ),
                      child: Column(
                        children: [
                          _userSettingButton('문의하기', _onPressedContact),
                          _userSettingButton(
                              '로그아웃', userController.handleLogout),
                          _userSettingButton(
                              '탈퇴하기', userController.handleWithdraw),
                          _userSettingButton('오뚝이들', _onPressedProducerInfo)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }

  void updateUserNickNameDialog() {
    Get.put(UserController());
    final userController = Get.find<UserController>();
    TextEditingController nicknameTextEditingController =
        TextEditingController(text: '');
    // 닉네임 수정
    Get.dialog(Dialog(
      child: Container(
        height: 210,
        padding:
            const EdgeInsets.only(bottom: 20, left: 20, right: 20, top: 50),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25.0),
            border: Border.all(
              color: lightColorScheme.primary,
              width: 5,
            ),
            color: Colors.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 100,
                  child: Text(
                    '현재 닉네임 ',
                  ),
                ),
                Obx(() => Text(userController.nickName.value)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 100,
                  child: Text(
                    '새로운 닉네임 ',
                  ),
                ),
                SizedBox(
                  width: 150,
                  height: 35,
                  child: TextField(
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.normal),
                    controller: nicknameTextEditingController,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(top: 25.0),
                      hintText: '10자 이내',
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          width: 2,
                          color: lightColorScheme.primary,
                        ),
                      ),
                    ),
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(10),
                    ],
                  ),
                ),
              ],
            ),
            const Padding(padding: EdgeInsets.only(bottom: 20)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: const Text('취소')),
                const Padding(padding: EdgeInsets.only(right: 20)),
                ElevatedButton(
                    onPressed: () {
                      userController.updateUserNickName(
                          nicknameTextEditingController.text);
                      Get.back();
                    },
                    child: const Text('완료')),
              ],
            )
          ],
        ),
      ),
    ));
  }

  InkWell latelyRecipeCardWidget(LatelyResponse latelyResponse) {
    return InkWell(
      onTap: () {
        Get.toNamed('/recipe_detail', arguments: latelyResponse.recipeId);
      },
      child: Container(
        margin: const EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25.0),
            border: Border.all(
              color: lightColorScheme.primary,
              width: 2,
            ),
            color: Colors.white),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25.0),
                child: Image.network(
                  '${latelyResponse.thumbnail}',
                  fit: BoxFit.fill,
                  height: 80,
                  width: 80,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Container(
                constraints: const BoxConstraints(
                  maxWidth: 120,
                ),
                child: Text(
                  '${latelyResponse.name}',
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  InkWell _userSettingButton(String text, Function onPressed) {
    return InkWell(
      onTap: () {
        onPressed();
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(text),
            const Icon(Icons.chevron_right_rounded),
          ],
        ),
      ),
    );
  }

  void _onPressedContact() {
    // 문의하기
  }

  void _onPressedProducerInfo() {
    //오뚝이들
  }
}
