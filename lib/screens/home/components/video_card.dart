import 'package:buffit_beta/size_config.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';

class VideoCard extends StatefulWidget {
  final itemIndex;
  final video;

  const VideoCard({Key key, this.itemIndex, this.video}) : super(key: key);

  @override
  _VideoCardState createState() => _VideoCardState();
}

class _VideoCardState extends State<VideoCard> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.fromLTRB(10, 0, 10, 25),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Color(0xFF3B3939),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(height: 80, width: 120, color: Colors.grey),
              SizedBox(
                width: 10,
              ),
              Column(
                children: <Widget>[
                  Text(
                    '${widget.video.title}',
                    style: TextStyle(color: kPrimaryColor, fontSize: 17),
                  ),
                  SizedBox(height: getProportionateScreenWidth(15)),
                  Row(
                    children: <Widget>[
                      Icon(Icons.schedule, size: 18, color: kPrimaryColor),
                      Text(
                        '${widget.video.length}',
                        style: TextStyle(color: kPrimaryColor, fontSize: 16),
                      ),
                      Text(' min',
                          style: TextStyle(color: kPrimaryColor, fontSize: 16)),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          left: getProportionateScreenWidth(250),
          top: getProportionateScreenWidth(88),
          child: Row(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  setState(() {
                    widget.video.favorite = !widget.video.favorite;
                  });
                },
                child: Container(
                  padding: EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: widget.video.favorite
                        ? Color(0xFF27A537)
                        : Color(0xFF898686),
                  ),
                  child: Icon(
                    Icons.add,
                    color: Color(0xFF2A2727),
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          left: getProportionateScreenWidth(310),
          top: getProportionateScreenWidth(75),
          child: Icon(
            Icons.cloud_done,
            size: 50,
            color: Colors.blueAccent,
          ),
        )
      ],
    );
  }
}
