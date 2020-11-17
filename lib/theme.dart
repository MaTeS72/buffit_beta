import 'package:buffit_beta/constants.dart';
import 'package:buffit_beta/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData theme() {
  return ThemeData(
    //   scaffoldBackgroundColor: Colors.white,
    //fontFamily: "Muli",
    //appBarTheme: appBarTheme(),
    // textTheme: textTheme(),
    inputDecorationTheme: inputDecorationTheme(),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    brightness: Brightness.dark,
    appBarTheme: appBarTheme(),
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
    borderSide: BorderSide(color: AppColors.darkgreycolor),
    gapPadding: 10,
  );
  return InputDecorationTheme(
    fillColor: AppColors.darkgreycolor,
    filled: true,
    contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
    enabledBorder: outlineInputBorder,
    focusedBorder: outlineInputBorder,
    border: outlineInputBorder,
  );
}
