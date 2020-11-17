import 'package:buffit_beta/widgets/bottomMenu.dart';
import 'package:buffit_beta/widgets/header.dart';
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
        appBar: AppBar(
          title: SvgPicture.asset('assets/images/buffit.svg',
              width: getProportionateScreenWidth(110)),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: HomeButton(),
        bottomNavigationBar: BottomMenu(),
        body: Column(
          children: [Header(title: 'Fitness Life')],
        ));
  }
}
