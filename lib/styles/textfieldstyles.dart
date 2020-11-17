import 'package:buffit_beta/constants.dart';
import 'package:buffit_beta/styles/colors.dart';
import 'package:buffit_beta/styles/text.dart';
import 'package:flutter/material.dart';

abstract class TextFieldStyles {
  static TextStyle get text => TextStyles.formfieldtext;
  static TextStyle get placeholder => TextStyles.formfieldplaceholder;

  static InputDecoration materialDecoration(
      String hintText, Icon icon, String errorText, String initialText) {
    return InputDecoration(
      floatingLabelBehavior: FloatingLabelBehavior.auto,
      hintText: hintText,
      labelText: initialText,
      hintStyle: TextFieldStyles.placeholder,
      errorText: errorText,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: AppColors.darkgreycolor),
        gapPadding: 10,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: AppColors.darkgreycolor),
        gapPadding: 10,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: AppColors.darkgreycolor),
        gapPadding: 10,
      ),
      suffixIcon: icon,
      fillColor: AppColors.darkgreycolor,
      filled: true,
      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
    );
  }
}
