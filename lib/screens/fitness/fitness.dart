import 'package:buffit_beta/widgets/bottomMenu.dart';
import 'package:buffit_beta/widgets/homeButton.dart';
import 'package:flutter/material.dart';

class Fitness extends StatefulWidget {
  static String routeName = "/fitness";
  @override
  _FitnessState createState() => _FitnessState();
}

class _FitnessState extends State<Fitness> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: HomeButton(),
      bottomNavigationBar: BottomMenu(),
    );
  }
}
