import 'package:buffit_beta/screens/fitness/fitness.dart';
import 'package:buffit_beta/screens/posts/posts.dart';
import 'package:buffit_beta/screens/programming/programming.dart';
import 'package:buffit_beta/screens/videos/videos.dart';
import 'package:buffit_beta/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../size_config.dart';

class BottomMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      child: Row(
        children: [
          SizedBox(width: getProportionateScreenWidth(15)),
          buildMenuButton('instagram', Posts(), 'Posty', context),
          SizedBox(width: getProportionateScreenWidth(20)),
          buildMenuButton(
              'programming', Programming(), 'Programování', context),
          SizedBox(width: getProportionateScreenWidth(60)),
          buildMenuButton('video', Videos(), 'Videa', context),
          SizedBox(width: getProportionateScreenWidth(30)),
          buildMenuButton('fitness', Fitness(), 'Fitness', context),
        ],
      ),
    );
  }

  Container buildMenuButton(
      String icon, Widget route, String title, BuildContext context) {
    return Container(
      height: 60,
      child: Column(
        children: [
          Container(
            height: 35,
            child: IconButton(
              padding: EdgeInsets.only(bottom: 2, top: 8),
              icon: SvgPicture.asset(
                'assets/icons/$icon.svg',
                color: Color(0xFFF7F0F0),
              ),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) => route,
                  ),
                );
              },
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: AppColors.lightgreycolor,
            ),
          )
        ],
      ),
    );
  }
}
