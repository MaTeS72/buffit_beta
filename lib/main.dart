import 'package:buffit_beta/screens/Login/login.dart';
import 'package:buffit_beta/services/firestore_service.dart';
import 'package:buffit_beta/size_config.dart';
import 'package:buffit_beta/theme.dart';
import 'package:buffit_beta/validation/signup_validation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'blocs/bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final FirestoreService _db = FirestoreService();

    return MultiProvider(
      providers: [
        StreamProvider(create: (BuildContext context) => _db.getVideos()),
        Provider(create: (context) => AuthBloc()),
        InheritedProvider(
          create: (context) => SignupValidation(),
        )
      ],
      child: MaterialApp(
        title: 'Facebook Login',
        debugShowCheckedModeBanner: false,
        theme: theme(),
        home: Login(),
      ),
    );
  }
}
