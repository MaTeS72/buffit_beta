import 'package:buffit_beta/blocs/postsBloc.dart';
import 'package:buffit_beta/models/album.dart';
import 'package:buffit_beta/screens/home/widgets/instagram_card.dart';
import 'package:buffit_beta/styles/colors.dart';
import 'package:buffit_beta/styles/text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class InstagramPosts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var postsBloc = Provider.of<PostsBloc>(context);
    return Container(
      decoration: BoxDecoration(),
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 20,
              ),
              Text(
                'Nejnovější Instagram posty',
                style: TextStyles.sectionTitle,
                textAlign: TextAlign.start,
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: <Widget>[
              Container(
                height: 175,
                width: MediaQuery.of(context).size.width,
                child: StreamBuilder<List<Album>>(
                    stream: postsBloc.fetchNewPosts(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                            itemCount: snapshot.data.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              if (snapshot.data[index] != null &&
                                  snapshot.connectionState !=
                                      ConnectionState.waiting) {
                                return InstagramCard(
                                    snapshot.data[index].images[0]);
                              } else {
                                print('loading');
                                return Container(
                                  height: 150,
                                  width: 150,
                                );
                              }
                            });
                      } else {
                        return Container(
                          height: 150,
                          width: 150,
                        );
                      }
                    }),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
