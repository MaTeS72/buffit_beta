import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class RegisterAnimationScreen extends StatefulWidget {
  @override
  _RegisterAnimationScreenState createState() =>
      _RegisterAnimationScreenState();
}

class _RegisterAnimationScreenState extends State<RegisterAnimationScreen>
    with SingleTickerProviderStateMixin {
  AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Lottie.asset('assets/animations/register_animation.json',
          width: 200,
          height: 200,
          fit: BoxFit.fill,
          controller: controller, onLoaded: (composition) {
        //Has completed
        controller.addStatusListener((status) {
          if (status == AnimationStatus.completed) {
            print('hotovo');
          }
        });

        //Start animation
        controller
          ..duration = composition.duration
          ..forward();
      }),
    );
  }
}
