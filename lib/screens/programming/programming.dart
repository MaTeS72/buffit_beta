import 'package:buffit_beta/blocs/courseBloc.dart';
import 'package:buffit_beta/models/course.dart';
import 'package:buffit_beta/styles/colors.dart';
import 'package:buffit_beta/styles/text.dart';
import 'package:buffit_beta/widgets/bottomMenu.dart';
import 'package:buffit_beta/widgets/custom_appbar.dart';
import 'package:buffit_beta/widgets/homeButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../size_config.dart';
import 'course_widget.dart';

class Programming extends StatefulWidget {
  @override
  _ProgrammingState createState() => _ProgrammingState();
}

class _ProgrammingState extends State<Programming> {
  @override
  Widget build(BuildContext context) {
    var courseBloc = Provider.of<CourseBloc>(context);

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: HomeButton(),
      bottomNavigationBar: BottomMenu(),
      extendBody: true,
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 25,
            ),
            SvgPicture.asset(
              'assets/icons/programming.svg',
              height: 50,
              color: AppColors.white,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Kurzy',
              style: TextStyles.screenTitle,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 10,
            ),
            StreamBuilder<List<Course>>(
                stream: courseBloc.getCourseList(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return CircularProgressIndicator();

                  return ListView.builder(
                      itemCount: snapshot.data.length,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        var course = snapshot.data[index];
                        return Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: getProportionateScreenWidth(20),
                              vertical: getProportionateScreenWidth(10)),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, '/course/${course.uid}');
                            },
                            child: CourseCard(course),
                          ),
                        );
                      });
                }),
          ],
        ),
      ),
    );
  }
}
