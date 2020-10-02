import 'dart:async';

import 'package:buffit_beta/blocs/bloc.dart';
import 'package:buffit_beta/constants.dart';
import 'package:buffit_beta/myList/my_list.dart';
import 'package:buffit_beta/screens/Login/login.dart';
import 'package:buffit_beta/screens/home/components/body.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../size_config.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  StreamSubscription<User> homeStateSubscription;

  @override
  void initState() {
    var authBloc = Provider.of<AuthBloc>(context, listen: false);
    homeStateSubscription = authBloc.currentUser.listen((fbUser) {
      if (fbUser == null) {
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (context) => Login()));
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
        elevation: 0,
        title: Text(
          'BUFF IT',
          style: TextStyle(color: kSecondaryColor),
        ),
        backgroundColor: Color(0xFF3B3939),
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              authBloc.logout();
            },
            child: StreamBuilder<User>(
                stream: authBloc.currentUser,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return CircularProgressIndicator();
                  return CircleAvatar(
                    backgroundImage: NetworkImage(
                        snapshot.data.photoURL + '?width=100&height100'),
                    radius: 30.0,
                  );
                }),
          )
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: kSecondaryColorShade,
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(30)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                  icon: Icon(Icons.code),
                  color: Color(0xFF7D7A7A),
                  iconSize: 35,
                  onPressed: () {}),
              IconButton(
                  icon: Icon(Icons.home),
                  color: kPrimaryColor,
                  iconSize: 35,
                  onPressed: () {}),
              IconButton(
                  icon: Icon(Icons.movie_creation),
                  color: Color(0xFF7D7A7A),
                  iconSize: 35,
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => MyList()));
                  })
            ],
          ),
        ),
      ),
      body: Body(),
    );
  }
}
