import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ottugi_curry/config/color_schemes.dart';
import 'package:ottugi_curry/view/controller/login/login_controller.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  Future<void> _initCheckLogin() async {
    // 로그인 여부 확인
    Get.put(LoginController());
    await Get.find<LoginController>().checkLogin();
  }

  @override
  Widget build(BuildContext context) {
    Get.put(LoginController());
    final loginController = Get.find<LoginController>();

    return Scaffold(
      body: FutureBuilder(
          future: _initCheckLogin(),
          builder: (context, snap) {
            if (snap.connectionState != ConnectionState.done) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return Scaffold(
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 50, right: 50, top: 150, bottom: 100),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '로그인 / 회원가입',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          Container(
                            color: lightColorScheme.primary,
                            width: 170,
                            height: 3,
                          )
                        ],
                      ),
                      const Padding(padding: EdgeInsets.only(bottom: 15)),
                      const Text('소셜 로그인으로 가입할 수 있습니다.'),
                      const Padding(padding: EdgeInsets.only(bottom: 200)),

                      // 구글 로그인 버튼
                      ElevatedButton(
                        onPressed: () async {
                          loginController.loginGoogle();
                        },
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            backgroundColor: Colors.white70),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.asset(
                              'assets/icons/google2.png',
                              height: 25,
                            ),
                            const Text('구글 로그인'),
                            const Padding(padding: EdgeInsets.only(left: 25)),
                          ],
                        ),
                      ),

                      const Padding(padding: EdgeInsets.only(bottom: 10)),

                      // 카카오 로그인 버튼
                      ElevatedButton(
                        onPressed: () {
                          loginController.loginKakao();
                        },
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            backgroundColor: const Color(0xFFFFE812)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.asset(
                              'assets/icons/kakao4.png',
                              height: 25,
                            ),
                            const Text('카카오 로그인'),
                            const Padding(padding: EdgeInsets.only(left: 25)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
