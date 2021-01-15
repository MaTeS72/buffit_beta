import 'package:flutter/material.dart';

class InstagramCard extends StatelessWidget {
  var image;
  InstagramCard(this.image);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFCD5815).withOpacity(0.9),
              Color(0xFFC01A95),
            ]),
      ),
      padding: EdgeInsets.all(5),
      child: ClipRRect(
        child: Image.network(
          image,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
    );
  }
}
