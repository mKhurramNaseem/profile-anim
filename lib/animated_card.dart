import 'dart:math';

import 'package:flutter/material.dart';
import 'package:profile_anim/main.dart';

class AnimatedCard extends AnimatedWidget {
  static const int perspectiveRow = 3, perspectiveColumn = 2;
  static const double perspectiveValue = 0.001;
  final color = Colors.black.withOpacity(0.5);

  final Animation<double> _firstRightFlipAnimation;
  final Animation<double> _firstBottomFlipAnimation;
  final Animation<double> _secondRightFlipAnimation;
  final Animation<double> _secondBottomFlipAnimation;
  final Animation<double> _elevationAnimation;

  // Values from user
  final double width, height;

  var secondRightFlapOpacity = 0.0,
      firstBottomFlapOpacity = 0.0,
      secondBottomFlapOpacity = 0.0;

  // Const Constructor for better performance
  AnimatedCard({
    super.key,
    required super.listenable,
    this.width = 250,
    this.height = 200,
  })  : _firstRightFlipAnimation = Tween<double>(begin: 0, end: -pi).animate(
          CurvedAnimation(
            parent: listenable as AnimationController,
            curve: const Interval(0.0, 0.25),
          ),
        ),
        _secondRightFlipAnimation = Tween<double>(begin: 0, end: -pi).animate(
          CurvedAnimation(
            parent: listenable,
            curve: const Interval(0.25, 0.5),
          ),
        ),
        _firstBottomFlipAnimation = Tween<double>(begin: 0, end: pi).animate(
          CurvedAnimation(
            parent: listenable,
            curve: const Interval(0.5, 0.75),
          ),
        ),
        _secondBottomFlipAnimation = Tween<double>(begin: 0, end: pi).animate(
          CurvedAnimation(
            parent: listenable,
            curve: const Interval(0.75, 1.0),
          ),
        ),
        _elevationAnimation = Tween<double>(begin: 0, end: 100).animate(
          CurvedAnimation(
            parent: listenable,
            curve: const Interval(0.5, 1.0),
          ),
        );

  @override
  Widget build(BuildContext context) {

    Duration duration = MyHomePage.duration;
    Duration? lastDuration =
        (listenable as AnimationController).lastElapsedDuration;
    if (lastDuration != null) {
      if (lastDuration.inMilliseconds < duration.inMilliseconds * 0.25) {
      } else if (lastDuration.inMilliseconds >=
              duration.inMilliseconds * 0.25 &&
          lastDuration.inMilliseconds < duration.inMilliseconds * 0.5) {
        if ((listenable as AnimationController).status ==
            AnimationStatus.reverse) {
          secondBottomFlapOpacity = 0;
        } else {
          secondRightFlapOpacity = 1;
        }
      } else if (lastDuration.inMilliseconds >= duration.inMilliseconds * 0.5 &&
          lastDuration.inMilliseconds < duration.inMilliseconds * 0.75) {
        if ((listenable as AnimationController).status ==
            AnimationStatus.reverse) {
          firstBottomFlapOpacity = 0;
        } else {
          firstBottomFlapOpacity = 1;
        }
      } else {
        if ((listenable as AnimationController).status ==
            AnimationStatus.reverse) {
          secondRightFlapOpacity = 0;
        } else {
          secondBottomFlapOpacity = 1;
        }
      }
    }

    // Building Widget
    return Material(
      elevation: _elevationAnimation.value,
      shadowColor: Colors.black,
      child: SizedBox(
        width: width * 3,
        height: height * 3,
        child: Stack(
          children: [
            Stack(children: [
               Container(
                width: width,
                height: height,
                color: color,
              ),
              Transform(
              transform: Matrix4.identity()
                // Setting perspective to give 3D effect
                ..setEntry(perspectiveRow, perspectiveColumn, perspectiveValue)
                ..rotateY(_firstRightFlipAnimation.value),
              // Axis Of Rotation
              alignment: FractionalOffset.centerRight,
              child: Container(
                width: width,
                height: height,
                color: color,
              ),
            ),
            ],),
            Positioned(
              left: width,
              child: Opacity(
                opacity: secondRightFlapOpacity,
                child: Transform(
                  transform: Matrix4.identity()
                    // Setting perspective to give 3D effect
                    ..setEntry(
                        perspectiveRow, perspectiveColumn, perspectiveValue)
                    ..rotateY(_secondRightFlipAnimation.value),
                  alignment: FractionalOffset.centerRight,
                  child: Container(
                    width: width,
                    height: height,
                    color: color,
                  ),
                ),
              ),
            ),
            Positioned(
              child: Opacity(
                opacity: firstBottomFlapOpacity,
                child: Transform(
                  transform: Matrix4.identity()
                    // Setting perspective to give 3D effect
                    ..setEntry(
                        perspectiveRow, perspectiveColumn, perspectiveValue)
                    ..rotateX(_firstBottomFlipAnimation.value),
                  alignment: FractionalOffset.bottomCenter,
                  child: Container(
                    width: width * 3,
                    height: height,
                    color: color,
                  ),
                ),
              ),
            ),
            Positioned(
              top: height,
              child: Opacity(
                opacity: secondBottomFlapOpacity,
                child: Transform(
                  transform: Matrix4.identity()
                    // Setting perspective to give 3D effect
                    ..setEntry(
                        perspectiveRow, perspectiveColumn, perspectiveValue)
                    ..rotateX(_secondBottomFlipAnimation.value),
                  alignment: FractionalOffset.bottomCenter,
                  child: Container(
                    width: width * 3,
                    height: height,
                    color: color,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
