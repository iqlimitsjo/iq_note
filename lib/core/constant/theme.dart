import 'package:flutter/material.dart';

import 'color.dart';

ThemeData themeEnglish = ThemeData(
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: AppColor.primaryClr,
  ),
  appBarTheme: const AppBarTheme(centerTitle: true),
  fontFamily: 'Cairo',
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
  useMaterial3: true,
);
ThemeData themeArabic = ThemeData(
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: AppColor.primaryClr,
  ),
  appBarTheme: const AppBarTheme(centerTitle: true),
  fontFamily: 'Cairo',
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
  useMaterial3: true,
);

ThemeData themeLight = ThemeData(
  primaryColor: AppColor.primaryClr,
  fontFamily: 'Cairo',
  // appBarTheme: const AppBarTheme(
  //   backgroundColor: Colors.white,
  // ),
  scaffoldBackgroundColor: Colors.white,
  colorScheme: const ColorScheme(
      background: Colors.white,
      brightness: Brightness.light,
      surface: Colors.white,
      onSecondary: Colors.red,
      error: Colors.red,
      onError: Colors.red,
      onPrimary: Colors.white,
      onBackground: Colors.amber,
      onSurface: Colors.black,
      primary: Colors.teal,
      secondary: Colors.white),
);
ThemeData themeDark = ThemeData(
  primaryColor: AppColor.darkGreyClr,
  fontFamily: 'Cairo',
  scaffoldBackgroundColor: Colors.black,
  colorScheme: const ColorScheme(
      background: Colors.black,
      brightness: Brightness.dark,
      surface: Colors.black,
      onSecondary: Colors.red,
      error: Colors.red,
      onError: Colors.red,
      onPrimary: Colors.white,
      onBackground: Colors.amber,
      onSurface: Colors.white,
      primary: Colors.teal,
      secondary: Colors.white),
);
