import 'package:buffit_beta/models/course.dart';
import 'package:buffit_beta/styles/colors.dart';
import 'package:buffit_beta/styles/text.dart';
import 'package:flutter/material.dart';

import '../../size_config.dart';

class CourseCard extends StatelessWidget {
  CourseCard(this.course);
  final Course course;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getProportionateScreenWidth(90),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: AppColors.bluegradient,
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 15, 10, 10),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(course.title, style: TextStyles.courseTitle),
                Text(course.subtitle, style: TextStyles.courseSubtitle)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
