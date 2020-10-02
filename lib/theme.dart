import 'package:buffit_beta/constants.dart';
import 'package:flutter/material.dart';

ThemeData theme() {
  return ThemeData(
    //   scaffoldBackgroundColor: Colors.white,
    //fontFamily: "Muli",
    //appBarTheme: appBarTheme(),
    // textTheme: textTheme(),
    inputDecorationTheme: inputDecorationTheme(),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    brightness: Brightness.dark,
  );
}

InputDecorationTheme inputDecorationTheme() {
  OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: BorderSide(color: kSecondaryColorShade),
    gapPadding: 10,
  );
  return InputDecorationTheme(
    fillColor: kSecondaryColorShade,
    filled: true,
    contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
    enabledBorder: outlineInputBorder,
    focusedBorder: outlineInputBorder,
    border: outlineInputBorder,
  );
}
