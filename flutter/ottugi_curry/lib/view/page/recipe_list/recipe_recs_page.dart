import 'package:flutter/material.dart';
import 'package:ottugi_curry/view/comm/default_layout_widget.dart';
import 'package:ottugi_curry/view/page/recipe_list/recipe_list_page.dart';

class RecipeRecsPage extends StatelessWidget {
  const RecipeRecsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const DefaultLayoutWidget(
      backToPageRoute: '/recipe',
      appBarTitle: '추천 레시피',
      body: RecipeListPage(),
      // ListPage(mode: 'search', ingredients: ['', ''])
    );
  }
}
