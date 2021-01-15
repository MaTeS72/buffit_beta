import 'package:buffit_beta/size_config.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const kPrimaryColor = Colors.white;
const kSecondaryColor = Color(0xFF000000);

final headingStyle1 = GoogleFonts.sourceSansPro(
    textStyle: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: getProportionateScreenWidth(50),
        color: kPrimaryColor));
