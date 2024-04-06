import 'package:flutter/material.dart';
import 'package:soundspace/core/theme/app_pallete.dart';


class AppTheme{
  static _border([Color color = AppPallete.boxColor]) => OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
        color: color,
        width: 3
        ),
      );
  static final darkThemeMode = ThemeData.dark().copyWith(
    inputDecorationTheme: InputDecorationTheme(
      isDense: true,
      filled: true,
      fillColor: AppPallete.boxColor,
      labelStyle: const TextStyle(
            color: AppPallete.whiteColor,
            fontSize: 12
      ),
      enabledBorder: _border(),
      focusedBorder: _border(AppPallete.borderColor),
    ),
  );
}