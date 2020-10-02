import 'dart:async';

import 'package:buffit_beta/blocs/bloc.dart';
import 'package:buffit_beta/screens/home/home.dart';
import 'package:buffit_beta/size_config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  StreamSubscription<User> loginStateSubscription;

  @override
  void initState() {
    var authBloc = Provider.of<AuthBloc>(context, listen: false);
    loginStateSubscription = authBloc.currentUser.listen((fbUser) {
      if (fbUser != null) {
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (context) => Home()));
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    loginStateSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var authBloc = Provider.of<AuthBloc>(context);
    SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
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
                          'Sign',
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
                            Text('In',
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
                      margin:
                          EdgeInsets.only(top: getProportionateScreenWidth(50)),
                      child: SvgPicture.asset(
                        'assets/images/cap4.svg',
                        height: 200,
                        alignment: new Alignment(4, 0),
                      )),
                ],
              ),
              SizedBox(
                height: getProportionateScreenWidth(25),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(30)),
                child: Form(
                  child: Column(
                    children: [
                      buildEmailFormField(),
                      SizedBox(height: getProportionateScreenWidth(20)),
                      buildPassFormField(),
                      SizedBox(height: getProportionateScreenWidth(30)),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20)),
                        height: 65,
                        width: double.infinity,
                        child: FlatButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          onPressed: () {},
                          color: Color(0xFF00B2F5),
                          child: Text(
                            'Log In',
                            style: TextStyle(fontSize: 20),
                          ),
                          textColor: kPrimaryColor,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: getProportionateScreenWidth(75),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      authBloc.loginFacebook();
                    },
                    child: Container(
                        height: 60,
                        width: 60,
                        child: SvgPicture.asset('assets/icons/facebook.svg')),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      authBloc.googleLogin();
                    },
                    child: Container(
                        height: 60,
                        width: 60,
                        child: SvgPicture.asset('assets/icons/google.svg')),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Email',
        hintText: 'Enter your email',
        floatingLabelBehavior: FloatingLabelBehavior.auto,
      ),
    );
  }

  TextFormField buildPassFormField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Password',
        hintText: 'Enter your password',
        floatingLabelBehavior: FloatingLabelBehavior.auto,
      ),
    );
  }
}
