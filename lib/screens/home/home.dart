import 'dart:async';
import 'package:buffit_beta/blocs/bloc.dart';
import 'package:buffit_beta/blocs/postsBloc.dart';
import 'package:buffit_beta/models/album.dart';
import 'package:buffit_beta/models/application_user.dart';
import 'package:buffit_beta/screens/home/widgets/course_list.dart';
import 'package:buffit_beta/screens/home/widgets/instagram_card.dart';
import 'package:buffit_beta/screens/home/widgets/instagram_posts.dart';
import 'package:buffit_beta/screens/home/widgets/quiz_list.dart';
import 'package:buffit_beta/services/instagram_posts_service.dart';
import 'package:buffit_beta/styles/colors.dart';
import 'package:buffit_beta/styles/text.dart';
import 'package:buffit_beta/widgets/bottomMenu.dart';
import 'package:buffit_beta/widgets/homeButton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../size_config.dart';

class Home extends StatefulWidget {
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
        Navigator.pushReplacementNamed(context, '/login');
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
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: Text('Buff It', style: TextStyles.appBarTitle),
        // leading: GestureDetector(
        //   child: StreamBuilder<User>(
        //       stream: authBloc.currentUser,
        //       builder: (context, snapshot) {
        //         if (snapshot.data != null) {
        //           if (snapshot.data.photoURL == null) {
        //             return FlatButton(
        //                 onPressed: null,
        //                 child: Text(snapshot.data.email.substring(0, 2)));
        //           } else {
        //             return Container(
        //               margin: EdgeInsets.only(top: 10, left: 10),
        //               decoration: BoxDecoration(
        //                 borderRadius: BorderRadius.circular(50),
        //                 image: DecorationImage(
        //                   image: NetworkImage(
        //                     snapshot.data.photoURL,
        //                   ),
        //                   fit: BoxFit.cover,
        //                 ),
        //                 color: Colors.blue,
        //               ),
        //             );
        //           }
        //         }
        //         return Container();
        //       }),
        // ),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.exit_to_app), onPressed: authBloc.logout),
        ],
      ),
      extendBody: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: HomeButton(),
      bottomNavigationBar: BottomMenu(),
      body: SingleChildScrollView(
        physics: ScrollPhysics(parent: BouncingScrollPhysics()),
        child: Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                height: getProportionateScreenWidth(10),
              ),
              SizedBox(
                height: getProportionateScreenWidth(20),
              ),
              CourseList(),
              SizedBox(
                height: getProportionateScreenWidth(5),
              ),
              InstagramPosts(),
              SizedBox(
                height: getProportionateScreenWidth(20),
              ),
              QuizList(),
              SizedBox(
                height: 50,
              )
            ],
          ),
        ),
      ),
    );
  }
}
