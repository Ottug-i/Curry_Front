import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ottugi_curry/config/color_schemes.dart';
import 'package:ottugi_curry/config/config.dart';
import 'package:ottugi_curry/model/lately_response.dart';
import 'package:ottugi_curry/view/comm/default_layout_widget.dart';
import 'package:ottugi_curry/view/controller/user/user_controller.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  void initState() {
    Get.put(UserController());
    Get.find<UserController>().handleLatelyRecipe();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Get.put(UserController());
    final userController = Get.find<UserController>();

    return DefaultLayoutWidget(
      appBarTitle: '마이페이지',
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 10),
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
                            Text(
                              userStorage.getItem('nickname') ?? '러더벅',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            const Padding(padding: EdgeInsets.only(right: 10)),
                            InkWell(
                              onTap: () {
                                // 닉네임 수
                              },
                              child: const ImageIcon(
                                AssetImage('assets/icons/revise.png'),
                                size: 15,
                              ),
                            )
                          ],
                        ),
                        Text(userStorage.getItem('email') ?? '',
                            style: Theme.of(context).textTheme.titleSmall),
                        const Padding(padding: EdgeInsets.only(bottom: 10)),
                        Text('요리초보',
                          style: Theme.of(context).textTheme.bodySmall,),
                      ],
                    )
                  ],
                ),
              ),

              // 최근 본 레시피
              Container(
                padding: const EdgeInsets.only(
                    top: 20, bottom: 20, left: 20, right: 20),
                margin: const EdgeInsets.only(top: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.0),
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '최근 본 레시피',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    // 최근 본 레시피 리스트
                    SizedBox(
                      height: 180,
                      child: ListView.builder(
                          padding: const EdgeInsets.only(top: 14, bottom: 14),
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: userController.latelyList.length,
                          itemBuilder: (BuildContext context, int idx) {
                            return latelyRecipeCardWidget(
                                userController.latelyList[idx]);
                          }),
                    ),
                  ],
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
                    _userSettingButton('로그아웃', userController.handleLogout),
                    _userSettingButton('탈퇴하기', userController.handleWithdraw),
                    _userSettingButton('오뚝이들', _onPressedProducerInfo)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container latelyRecipeCardWidget(LatelyResponse latelyResponse) {
    return Container(
      margin: const EdgeInsets.only(right: 20),
      // padding: const EdgeInsets.only(bottom: 50, right: 20, top: 50),
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
              child: Text('${latelyResponse.name}')),
        ],
      ),
    );
  }

  Row _userSettingButton(String text, Function onPressed) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(text),
        IconButton(
            onPressed: () {
              onPressed();
            },
            icon: const Icon(Icons.chevron_right_rounded)),
      ],
    );
  }

  void _onPressedContact() {
    // 문의하기
  }

  void _onPressedProducerInfo() {
    //오뚝이들
  }
}
