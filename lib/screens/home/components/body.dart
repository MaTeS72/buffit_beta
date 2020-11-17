import 'package:buffit_beta/widgets/header.dart';
import 'package:buffit_beta/services/firestore_service.dart';
import 'package:flutter/material.dart';

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
            Header(title: 'Learn Fast'),
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
