import 'package:buffit_beta/screens/home/widgets/quiz_item.dart';
import 'package:buffit_beta/styles/text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class QuizList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 169,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(width: 20),
              Text(
                'Nejnovější kvízy',
                style: TextStyles.sectionTitle,
                textAlign: TextAlign.start,
              ),
            ],
          ),
          SizedBox(height: 10),
          Container(
            height: 125,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                QuizItem(),
                QuizItem(),
                QuizItem(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
