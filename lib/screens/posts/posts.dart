import 'package:buffit_beta/blocs/courseBloc.dart';
import 'package:buffit_beta/models/course.dart';
import 'package:buffit_beta/widgets/header.dart';
import 'package:buffit_beta/widgets/bottomMenu.dart';
import 'package:buffit_beta/widgets/homeButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../size_config.dart';

class Posts extends StatefulWidget {
  @override
  _PostsState createState() => _PostsState();
}

class _PostsState extends State<Posts> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var courseBloc = Provider.of<CourseBloc>(context, listen: false);
      courseBloc.fetchIgPosts();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var courseBloc = Provider.of<CourseBloc>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
          title: SvgPicture.asset('assets/images/buffit.svg',
              width: getProportionateScreenWidth(110))),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<List<String>>(
                stream: courseBloc.igStream,
                builder: (context, snapshot) {
                  return (snapshot.data == null)
                      ? Container()
                      : ListView.builder(
                          itemCount: snapshot.data.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Container(
                                width: 200,
                                padding: EdgeInsets.only(right: 10),
                                height: 200,
                                child: Image.network(
                                  snapshot.data[index],
                                ));
                          },
                        );
                }),
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: HomeButton(),
      bottomNavigationBar: BottomMenu(),
    );
  }
}
