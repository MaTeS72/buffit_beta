import 'package:buffit_beta/blocs/courseBloc.dart';
import 'package:buffit_beta/blocs/postsBloc.dart';
import 'package:buffit_beta/models/album.dart';
import 'package:buffit_beta/models/course.dart';
import 'package:buffit_beta/screens/posts/instagram_card.dart';
import 'package:buffit_beta/styles/colors.dart';
import 'package:buffit_beta/styles/text.dart';
import 'package:buffit_beta/widgets/bottomMenu.dart';
import 'package:buffit_beta/widgets/custom_appbar.dart';
import 'package:buffit_beta/widgets/homeButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
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

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var postsBloc = Provider.of<PostsBloc>(context, listen: false);

    return Scaffold(
      extendBody: true,
      appBar: CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 25,
            ),
            SvgPicture.asset(
              'assets/icons/instagram.svg',
              height: 50,
              color: AppColors.white,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Všechny Instagram posty',
              style: TextStyles.screenTitle,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: StreamBuilder<List<Album>>(
                  stream: postsBloc.postStream(),
                  builder: (context, snapshot) {
                    return (snapshot.data == null)
                        ? Container()
                        : GridView.builder(
                            itemCount: snapshot.data.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10.0,
                            ),
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context,
                                      '/post/${snapshot.data[index].uid}');
                                },
                                child: InstagramCard(
                                    snapshot.data[index].images[0]),
                              );
                            },
                          );
                  }),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: HomeButton(),
      bottomNavigationBar: BottomMenu(),
    );
  }
}
