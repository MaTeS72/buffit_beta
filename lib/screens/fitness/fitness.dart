import 'package:buffit_beta/widgets/bottomMenu.dart';
import 'package:buffit_beta/widgets/custom_appbar.dart';

import 'package:buffit_beta/widgets/homeButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../size_config.dart';

class Fitness extends StatefulWidget {
  @override
  _FitnessState createState() => _FitnessState();
}

class _FitnessState extends State<Fitness> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: HomeButton(),
        bottomNavigationBar: BottomMenu(),
        extendBody: true,
        body: Column(
          children: [],
        ));
  }
}
