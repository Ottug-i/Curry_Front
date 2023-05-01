import 'package:flutter/material.dart';
import 'package:ottugi_curry/view/comm/default_layout_widget.dart';

class UserPage extends StatelessWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultLayoutWidget(
      appBarTitle: '마이페이지',
      body: Padding(
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
                    height: 82,
                    width: 82,
                  ),
                  const Padding(padding: EdgeInsets.only(right: 25)),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('계란러버덕', style: Theme.of(context).textTheme.titleMedium,),
                      Text('이메일'),
                      Text('요리등급'),
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
                  )
                ],
              ),
            ),

            // 설정 버튼 들
            Container(
              padding: const EdgeInsets.only(
                  top: 20, bottom: 20, left: 20, right: 20),
              margin: const EdgeInsets.only(top: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25.0),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  _userSettingButton('문의하기', _onPressedContact),
                  _userSettingButton('로그아웃', _onPressedLogout),
                  _userSettingButton('탈퇴하기', _onPressedWithdrawal),
                  _userSettingButton('오뚝이들', _onPressedProducerInfo)
                ],
              ),
            ),
          ],
        ),
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

  void _onPressedLogout() {
    // 로그아웃
  }

  void _onPressedWithdrawal() {
    //탈퇴하기
  }

  void _onPressedProducerInfo() {
    //오뚝이들
  }
}
