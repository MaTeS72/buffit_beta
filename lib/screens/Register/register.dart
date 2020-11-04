import 'dart:async';

import 'package:buffit_beta/blocs/bloc.dart';
import 'package:buffit_beta/models/application_user.dart';
import 'package:buffit_beta/screens/Login/login.dart';
import 'package:buffit_beta/screens/home/home.dart';
import 'package:buffit_beta/styles/colors.dart';
import 'package:buffit_beta/validation/signup_validation.dart';
import 'package:buffit_beta/widgets/textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';
import 'package:rxdart/rxdart.dart';

import '../../constants.dart';
import '../../size_config.dart';

class Register extends StatefulWidget {
  static String routeName = "/register";
  @override
  _RegisterState createState() => _RegisterState();
}

/*
TODO
  disable buttonu, pokud nebude správně
*/

class _RegisterState extends State<Register> {
  StreamSubscription<ApplicationUser> loginStateSubscription;
  RiveAnimationController _wipersController;
  Artboard _artboard;
  bool _wipers = false;
  bool checkRegisterFinish = false;
  bool isLoading = false;

  bool isSecond = false;
  var nameController = TextEditingController();

  @override
  void initState() {
    _loadRiveFile();
    var authBloc = Provider.of<AuthBloc>(context, listen: false);
    loginStateSubscription = authBloc.user.listen((user) {
      if (user != null) {
        Navigator.pushReplacementNamed(context, Home.routeName);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    loginStateSubscription.cancel();
    super.dispose();
  }

  void _loadRiveFile() async {
    final bytes = await rootBundle.load('assets/images/steps.riv');
    final file = RiveFile();
    if (file.import(bytes)) {
      setState(() => _artboard = file.mainArtboard
        ..addController(SimpleAnimation('idle')));
    }
  }

  void _wipersChange(bool wipersOn) {
    if (wipersOn == true) {
      _artboard.addController(
        _wipersController = SimpleAnimation('open'),
      );
      setState(() => _wipersController.isActive = true);
    } else {
      _artboard.removeController(_wipersController);
      _artboard.addController(
        _wipersController = SimpleAnimation('close'),
      );
      setState(() => _wipersController.isActive = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    var authBloc = Provider.of<AuthBloc>(context, listen: false);
    final _formsPageViewController = PageController();
    List _forms;

    void _nextFormStep() {
      _formsPageViewController.nextPage(
        duration: Duration(milliseconds: 400),
        curve: Curves.ease,
      );
    }

    bool onWillPop() {
      _wipersChange(false);
      if (_formsPageViewController.page.round() ==
          _formsPageViewController.initialPage) return true;

      _formsPageViewController.previousPage(
        duration: Duration(milliseconds: 400),
        curve: Curves.ease,
      );

      return false;
    }

    _forms = [
      WillPopScope(
          onWillPop: () => Future.sync(onWillPop),
          child: ListView(
            children: [
              SizedBox(height: 2),
              StreamBuilder<String>(
                  stream: authBloc.name,
                  builder: (context, snapshot) {
                    return AppTextField(
                      initialText: 'Jméno',
                      hintText: 'Zadejte své jméno',
                      controller: nameController,
                      errorText: snapshot.error,
                      materialIcon: Icon(Icons.person_outline),
                      onChanged: authBloc.changeName,
                    );
                  }),
              SizedBox(height: 20),
              StreamBuilder<String>(
                  stream: authBloc.lastName,
                  builder: (context, snapshot) {
                    return AppTextField(
                      initialText: 'Příjmení',
                      hintText: 'Zadejte své příjmení',
                      errorText: snapshot.error,
                      materialIcon: Icon(Icons.person_outline),
                      onChanged: authBloc.changeLastName,
                    );
                  }),
              SizedBox(height: 20),
              StreamBuilder<Object>(
                  stream: authBloc.profession,
                  builder: (context, snapshot) {
                    return AppTextField(
                      initialText: 'Profese',
                      hintText: 'Zadejte svou profesi',
                      errorText: snapshot.error,
                      materialIcon: Icon(Icons.home_repair_service_outlined),
                      onChanged: authBloc.changeProfession,
                    );
                  }),
              SizedBox(height: getProportionateScreenWidth(5)),
              StreamBuilder<String>(
                  stream: authBloc.errorMessage,
                  builder: (context, snapshot) {
                    if (snapshot.data != '' && snapshot.data != null) {
                      return Text(snapshot.data,
                          style: TextStyle(color: Colors.red));
                    } else {
                      return Text('');
                    }
                  }),
              StreamBuilder<Object>(
                  stream: authBloc.isMatchingandValid,
                  builder: (context, snapshot) {
                    return Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20)),
                      height: 65,
                      width: double.infinity,
                      child: StreamBuilder<bool>(
                          stream: authBloc.register1IsValid,
                          builder: (context, snapshot) {
                            return FlatButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              onPressed: () {
                                if (snapshot.data == true) {
                                  _wipersChange(true);
                                  _nextFormStep();
                                }
                              },
                              color: (snapshot.data == true)
                                  ? Color(0xFF00B2F5)
                                  : Color(0xFF00B2F5).withOpacity(0.3),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Další',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  Icon(Icons.arrow_right)
                                ],
                              ),
                              textColor: kPrimaryColor,
                            );
                          }),
                    );
                  }),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Už máte účet? '),
                  GestureDetector(
                    child: Text(
                      'Přihlásit se',
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => Login()));
                    },
                  )
                ],
              )
            ],
          )),
      WillPopScope(
          onWillPop: () => Future.sync(onWillPop),
          child: ListView(
            children: [
              StreamBuilder<String>(
                  stream: authBloc.email,
                  builder: (context, snapshot) {
                    return AppTextField(
                        initialText: 'Email',
                        hintText: 'Zadejte svůj email',
                        materialIcon: Icon(Icons.email_outlined),
                        onChanged: authBloc.changeEmail,
                        errorText: snapshot.error);
                  }),
              SizedBox(height: 20),
              StreamBuilder<String>(
                  stream: authBloc.password,
                  builder: (context, snapshot) {
                    return AppTextField(
                        initialText: 'Heslo',
                        hintText: 'Zadejte své jméno',
                        obscureText: true,
                        materialIcon: Icon(Icons.lock_outlined),
                        onChanged: authBloc.changePassword,
                        errorText: snapshot.error);
                  }),
              SizedBox(height: 20),
              StreamBuilder<Object>(
                  stream: authBloc.passwordAgain,
                  builder: (context, snapshot) {
                    return AppTextField(
                      initialText: 'Heslo Znovu',
                      hintText: 'Zadejte své heslo znovu',
                      obscureText: true,
                      materialIcon: Icon(Icons.lock_outlined),
                      onChanged: authBloc.changePasswordAgain,
                      errorText: snapshot.error,
                    );
                  }),
              SizedBox(height: getProportionateScreenWidth(5)),
              StreamBuilder<String>(
                  stream: authBloc.errorMessage,
                  builder: (context, snapshot) {
                    if (snapshot.data != '' && snapshot.data != null) {
                      return Text(snapshot.data,
                          style: TextStyle(color: Colors.red));
                    } else {
                      return Text('');
                    }
                  }),
              SizedBox(height: getProportionateScreenWidth(10)),
              StreamBuilder<Object>(
                  stream: authBloc.isMatchingandValid,
                  builder: (context, snapshot) {
                    return Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20)),
                      height: 65,
                      width: double.infinity,
                      child: StreamBuilder<bool>(
                          stream: authBloc.isMatchingandValid,
                          builder: (context, snapshot) {
                            return FlatButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              onPressed: () {
                                if (snapshot.data == true) {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  authBloc
                                      .registerWithEmailAndPassword()
                                      .then((value) {
                                    setState(() {
                                      isLoading = false;
                                    });
                                  });
                                }
                              },
                              color: (snapshot.data == true)
                                  ? Color(0xFF00B2F5)
                                  : Color(0xFF00B2F5).withOpacity(0.3),
                              child: Text(
                                'Registrovat se',
                                style: TextStyle(fontSize: 20),
                              ),
                              textColor: kPrimaryColor,
                            );
                          }),
                    );
                  }),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Už máte účet? '),
                  GestureDetector(
                    child: Text(
                      'Přihlásit se',
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => Login()));
                    },
                  )
                ],
              )
            ],
          )),
    ];

    SizeConfig().init(context);
    return SafeArea(
      child: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Scaffold(
              appBar: AppBar(
                  title: SvgPicture.asset('assets/images/buffit.svg',
                      width: getProportionateScreenWidth(110))),
              body: ListView(
                children: [
                  Stack(
                    children: <Widget>[
                      Container(
                        height: getProportionateScreenHeight(200),
                        decoration: BoxDecoration(
                            color: kSecondaryColorShade,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(70),
                                bottomRight: Radius.circular(70))),
                      ),
                      //  Container(child: SvgPicture.asset('assets\images\cap.svg')),
                      Positioned(
                        left: getProportionateScreenWidth(30),
                        top: getProportionateScreenHeight(25),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Sign',
                              style: GoogleFonts.sourceSansPro(
                                textStyle: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: getProportionateScreenWidth(50),
                                    color: kPrimaryColor),
                              ),
                            ),
                            Container(
                              height: 5,
                              width: 50,
                              color: Colors.red,
                            ),
                            Row(
                              children: <Widget>[
                                SizedBox(
                                  width: getProportionateScreenWidth(60),
                                ),
                                Text('Up',
                                    style: GoogleFonts.sourceSansPro(
                                      textStyle: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize:
                                              getProportionateScreenWidth(50),
                                          color: kPrimaryColor),
                                    )),
                                Text(
                                  '.',
                                  style: TextStyle(
                                      fontSize: getProportionateScreenWidth(50),
                                      color: Color(0xFF00B2F5)),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                          width: double.infinity,
                          margin: EdgeInsets.only(
                              top: getProportionateScreenWidth(10)),
                          child: SvgPicture.asset(
                            'assets/images/cap4.svg',
                            height: 200,
                            alignment: new Alignment(4, 0),
                          )),
                    ],
                  ),
                  Padding(
                      padding: EdgeInsets.only(right: 100),
                      child: Container(
                        height: 50,
                        width: 100,
                        child: Rive(
                          artboard: _artboard,
                          fit: BoxFit.fitHeight,
                        ),
                      )),
                  SizedBox(
                    height: getProportionateScreenWidth(15),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(30)),
                    child: Container(
                      height: 350,
                      child: PageView.builder(
                        controller: _formsPageViewController,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return _forms[index];
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: getProportionateScreenWidth(25),
                  ),
                ],
              ),
            ),
    );
  }
}
