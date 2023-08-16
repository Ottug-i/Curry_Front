import 'package:flutter/material.dart';
import 'package:ottugi_curry/config/color_schemes.dart';
import 'package:ottugi_curry/utils/create_material_color_utils.dart';

/// 테마 기본 설정
class CustomThemeData {
  // 라이트 모드
  static final themeDataLight = ThemeData(
      useMaterial3: true,
      // fontFamily: 'Pretendard',

      // 색상 테마
      colorScheme: lightColorScheme,
      primarySwatch: createMaterialColor(const Color(0xffFFD717)),

      // 텍스트 테마
      textTheme: TextTheme(
        //title (Bold 지정)
        titleLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.bold), // 제목, 강조 텍스트
        titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.bold), // 소제목: 크기 기본 + Bold
        titleSmall: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        // body
        bodyLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.w600), // 소제목2: 약간 크고 + Semi Bold
        bodyMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.normal), //기본 텍스트
        bodySmall: TextStyle(fontSize: 12),
        //
        labelLarge: TextStyle(fontSize: 13, color: Colors.grey.shade700), // 설명줄
      ),

      //버튼 테마
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: lightColorScheme.primary,
            foregroundColor: lightColorScheme.onPrimary,
            // padding: const EdgeInsets.only(left: 20, right: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0)
            ),
          )),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          side: BorderSide(
            color: lightColorScheme.primary,
          ),
          // padding: const EdgeInsets.only(left: 20, right: 20),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(97.0)
          ),
        ),
      )
  );
}