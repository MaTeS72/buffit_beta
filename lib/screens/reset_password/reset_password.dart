import 'package:buffit_beta/blocs/bloc.dart';
import 'package:buffit_beta/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../constants.dart';
import '../../size_config.dart';

class ResetPassword extends StatefulWidget {
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  @override
  Widget build(BuildContext context) {
    var authBloc = Provider.of<AuthBloc>(context);

    @override
    void dispose() {
      authBloc.dispose();
      super.dispose();
    }

    return Scaffold(
      appBar: AppBar(
          title: SvgPicture.asset('assets/images/buffit.svg',
              width: getProportionateScreenWidth(110))),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: <Widget>[
                Container(
                  height: getProportionateScreenHeight(250),
                  decoration: BoxDecoration(
                      color: AppColors.darkgreycolor,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(70),
                          bottomRight: Radius.circular(70))),
                ),
                //  Container(child: SvgPicture.asset('assets\images\cap.svg')),
                Positioned(
                  left: getProportionateScreenWidth(30),
                  top: getProportionateScreenHeight(45),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Password',
                        style: headingStyle1,
                      ),
                      Container(
                        height: 5,
                        width: 50,
                        color: Colors.red,
                      ),
                      Row(
                        children: <Widget>[
                          SizedBox(
                            width: getProportionateScreenWidth(40),
                          ),
                          Text(
                            'Reset',
                            style: headingStyle1,
                          ),
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
                    margin:
                        EdgeInsets.only(top: getProportionateScreenWidth(50)),
                    child: SvgPicture.asset(
                      'assets/images/cap4.svg',
                      height: 200,
                      alignment: new Alignment(4, 0),
                    )),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(20)),
              child: Form(
                child: Column(
                  children: [
                    SizedBox(height: getProportionateScreenWidth(80)),
                    StreamBuilder<Object>(
                        stream: authBloc.email,
                        builder: (context, snapshot) {
                          return TextFormField(
                              onChanged: authBloc.changeEmail,
                              decoration: InputDecoration(
                                  labelText: 'Email',
                                  hintText: 'Enter your email',
                                  errorText: snapshot.error));
                        }),
                    SizedBox(height: getProportionateScreenWidth(20)),
                    StreamBuilder<Object>(
                        stream: authBloc.isValid,
                        builder: (context, snapshot) {
                          return Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20)),
                            width: double.infinity,
                            height: getProportionateScreenWidth(60),
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              color: Color(0xFF00B2F5),
                              onPressed: () {
                                authBloc.resetPassword().then((value) =>
                                    Scaffold.of(context).showSnackBar(SnackBar(
                                      content: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            value,
                                            style: TextStyle(
                                                color: kPrimaryColor,
                                                fontSize:
                                                    getProportionateScreenWidth(
                                                        20)),
                                          ),
                                        ],
                                      ),
                                      backgroundColor: AppColors.darkgreycolor,
                                      duration: Duration(seconds: 3),
                                    )));
                              },
                              child: Text(
                                'Reset password',
                                style: TextStyle(fontSize: 20),
                              ),
                              textColor: kPrimaryColor,
                            ),
                          );
                        })
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
