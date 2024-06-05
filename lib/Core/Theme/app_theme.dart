
import 'package:expense_tracker_mvvm/Core/Theme/app_pallete.dart';
import 'package:flutter/material.dart';

class AppTheme{
  static final darkThemeMode = ThemeData.dark().copyWith(
      scaffoldBackgroundColor: AppPallete.backgroundColor,
      appBarTheme: AppBarTheme(
        backgroundColor: AppPallete.backgroundColor,
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(width: 1,color: AppPallete.borderColor),
        ),

      )
  );
}