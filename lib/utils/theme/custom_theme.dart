import 'package:flutter/material.dart';

import '../colors.dart';

class CustomTheme {
  static ThemeData lightTheme = ThemeData().copyWith(
    scaffoldBackgroundColor: Colors.white,
    primaryColor: kPrimaryBase,
    textTheme: const TextTheme(
      displayLarge: TextStyle(color: Colors.black),
      displayMedium: TextStyle(color: Colors.black),
      bodyMedium: TextStyle(color: Colors.black),
      titleMedium: TextStyle(color: Colors.black),
    ),
    iconTheme: const IconThemeData(
      color: Colors.white
    )
  );
}