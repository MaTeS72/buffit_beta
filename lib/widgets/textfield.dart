import 'package:buffit_beta/styles/textfieldstyles.dart';
import 'package:flutter/material.dart';

class AppTextField extends StatefulWidget {
  final String hintText;
  final Icon materialIcon;
  final TextInputType textInputType;
  final bool obscureText;
  final void Function(String) onChanged;
  final String errorText;
  final String initialText;
  final TextEditingController controller;

  AppTextField({
    @required this.hintText,
    @required this.materialIcon,
    this.textInputType = TextInputType.text,
    this.obscureText = false,
    this.onChanged,
    this.errorText,
    this.initialText,
    this.controller,
  });
  @override
  _AppTextFieldState createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: widget.textInputType,
      style: TextFieldStyles.text,
      controller: widget.controller,
      decoration: TextFieldStyles.materialDecoration(widget.hintText,
          widget.materialIcon, widget.errorText, widget.initialText),
      obscureText: widget.obscureText,
      onChanged: widget.onChanged,
    );
  }
}
