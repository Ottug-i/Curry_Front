import 'package:flutter/material.dart';
import 'package:ottugi_curry/view/comm/default_layout_widget.dart';

class UserDevelopersPage extends StatelessWidget {
  const UserDevelopersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultLayoutWidget(
      appBarTitle: '오뚝이들',
      body: Padding(
      padding: const EdgeInsets.all(30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Text('Frontend Developer', style: Theme.of(context).textTheme.bodyLarge),
          const Padding(padding: EdgeInsets.only(bottom: 10)),
          Text('김희서, 최예나'),
          const Padding(padding: EdgeInsets.only(bottom: 30)),

          Text('Backend Developer', style: Theme.of(context).textTheme.bodyLarge),
          const Padding(padding: EdgeInsets.only(bottom: 10)),
          Text('김가경'),
          const Padding(padding: EdgeInsets.only(bottom: 30)),

          Text('GitHub', style: Theme.of(context).textTheme.bodyLarge),
          const Padding(padding: EdgeInsets.only(bottom: 10)),
          Text('https://github.com/Ottug-i'),

        ],
      ),
    ),);
  }
}
