import 'package:flutter/material.dart';
import 'package:ottugi_curry/config/color_schemes.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding:
              const EdgeInsets.only(left: 50, right: 50, top: 150, bottom: 100),
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
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)
                  ),
                  backgroundColor: Colors.white70
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    ImageIcon(
                      AssetImage('assets/icons/google.png'),
                      size: 48,
                    ),
                    Text('Google 로그인'),
                    Padding(padding: EdgeInsets.only(left: 50)),
                  ],
                ),
              ),

              const Padding(padding: EdgeInsets.only(bottom: 10)),

              // 카카오 로그인 버튼
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)
                    ),
                    backgroundColor: Color(0xFFFFE812)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    ImageIcon(
                      AssetImage('assets/icons/kakao.png'),
                      size: 48,
                    ),
                    Text('Kakao 로그인'),
                    Padding(padding: EdgeInsets.only(left: 50)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
