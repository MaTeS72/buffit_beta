import 'package:buffit_beta/constants.dart';
import 'package:buffit_beta/screens/home/components/body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../size_config.dart';

class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          height: getProportionateScreenHeight(250),
          decoration: BoxDecoration(
              color: kSecondaryColorShade,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(70),
                  bottomRight: Radius.circular(70))),
        ),
        //  Container(child: SvgPicture.asset('assets\images\cap.svg')),
        Positioned(
          left: getProportionateScreenWidth(30),
          top: getProportionateScreenHeight(45),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Learn',
                style: GoogleFonts.sourceSansPro(
                  textStyle: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: getProportionateScreenWidth(50),
                      color: kPrimaryColor),
                ),
              ),
              Container(
                height: 5,
                width: 50,
                color: Colors.red,
              ),
              Row(
                children: <Widget>[
                  SizedBox(
                    width: getProportionateScreenWidth(60),
                  ),
                  Text('Fast',
                      style: GoogleFonts.sourceSansPro(
                        textStyle: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: getProportionateScreenWidth(50),
                            color: kPrimaryColor),
                      )),
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
            margin: EdgeInsets.only(top: getProportionateScreenWidth(50)),
            child: SvgPicture.asset(
              'assets/images/cap4.svg',
              height: 200,
              alignment: new Alignment(4, 0),
            )),
      ],
    );
  }
}
