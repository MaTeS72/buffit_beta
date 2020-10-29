import 'dart:async';

import 'package:buffit_beta/blocs/bloc.dart';
import 'package:buffit_beta/models/application_user.dart';
import 'package:buffit_beta/screens/Register/register.dart';
import 'package:buffit_beta/screens/home/home.dart';
import 'package:buffit_beta/screens/reset_password/reset_password.dart';
import 'package:buffit_beta/size_config.dart';
import 'package:buffit_beta/styles/colors.dart';
import 'package:buffit_beta/styles/text.dart';
import 'package:buffit_beta/validation/signup_validation.dart';
import 'package:buffit_beta/widgets/fullwidthbutton.dart';
import 'package:buffit_beta/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';

class Login extends StatefulWidget {
  static String routeName = "/login";
  @override
  _LoginState createState() => _LoginState();
}

//TODO: přidání resetu hesla
class _LoginState extends State<Login> {
  StreamSubscription<ApplicationUser> _userSubscription;
  //StreamSubscription _errorMessageSubscription;

  @override
  void initState() {
    var authBloc = Provider.of<AuthBloc>(context, listen: false);

    _userSubscription = authBloc.user.listen((user) {
      print('user je' + '$user');
      if (user != null) {
        Navigator.pushReplacementNamed(context, Home.routeName);
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _userSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var authBloc = Provider.of<AuthBloc>(context);

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
                          style: headingStyle1,
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
                            Text(
                              'In',
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
                      margin:
                          EdgeInsets.only(top: getProportionateScreenWidth(50)),
                      child: SvgPicture.asset(
                        'assets/images/cap4.svg',
                        height: 200,
                        alignment: new Alignment(4, 0),
                      )),
                ],
              ),
              StreamBuilder<String>(
                  stream: authBloc.errorMessage,
                  builder: (context, snapshot) {
                    if (snapshot.data != '' && snapshot.data != null) {
                      return Text(snapshot.data,
                          style: TextStyle(color: Colors.red));
                    }
                    return Text('');
                  }),
              SizedBox(
                height: getProportionateScreenWidth(10),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(30)),
                child: Form(
                  child: Column(
                    children: [
                      StreamBuilder<String>(
                          stream: authBloc.email,
                          builder: (context, snapshot) {
                            return AppTextField(
                              initialText: 'Email',
                              hintText: 'Enter your email',
                              onChanged: authBloc.changeEmail,
                              errorText: snapshot.error,
                              obscureText: false,
                              materialIcon: Icon(
                                Icons.email_outlined,
                                color: AppColors.lightgreycolor,
                              ),
                            );
                          }),
                      SizedBox(height: getProportionateScreenWidth(20)),
                      StreamBuilder<String>(
                          stream: authBloc.password,
                          builder: (context, snapshot) {
                            return AppTextField(
                              initialText: 'Password',
                              hintText: 'Enter your password',
                              onChanged: authBloc.changePassword,
                              errorText: snapshot.error,
                              obscureText: true,
                              materialIcon: Icon(
                                Icons.lock_outline,
                                color: AppColors.lightgreycolor,
                              ),
                            );
                          }),
                      SizedBox(height: getProportionateScreenWidth(5)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacementNamed(
                                  context, ResetPassword.routeName);
                            },
                            child: Text(
                              'Forgot password?',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: getProportionateScreenWidth(10)),
                      StreamBuilder<bool>(
                          stream: authBloc.isValid,
                          builder: (context, snapshot) {
                            return Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20)),
                              width: double.infinity,
                              height: getProportionateScreenWidth(60),
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                color: Color(0xFF00B2F5),
                                onPressed: () {
                                  authBloc.loginEmail();
                                },
                                child: Text(
                                  'Log In',
                                  style: TextStyle(fontSize: 20),
                                ),
                                textColor: kPrimaryColor,
                              ),
                            );
                          }),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Dont have account? '),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacementNamed(
                                  context, Register.routeName);
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
              // SizedBox(
              //   height: getProportionateScreenWidth(10),
              // ),
              // Text(
              //   'Terms of Use.',
              //   textAlign: TextAlign.center,
              // )
            ],
          ),
        ),
      ),
    );
  }
}
// TextFormField buildEmailFormField(validationService) {
//   return TextFormField(
//     onChanged: (value) {
//       validationService.changeEmail(value);
//     },
//     decoration: InputDecoration(
//       labelText: 'Email',
//       hintText: 'Enter your email',
//       errorText: validationService.email.error,
//       floatingLabelBehavior: FloatingLabelBehavior.auto,
//     ),
//   );
// }

//   TextFormField buildPassFormField(validationService) {
//     return TextFormField(
//       onChanged: (value) {
//         validationService.changePassword(value);
//       },
//       decoration: InputDecoration(
//         labelText: 'Password',
//         errorText: validationService.password.error,
//         hintText: 'Enter your password',
//         floatingLabelBehavior: FloatingLabelBehavior.auto,
//       ),
//     );
//   }
// }
