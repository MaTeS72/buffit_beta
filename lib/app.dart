import 'package:buffit_beta/blocs/courseBloc.dart';
import 'package:buffit_beta/routes.dart';
import 'package:buffit_beta/screens/Login/login.dart';
import 'package:buffit_beta/screens/home/home.dart';
import 'package:buffit_beta/theme.dart';
import 'package:buffit_beta/validation/signup_validation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'blocs/bloc.dart';

final authBloc = AuthBloc();

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      Provider(create: (context) => AuthBloc()),
      Provider(create: (context) => CourseBloc()),
      FutureProvider(create: (context) => authBloc.isLoggedIn()),
      InheritedProvider(
        create: (context) => SignupValidation(),
      )
    ], child: PlatformApp());
  }

  @override
  void dispose() {
    authBloc.dispose();
    super.dispose();
  }
}

class PlatformApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var isLoggedIn = Provider.of<bool>(context);

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
