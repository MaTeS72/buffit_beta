import 'package:buffit_beta/widgets/bottomMenu.dart';
import 'package:buffit_beta/widgets/homeButton.dart';
import 'package:flutter/material.dart';

class Programming extends StatefulWidget {
  static String routeName = "/programming";
  @override
  _ProgrammingState createState() => _ProgrammingState();
}

class _ProgrammingState extends State<Programming> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: HomeButton(),
      bottomNavigationBar: BottomMenu(),
    );
  }
}
