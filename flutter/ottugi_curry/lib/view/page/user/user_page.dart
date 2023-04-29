import 'package:flutter/material.dart';
import 'package:ottugi_curry/view/comm/default_layout_widget.dart';

class UserPage extends StatelessWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultLayoutWidget(appBarTitle: '마이페이지',body: Text('UserPage'),);
  }
}
