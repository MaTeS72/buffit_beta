import 'package:buffit_beta/blocs/courseBloc.dart';
import 'package:buffit_beta/models/course.dart';
import 'package:buffit_beta/styles/colors.dart';
import 'package:buffit_beta/styles/text.dart';
import 'package:buffit_beta/widgets/bottomMenu.dart';
import 'package:buffit_beta/widgets/header.dart';
import 'package:buffit_beta/widgets/homeButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../size_config.dart';

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
      appBar: AppBar(
        title: SvgPicture.asset('assets/images/buffit.svg',
            width: getProportionateScreenWidth(110)),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                children: [
                  Container(
                    height: getProportionateScreenHeight(185),
                    decoration: BoxDecoration(
                        color: AppColors.primaryblue,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(70),
                            bottomRight: Radius.circular(70))),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 10),
                    height: getProportionateScreenHeight(175),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: AppColors.darkgreycolor,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(70),
                            bottomRight: Radius.circular(70))),
                    child: Text(
                      'Nauč se \n programovat',
                      style: TextStyles.courseDetailTitle,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: getProportionateScreenWidth(20),
              ),
              Flexible(
                fit: FlexFit.loose,
                child: StreamBuilder<List<Course>>(
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
                                child: Container(
                                  height: getProportionateScreenWidth(90),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: AppColors.darkgreycolor,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        20, 15, 10, 10),
                                    child: Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(course.title,
                                                style: TextStyles.courseTitle),
                                            Text(course.subtitle,
                                                style:
                                                    TextStyles.courseSubtitle)
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          });
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
