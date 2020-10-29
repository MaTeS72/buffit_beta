import 'dart:async';

import 'package:buffit_beta/blocs/bloc.dart';
import 'package:buffit_beta/constants.dart';
import 'package:buffit_beta/models/application_user.dart';

import 'package:buffit_beta/screens/Login/login.dart';
import 'package:buffit_beta/screens/home/components/body.dart';
import 'package:buffit_beta/screens/videos/videos.dart';
import 'package:buffit_beta/widgets/bottomMenu.dart';
import 'package:buffit_beta/widgets/homeButton.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../size_config.dart';

class Home extends StatefulWidget {
  static String routeName = "/home";
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  StreamSubscription<ApplicationUser> homeStateSubscription;

  //TODO: zmenšit avatar, najít pushnamed

  @override
  void initState() {
    var authBloc = Provider.of<AuthBloc>(context, listen: false);
    homeStateSubscription = authBloc.user.listen((user) {
      if (user == null) {
        Navigator.pushReplacementNamed(context, Login.routeName);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    homeStateSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var authBloc = Provider.of<AuthBloc>(context);
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: SvgPicture.asset('assets/images/buffit.svg',
            width: getProportionateScreenWidth(110)),
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              authBloc.logout();
            },
            child: StreamBuilder<User>(
                stream: authBloc.currentUser,
                builder: (context, snapshot) {
                  if (!snapshot.hasData || snapshot.data == null)
                    return CircularProgressIndicator();
                  if (snapshot.data.photoURL == null) {
                    return FlatButton(
                        onPressed: () => authBloc.logout(),
                        child: Text(snapshot.data.email.substring(0, 2)));
                  } else {
                    return CircleAvatar(
                      backgroundImage: NetworkImage(
                          snapshot.data.photoURL + '?width=100&height100'),
                      radius: 30.0,
                    );
                  }
                }),
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: HomeButton(),
      bottomNavigationBar: BottomMenu(),
      body: Body(),
    );
  }
}
