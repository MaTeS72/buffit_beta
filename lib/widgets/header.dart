import 'package:buffit_beta/constants.dart';
import 'package:buffit_beta/screens/home/components/body.dart';
import 'package:buffit_beta/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../size_config.dart';

class Header extends StatelessWidget {
  final String title;

  const Header({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var fTitle = title.split(" ");

    return Stack(
      children: <Widget>[
        Container(
          height: getProportionateScreenHeight(200),
          decoration: BoxDecoration(
              color: AppColors.darkgreycolor,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(70),
                  bottomRight: Radius.circular(70))),
        ),
        //  Container(child: SvgPicture.asset('assets\images\cap.svg')),
        Positioned(
          left: getProportionateScreenWidth(30),
          top: getProportionateScreenHeight(25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Stack(
                children: [
                  Positioned(
                    top: 50,
                    child: Container(
                      height: 5,
                      width: 45,
                      color: Colors.red,
                    ),
                  ),
                  Text(
                    fTitle[0],
                    style: headingStyle1,
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  SizedBox(
                    width: getProportionateScreenWidth(60),
                  ),
                  Text(
                    fTitle[1],
                    style: headingStyle1,
                  ),
                  Text(
                    '.',
                    style: TextStyle(
                        fontSize: getProportionateScreenWidth(50),
                        color: Color(0xFF00B2F5)),
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
            width: double.infinity,
            margin: EdgeInsets.only(top: getProportionateScreenWidth(10)),
            child: SvgPicture.asset(
              'assets/images/cap4.svg',
              height: 200,
              alignment: new Alignment(4, 0),
            )),
      ],
    );
  }
}
