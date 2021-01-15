import 'package:buffit_beta/constants.dart';
import 'package:buffit_beta/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData theme() {
  return ThemeData(
    inputDecorationTheme: inputDecorationTheme(),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    brightness: Brightness.dark,
    appBarTheme: appBarTheme(),
    scaffoldBackgroundColor: const Color(0XFF171920),
  );
}

AppBarTheme appBarTheme() {
  return AppBarTheme(
    color: Color(0xFF3B3939),
    elevation: 0,
    textTheme: TextTheme(
      headline6: TextStyle(color: kSecondaryColor, fontSize: 18),
    ),
  );
}

InputDecorationTheme inputDecorationTheme() {
  OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    gapPadding: 10,
  );
  return InputDecorationTheme(
    fillColor: Color(0xFF232630),
    filled: true,
    contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
    enabledBorder: outlineInputBorder,
    focusedBorder: outlineInputBorder,
    border: outlineInputBorder,
  );
}
