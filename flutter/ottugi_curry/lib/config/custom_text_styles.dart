
import 'package:flutter/material.dart';

/// text theme 외의 custom text style 속성 만들고 싶을 때 사용. (우선 customThemeData에 설정)
class CustomTextStyles {
  static const hintTextStyle = TextStyle(fontStyle: FontStyle.italic);
  static const noteTextStyle = TextStyle(fontSize: 12, color: Colors.black54);
  static const memoTextStyle = TextStyle(fontSize: 12, color: Colors.black45, fontStyle: FontStyle.italic);
}