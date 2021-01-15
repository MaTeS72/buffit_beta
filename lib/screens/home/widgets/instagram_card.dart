import 'package:buffit_beta/styles/colors.dart';
import 'package:flutter/material.dart';

class InstagramCard extends StatelessWidget {
  final String image;

  InstagramCard(this.image);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: 175,
      margin: EdgeInsets.only(left: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: AppColors.orangegradient,
      ),
      padding: EdgeInsets.all(5),
      child: ClipRRect(
        child: Image.network(
          image,
          loadingBuilder: (BuildContext context, Widget child,
              ImageChunkEvent loadingProgress) {
            if (loadingProgress == null) return child;
            return Center(
                child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                      loadingProgress.expectedTotalBytes
                  : null,
            ));
          },
        ),
        borderRadius: BorderRadius.circular(15),
      ),
    );
  }
}
