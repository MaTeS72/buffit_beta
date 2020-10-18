import 'package:buffit_beta/screens/Login/login.dart';
import 'package:buffit_beta/screens/Register/register.dart';
import 'package:buffit_beta/screens/home/home.dart';
import 'package:buffit_beta/screens/myList/my_list.dart';
import 'package:flutter/material.dart';

final Map<String, WidgetBuilder> routes = {
  Login.routeName: (context) => Login(),
  Register.routeName: (context) => Register(),
  Home.routeName: (context) => Home(),
  MyList.routeName: (context) => MyList()
};
