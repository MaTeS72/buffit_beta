import 'package:buffit_beta/blocs/courseBloc.dart';
import 'package:buffit_beta/models/category.dart';
import 'package:buffit_beta/models/course.dart';
import 'package:buffit_beta/screens/course/categories_screen.dart';
import 'package:buffit_beta/screens/course/quiz_screen.dart';
import 'package:buffit_beta/styles/colors.dart';
import 'package:buffit_beta/styles/text.dart';
import 'package:buffit_beta/widgets/custom_appbar.dart';
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

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        extendBody: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text('Buff It', style: TextStyles.appBarTitle),
          centerTitle: true,
          bottom: TabBar(
            tabs: [
              Tab(
                text: 'Kategorie',
              ),
              Tab(
                text: 'Kvízy',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            CategoriesScreen(),
            QuizScreen(),
          ],
        ),
      ),
    );
  }
}
