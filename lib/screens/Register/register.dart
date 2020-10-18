import 'dart:async';

import 'package:buffit_beta/blocs/bloc.dart';
import 'package:buffit_beta/models/application_user.dart';
import 'package:buffit_beta/screens/Login/login.dart';
import 'package:buffit_beta/screens/home/home.dart';
import 'package:buffit_beta/validation/signup_validation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../../size_config.dart';

class Register extends StatefulWidget {
  static String routeName = "/register";
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  StreamSubscription<ApplicationUser> loginStateSubscription;

  @override
  void initState() {
    var authBloc = Provider.of<AuthBloc>(context, listen: false);
    loginStateSubscription = authBloc.user.listen((user) {
      if (user != null) {
        Navigator.pushReplacementNamed(context, Home.routeName);
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
    final validationService = Provider.of<SignupValidation>(context);

    SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            title: SvgPicture.asset('assets/images/buffit.svg',
                width: getProportionateScreenWidth(110))),
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
                            Text('Up',
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
                height: getProportionateScreenWidth(20),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(30)),
                child: Form(
                  child: Column(
                    children: [
                      buildEmailFormField(validationService),
                      SizedBox(height: getProportionateScreenWidth(20)),
                      buildPassFormField(validationService),
                      SizedBox(height: getProportionateScreenWidth(20)),
                      buildPassAgainFormField(validationService),
                      SizedBox(height: getProportionateScreenWidth(20)),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20)),
                        height: 65,
                        width: double.infinity,
                        child: FlatButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          onPressed: () {
                            if (validationService.isValid != true) {
                              return null;
                            } else {
                              List credentials = validationService.submitData();
                              var email = credentials[0];
                              var password = credentials[1];
                              authBloc.registerWithEmailAndPassword(
                                  email, password);
                            }
                          },
                          color: Color(0xFF00B2F5),
                          child: Text(
                            'Sign Up',
                            style: TextStyle(fontSize: 20),
                          ),
                          textColor: kPrimaryColor,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Already have an account? '),
                          GestureDetector(
                            child: Text(
                              'Login',
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontWeight: FontWeight.bold),
                            ),
                            onTap: () {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => Login()));
                            },
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: getProportionateScreenWidth(25),
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextFormField buildEmailFormField(validationService) {
    return TextFormField(
      onChanged: (String value) {
        validationService.changeEmail(value);
      },
      decoration: InputDecoration(
        labelText: 'Email',
        hintText: 'Enter your email',
        errorText: validationService.email.error,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
      ),
    );
  }

  TextFormField buildPassFormField(validationService) {
    return TextFormField(
      onChanged: (String value) {
        validationService.changePassword(value);
      },
      decoration: InputDecoration(
        labelText: 'Password',
        hintText: 'Enter your password',
        errorText: validationService.password.error,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
      ),
    );
  }

  TextFormField buildPassAgainFormField(validationService) {
    return TextFormField(
      onChanged: (String value) {
        validationService.changePasswordConfirmation(value);
      },
      decoration: InputDecoration(
        labelText: 'Confirm password',
        hintText: 'Re-enter your password',
        errorText: validationService.pass_again.error,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
      ),
    );
  }
}
