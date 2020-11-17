import 'package:buffit_beta/size_config.dart';
import 'package:buffit_beta/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class TextStyles {
  static TextStyle get title {
    return GoogleFonts.sourceSansPro(
        textStyle: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: getProportionateScreenWidth(50),
            color: AppColors.white));
  }

  static TextStyle get courseDetailTitle {
    return GoogleFonts.sourceSansPro(
        textStyle: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: getProportionateScreenWidth(40),
            color: AppColors.white));
  }

  static TextStyle get courseTitle {
    return GoogleFonts.sourceSansPro(
        textStyle: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: getProportionateScreenWidth(25),
            color: AppColors.white));
  }

  static TextStyle get courseSubtitle {
    return GoogleFonts.sourceSansPro(
        textStyle: TextStyle(
            fontSize: getProportionateScreenWidth(15), color: AppColors.white));
  }

  static TextStyle get clasicText {
    return GoogleFonts.sourceSansPro(
        textStyle: TextStyle(color: AppColors.white));
  }

  static TextStyle get formfieldtext {
    return GoogleFonts.sourceSansPro(
        textStyle: TextStyle(color: AppColors.lightgreycolor), fontSize: 17);
  }

  static TextStyle get formfieldplaceholder {
    return GoogleFonts.sourceSansPro(
        textStyle: TextStyle(color: AppColors.lightgreycolor), fontSize: 17);
  }
}
