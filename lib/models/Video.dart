import 'package:flutter/cupertino.dart';

class Video {
  String title;
  int length;
  bool favorite;
  String icon;
  String image;

  Video({this.title, this.length, this.favorite, this.icon, this.image});

  Video.fromJson(Map<String, dynamic> parsedJson)
      : title = parsedJson['title'],
        length = parsedJson['length'],
        favorite = parsedJson['favorite'],
        icon = parsedJson['icon'],
        image = parsedJson['image'];
}
