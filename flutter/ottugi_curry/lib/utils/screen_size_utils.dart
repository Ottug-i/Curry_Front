import 'package:flutter/cupertino.dart';
import 'package:ottugi_curry/config/config.dart';

// 현재 사이즈가 패드 사이즈인지 모바일 사이즈인지 구분
bool isWidthMobile(context) {
  return MediaQuery.of(context).size.width <= Config.padWidth ? true : false;
}

// 현재 화면의 너비 리턴
double widthSize(context) {
  return MediaQuery.of(context).size.width;
}

// 현재 화면의 길이 리턴
double heightSize(context) {
  return MediaQuery.of(context).size.height;
}