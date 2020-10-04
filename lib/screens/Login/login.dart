import 'dart:async';

import 'package:buffit_beta/blocs/bloc.dart';
import 'package:buffit_beta/screens/Register/register.dart';
import 'package:buffit_beta/screens/home/home.dart';
import 'package:buffit_beta/size_config.dart';
import 'package:buffit_beta/validation/signup_validation.dart';
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
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20)),
                        height: 55,
                        width: double.infinity,
                        child: FlatButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          onPressed: () {
                            if (validationService.isValid1 != true) {
                              print('invalid');
                              return null;
                            } else {
                              List credentials = validationService.submitData();
                              var email = credentials[0];
                              var password = credentials[1];
                              print('login');
                              authBloc.signInWithEmailAndPassword(
                                  email, password);
                            }
                          },
                          color: Color(0xFF00B2F5),
                          child: Text(
                            'Log In',
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
                          Text('Dont have account? '),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => Register()));
                            },
                            child: Text(
                              'Register',
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: getProportionateScreenWidth(20),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      authBloc.loginFacebook();
                    },
                    child: Container(
                        height: 55,
                        width: 55,
                        child: SvgPicture.asset('assets/icons/facebook.svg')),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      authBloc.googleLogin();
                    },
                    child: Container(
                        height: 55,
                        width: 55,
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

  TextFormField buildEmailFormField(validationService) {
    return TextFormField(
      onChanged: (value) {
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
      onChanged: (value) {
        validationService.changePassword(value);
      },
      decoration: InputDecoration(
        labelText: 'Password',
        errorText: validationService.password.error,
        hintText: 'Enter your password',
        floatingLabelBehavior: FloatingLabelBehavior.auto,
      ),
    );
  }
}
