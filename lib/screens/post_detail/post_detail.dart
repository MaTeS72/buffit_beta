import 'package:buffit_beta/blocs/courseBloc.dart';
import 'package:buffit_beta/blocs/postsBloc.dart';
import 'package:buffit_beta/models/album.dart';
import 'package:buffit_beta/styles/text.dart';
import 'package:buffit_beta/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../size_config.dart';

class PostDetail extends StatefulWidget {
  final String postId;

  const PostDetail({Key key, this.postId}) : super(key: key);

  @override
  _PostDetailState createState() => _PostDetailState();
}

class _PostDetailState extends State<PostDetail> {
  @override
  Widget build(BuildContext context) {
    var postsBloc = Provider.of<PostsBloc>(context);

    return Scaffold(
      appBar: CustomAppBar(),
      extendBody: true,
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<Album>(
                future: postsBloc.fetchpost(widget.postId),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data.images.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          if (snapshot.data.images[index] != null) {
                            return Container(
                                width: 325,
                                height: 325,
                                padding: EdgeInsets.only(right: 10),
                                child:
                                    Image.network(snapshot.data.images[index]));
                          } else {
                            return Center(child: CircularProgressIndicator());
                          }
                        });
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                }),
          ),
          Text('Sleduj @buffityt', style: TextStyles.courseDetailTitle),
        ],
      ),
    );
  }
}
