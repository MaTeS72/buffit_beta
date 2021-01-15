import 'package:buffit_beta/blocs/courseBloc.dart';
import 'package:buffit_beta/routes.dart';
import 'package:buffit_beta/screens/Login/login.dart';
import 'package:buffit_beta/screens/home/home.dart';
import 'package:buffit_beta/screens/register/register_animation_screen.dart';
import 'package:buffit_beta/theme.dart';
import 'package:buffit_beta/validation/signup_validation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'blocs/bloc.dart';
import 'blocs/postsBloc.dart';

final authBloc = AuthBloc();
final courseBloc = CourseBloc();
final postsBloc = PostsBloc();

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      Provider(create: (context) => authBloc),
      Provider(create: (context) => courseBloc),
      Provider(create: (context) => postsBloc),
      FutureProvider(create: (context) => authBloc.isLoggedIn()),
      InheritedProvider(
        create: (context) => SignupValidation(),
      )
    ], child: PlatformApp());
  }

  @override
  void dispose() {
    authBloc.dispose();
    courseBloc.dispose();
    postsBloc.dispose();
    super.dispose();
  }
}

class PlatformApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var isLoggedIn = Provider.of<bool>(context);
    User user = FirebaseAuth.instance.currentUser;
    // var podminka = user == null ? null : user.metadata.creationTime;
    // print('---------------------$podminka-------------------------');
    return MaterialApp(
        builder: (context, child) {
          return ScrollConfiguration(
            behavior: MyBehavior(),
            child: child,
          );
        },
        home: (isLoggedIn == null)
            ? Login()
            : (isLoggedIn == true)
                ? Home()
                : Login(),
        debugShowCheckedModeBanner: false,
        onGenerateRoute: Routes.materialRoutes,
        theme: theme());
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
