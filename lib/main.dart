import 'package:buffit_beta/screens/Login/login.dart';
import 'package:buffit_beta/screens/home/home.dart';
import 'package:buffit_beta/services/firestore_service.dart';
import 'package:buffit_beta/size_config.dart';
import 'package:buffit_beta/theme.dart';
import 'package:buffit_beta/validation/signup_validation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app.dart';
import 'blocs/bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(App());
}
