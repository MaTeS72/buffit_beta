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
          buildMenuButton('instagram', '/posts', 'Posty', context),
          SizedBox(width: getProportionateScreenWidth(20)),
          buildMenuButton(
              'programming', '/programming', 'Programování', context),
          SizedBox(width: getProportionateScreenWidth(55)),
          buildMenuButton('video', '/videos', 'Videa', context),
          SizedBox(width: getProportionateScreenWidth(35)),
          buildMenuButton('fitness', '/fitness', 'Fitness', context),
        ],
      ),
    );
  }

  Container buildMenuButton(
      String icon, String route, String title, BuildContext context) {
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
                Navigator.pushReplacementNamed(context, route);
              },
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: Color(0xFFF7F0F0),
            ),
          )
        ],
      ),
    );
  }
}
