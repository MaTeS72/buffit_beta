import 'package:buffit_beta/blocs/courseBloc.dart';
import 'package:buffit_beta/models/category.dart';
import 'package:buffit_beta/models/course.dart';
import 'package:buffit_beta/styles/colors.dart';
import 'package:buffit_beta/styles/text.dart';
import 'package:buffit_beta/widgets/header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../size_config.dart';

class CourseDetail extends StatefulWidget {
  final String courseId;

  const CourseDetail({Key key, this.courseId}) : super(key: key);

  @override
  _CourseDetailState createState() => _CourseDetailState();
}

class _CourseDetailState extends State<CourseDetail> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var courseBloc = Provider.of<CourseBloc>(context);

    return Scaffold(
        appBar: AppBar(
          title: SvgPicture.asset('assets/images/buffit.svg',
              width: getProportionateScreenWidth(110)),
        ),
        body: SingleChildScrollView(
          child: Stack(children: [
            Positioned(
                top: 300,
                child: SvgPicture.asset('assets/images/blue_triangle.svg')),
            Positioned(
                top: 322,
                child: SvgPicture.asset('assets/images/grey_triangle.svg')),
            Column(
              children: [
                FutureBuilder<Course>(
                    future: courseBloc.fetchCourse(widget.courseId),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        if (widget.courseId != null) {
                          var course = snapshot.data;
                          return Stack(
                            children: [
                              Container(
                                height: getProportionateScreenHeight(165),
                                decoration: BoxDecoration(
                                    color: AppColors.primaryblue,
                                    backgroundBlendMode: BlendMode.difference,
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(70),
                                        bottomRight: Radius.circular(70))),
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 20),
                                height: getProportionateScreenHeight(155),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: AppColors.darkgreycolor,
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(70),
                                        bottomRight: Radius.circular(70))),
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 50),
                                  child: Text(
                                    course.title,
                                    style: TextStyles.courseDetailTitle,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                    maxLines: 2,
                                  ),
                                ),
                              ),
                            ],
                          );
                        } else {
                          return Container();
                        }
                      } else {
                        return CircularProgressIndicator();
                      }
                    }),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Kategorie',
                        style: TextStyles.courseTitle,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 200,
                  child: StreamBuilder<List<Category>>(
                      stream: courseBloc.fetchCategory(widget.courseId),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          print(snapshot.data[0].title);
                          return ListView.builder(
                              itemCount: snapshot.data.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                var category = snapshot.data[index];
                                print(category.uid);
                                return Padding(
                                  padding: EdgeInsets.only(left: 20),
                                  child: Stack(children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: AssetImage(
                                                  'assets/images/code.png')),
                                          borderRadius:
                                              BorderRadius.circular(25)),
                                      height: 190,
                                      width: 175,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Colors.black54,
                                          borderRadius:
                                              BorderRadius.circular(25)),
                                      height: 190,
                                      width: 175,
                                      child: Center(
                                          child: Stack(children: [
                                        Text(
                                          category.title,
                                          style: TextStyle(
                                              fontSize: 20,
                                              decoration:
                                                  TextDecoration.underline,
                                              decorationStyle:
                                                  TextDecorationStyle.double,
                                              decorationColor:
                                                  AppColors.primaryblue),
                                          textAlign: TextAlign.center,
                                        ),
                                      ])),
                                    ),
                                  ]),
                                );
                              });
                        } else {
                          return CircularProgressIndicator();
                        }
                      }),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Kvízy',
                        style: TextStyles.courseTitle,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 200,
                  child: StreamBuilder<List<Category>>(
                      stream: courseBloc.fetchCategory(widget.courseId),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          print(snapshot.data[0].title);
                          return ListView.builder(
                              itemCount: snapshot.data.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                var category = snapshot.data[index];
                                print(category.uid);
                                return Padding(
                                  padding: EdgeInsets.only(left: 20),
                                  child: Stack(children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: AssetImage(
                                                  'assets/images/code.png')),
                                          borderRadius:
                                              BorderRadius.circular(25)),
                                      height: 190,
                                      width: 175,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Colors.black54,
                                          borderRadius:
                                              BorderRadius.circular(25)),
                                      height: 190,
                                      width: 175,
                                      child: Center(
                                          child: Stack(children: [
                                        Text(
                                          category.title,
                                          style: TextStyle(
                                              fontSize: 20,
                                              decoration:
                                                  TextDecoration.underline,
                                              decorationStyle:
                                                  TextDecorationStyle.double,
                                              decorationColor:
                                                  AppColors.primaryblue),
                                          textAlign: TextAlign.center,
                                        ),
                                      ])),
                                    ),
                                  ]),
                                );
                              });
                        } else {
                          return CircularProgressIndicator();
                        }
                      }),
                ),
              ],
            ),
          ]),
        ));
  }
}
