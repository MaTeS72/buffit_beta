import 'package:buffit_beta/screens/Login/login.dart';
import 'package:buffit_beta/screens/Register/register.dart';
import 'package:buffit_beta/screens/fitness/fitness.dart';
import 'package:buffit_beta/screens/home/home.dart';
import 'package:buffit_beta/screens/posts/posts.dart';
import 'package:buffit_beta/screens/programming/programming.dart';
import 'package:buffit_beta/screens/reset_password/reset_password.dart';
import 'package:buffit_beta/screens/videos/videos.dart';

import 'package:flutter/material.dart';

final Map<String, WidgetBuilder> routes = {
  Login.routeName: (context) => Login(),
  Register.routeName: (context) => Register(),
  Home.routeName: (context) => Home(),
  Programming.routeName: (context) => Programming(),
  Videos.routeName: (context) => Videos(),
  Posts.routeName: (context) => Posts(),
  Fitness.routeName: (context) => Fitness(),
  ResetPassword.routeName: (context) => ResetPassword()
};
