import 'package:buffit_beta/blocs/courseBloc.dart';
import 'package:buffit_beta/models/course.dart';
import 'package:buffit_beta/widgets/bottomMenu.dart';
import 'package:buffit_beta/widgets/homeButton.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Programming extends StatefulWidget {
  static String routeName = "/programming";
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
      body: SafeArea(
          child: StreamBuilder<List<Course>>(
              stream: courseBloc.getCourseList(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return CircularProgressIndicator();

                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      var course = snapshot.data[index];
                      return Text(course.title);
                    });
              })),
    );
  }
}
