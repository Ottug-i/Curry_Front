import 'package:flutter/cupertino.dart';
import 'package:ottugi_curry/view/comm/default_layout_widget.dart';
import 'package:ottugi_curry/view/page/bookmark/bookmark_list_page.dart';

class BookmarkPage extends StatelessWidget {
  const BookmarkPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const DefaultLayoutWidget(
        appBarTitle: '북마크 레시피', body: BookmrkListPage());
  }
}
