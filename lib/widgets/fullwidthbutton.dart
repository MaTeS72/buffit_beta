import 'package:buffit_beta/size_config.dart';
import 'package:flutter/material.dart';

class FullWidthButton extends StatefulWidget {
  final String text;
  final Function onPressed;

  const FullWidthButton({Key key, this.text, this.onPressed}) : super(key: key);

  @override
  _FullWidthButtonState createState() => _FullWidthButtonState();
}

class _FullWidthButtonState extends State<FullWidthButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
      width: double.infinity,
      height: getProportionateScreenWidth(60),
      child: RaisedButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          color: Color(0xFF00B2F5),
          onPressed: () {},
          child: Text(widget.text)),
    );
  }
}
