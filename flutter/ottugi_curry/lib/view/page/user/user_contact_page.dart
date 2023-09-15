import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class UserContactPage extends StatefulWidget {
  const UserContactPage({Key? key}) : super(key: key);

  @override
  State<UserContactPage> createState() => _UserContactPageState();
}

class _UserContactPageState extends State<UserContactPage> {
  late WebViewController _webViewController;

  @override
  void initState() {
    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse("https://forms.gle/QzBDCnJeimpzoQXR6"));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: WebViewWidget(
      controller: _webViewController,
    ),
        ));
  }
}
