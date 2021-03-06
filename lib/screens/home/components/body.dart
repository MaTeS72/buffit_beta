import 'dart:async';

import 'package:buffit_beta/blocs/bloc.dart';
import 'package:buffit_beta/models/Video.dart';
import 'package:buffit_beta/widgets/header.dart';
import 'package:buffit_beta/screens/home/components/video_card.dart';
import 'package:buffit_beta/services/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    FirestoreService _db = FirestoreService();

    return SingleChildScrollView(
      physics: ScrollPhysics(parent: BouncingScrollPhysics()),
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Header(),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
              child: Row(
                children: <Widget>[
                  Text(
                    '',
                    style: TextStyle(color: kPrimaryColor, fontSize: 20),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
