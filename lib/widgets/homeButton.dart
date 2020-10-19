import 'package:buffit_beta/screens/home/home.dart';
import 'package:flutter/material.dart';

class HomeButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.pushReplacementNamed(context, Home.routeName);
      },
      child: Icon(
        Icons.home,
        color: Colors.white,
        size: 35,
      ),
      backgroundColor: Color(0xFF0987B6),
      elevation: 2.0,
    );
  }
}
