import 'package:buffit_beta/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class QuizItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: AppColors.greengradient,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Proměnné',
                style: GoogleFonts.nunito(
                  textStyle: TextStyle(fontSize: 24),
                ),
              ),
              Text('2hod 10min',
                  style:
                      GoogleFonts.nunito(textStyle: TextStyle(fontSize: 14))),
            ],
          ),
          margin: EdgeInsets.only(left: 15),
        ),
      ],
    );
  }
}
