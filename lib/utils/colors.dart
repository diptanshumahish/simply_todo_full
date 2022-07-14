// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class AppColors {
  static const themeColor = Color(0xFFC75353);
  static const transparent = Colors.transparent;
  static const secondary = Color.fromARGB(255, 120, 136, 108);
  static const mainLightText = Color(0xFF504E4E);
  static const mainLightTextDark = Color(0xFFB8B3B3);
  static const mainText = Colors.white;
}

//themes
abstract class Apptheme {
  static var brgthDark = Brightness.dark;
//light theme
  static ThemeData light() => ThemeData(
        timePickerTheme: TimePickerThemeData(
            dialHandColor: AppColors.themeColor,
            dayPeriodColor: AppColors.mainText.withAlpha(100),
            backgroundColor: AppColors.secondary,
            hourMinuteColor: AppColors.mainText,
            dialTextColor: AppColors.mainText,
            entryModeIconColor: AppColors.secondary,
            helpTextStyle: TextStyle(color: AppColors.mainText, fontSize: 40)),
        brightness: Brightness.light,
        textTheme: GoogleFonts.amaticScTextTheme().apply(),
        scaffoldBackgroundColor: const Color.fromARGB(255, 207, 205, 205),
      );
  static ThemeData dark() => ThemeData(
        timePickerTheme: TimePickerThemeData(
            dialHandColor: AppColors.themeColor,
            dialTextColor: AppColors.mainText,
            entryModeIconColor: AppColors.secondary,
            helpTextStyle: TextStyle(color: AppColors.mainText, fontSize: 40)),
        scaffoldBackgroundColor: const Color.fromARGB(255, 35, 35, 36),
        brightness: Brightness.dark,
        textTheme: GoogleFonts.amaticScTextTheme()
            .apply(displayColor: AppColors.mainText),
      );
}
