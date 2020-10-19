import 'package:buffit_beta/widgets/header.dart';
import 'package:buffit_beta/widgets/bottomMenu.dart';
import 'package:buffit_beta/widgets/homeButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../size_config.dart';

class Posts extends StatefulWidget {
  static String routeName = "/posts";
  @override
  _PostsState createState() => _PostsState();
}

class _PostsState extends State<Posts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: SvgPicture.asset('assets/images/buffit.svg',
              width: getProportionateScreenWidth(110))),
      body: Header(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: HomeButton(),
      bottomNavigationBar: BottomMenu(),
    );
  }
}
