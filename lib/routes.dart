import 'package:buffit_beta/screens/Login/login.dart';
import 'package:buffit_beta/screens/Register/register.dart';
import 'package:buffit_beta/screens/course/course.dart';
import 'package:buffit_beta/screens/fitness/fitness.dart';
import 'package:buffit_beta/screens/home/home.dart';
import 'package:buffit_beta/screens/post_detail/post_detail.dart';
import 'package:buffit_beta/screens/posts/posts.dart';
import 'package:buffit_beta/screens/programming/programming.dart';
import 'package:buffit_beta/screens/reset_password/reset_password.dart';
import 'package:buffit_beta/screens/videos/videos.dart';

import 'package:flutter/material.dart';

abstract class Routes {
  static MaterialPageRoute materialRoutes(RouteSettings settings) {
    switch (settings.name) {
      case "/login":
        return MaterialPageRoute(builder: (context) => Login());
      case "/register":
        return MaterialPageRoute(builder: (context) => Register());
      case "/forgot_password":
        return MaterialPageRoute(builder: (context) => ResetPassword());
      case "/programming":
        return MaterialPageRoute(builder: (context) => Programming());
      case "/posts":
        return MaterialPageRoute(builder: (context) => Posts());
      case "/videos":
        return MaterialPageRoute(builder: (context) => Videos());
      case "/fitness":
        return MaterialPageRoute(builder: (context) => Fitness());
      case "/home":
        return MaterialPageRoute(builder: (context) => Home());
      default:
        var routeArray = settings.name.split('/');
        if (settings.name.contains('/course/')) {
          return MaterialPageRoute(
              builder: (context) => CourseDetail(
                    courseId: routeArray[2],
                  ));
        }
        if (settings.name.contains('/post/')) {
          return MaterialPageRoute(
              builder: (context) => PostDetail(
                    postId: routeArray[2],
                  ));
        }

        return MaterialPageRoute(builder: (context) => Login());
    }
  }
}
