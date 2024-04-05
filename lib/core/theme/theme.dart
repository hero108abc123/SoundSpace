import 'package:flutter/material.dart';
import 'package:soundspace/core/theme/app_pallete.dart';


class AppTheme{
  static final darkThemeMode = ThemeData.dark().copyWith(
    inputDecorationTheme: InputDecorationTheme(
      isDense: true,
      filled: true,
      fillColor: AppPallete.borderColor,
      enabledBorder: UnderlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none
      )
    ),
  );
}