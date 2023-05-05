import 'package:flutter/material.dart';
import 'package:ottugi_curry/view/comm/default_layout_widget.dart';
import 'package:ottugi_curry/view/page/list/list_page.dart';

class RecipeRecs extends StatelessWidget {
  const RecipeRecs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const DefaultLayoutWidget(
      appBarTitle: '추천레시피',
      body: ListPage(),
    );
  }
}
