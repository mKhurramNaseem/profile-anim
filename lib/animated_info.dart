import 'package:flutter/material.dart';
import 'package:profile_anim/main.dart';
import 'package:google_fonts/google_fonts.dart';

class AnimatedInfo extends AnimatedWidget {
  final double width, height;
  final Animation<double> _widthAnimation;
  final Animation<double> _heightAnimation;
  final Animation<double> _imageFadeOutAnimation;
  final Animation<double> _imageFadeInAnimation;
  final Animation<double> _userNameOpacityAnimation;
  final Animation<double> _userDesignationOpacityAnimation;
  final Animation<double> _userNameSlideAnimation;
  final Animation<double> _userEmailSlideAnimation;
  static const imagePath = 'assets/images/icon_4.png';
  final String userName, userEmail, userDesignation, userCompany, userPhoneNo;

  AnimatedInfo({
    super.key,
    required super.listenable,
    this.width = 250,
    this.height = 200,
    this.userCompany = '',
    this.userName = '',
    this.userEmail = '',
    this.userDesignation = '',
    this.userPhoneNo = '',
  })  : _widthAnimation = Tween<double>(begin: width, end: width * 1.3).animate(
          CurvedAnimation(
            parent: listenable as AnimationController,
            curve: const Interval(0.75, 1.0),
          ),
        ),
        _heightAnimation =
            Tween<double>(begin: height, end: height * 1.5).animate(
          CurvedAnimation(
            parent: listenable,
            curve: const Interval(0.75, 1.0),
          ),
        ),
        _imageFadeOutAnimation = Tween<double>(begin: 1, end: 0).animate(
          CurvedAnimation(
            parent: listenable,
            curve: const Interval(0.0, 0.1),
          ),
        ),
        _imageFadeInAnimation = Tween<double>(begin: 0, end: 1).animate(
          CurvedAnimation(
            parent: listenable,
            curve: const Interval(0.75, 1.0),
          ),
        ),
        _userNameOpacityAnimation = Tween<double>(begin: 0, end: 1).animate(
          CurvedAnimation(
            parent: listenable,
            curve: const Interval(0.6, 0.75),
          ),
        ),
        _userNameSlideAnimation =
            Tween<double>(begin: width * 4, end: width * 1.5).animate(
          CurvedAnimation(
            parent: listenable,
            curve: const Interval(0.6, 0.75),
          ),
        ),
        _userEmailSlideAnimation =
            Tween<double>(begin: width * 4, end: width * 0.2).animate(
          CurvedAnimation(
            parent: listenable,
            curve: const Interval(0.75, 1.0),
          ),
        ),
        _userDesignationOpacityAnimation =
            Tween<double>(begin: 0, end: 1).animate(
          CurvedAnimation(
            parent: listenable,
            curve: const Interval(0.65, 0.9, curve: Curves.bounceInOut),
          ),
        );

  @override
  Widget build(BuildContext context) {
    AnimationController animationController =
        (listenable as AnimationController);
    double opacity = 1;
    if (animationController.lastElapsedDuration != null) {
      if (animationController.status == AnimationStatus.forward) {
        if (animationController.lastElapsedDuration!.inMilliseconds >
            MyHomePage.duration.inMilliseconds * 0.7) {
          opacity = _imageFadeInAnimation.value;
        } else {
          opacity = _imageFadeOutAnimation.value;
        }
      } else if (animationController.status == AnimationStatus.reverse) {
        if (animationController.lastElapsedDuration!.inMilliseconds <
            MyHomePage.duration.inMilliseconds * 0.75) {
          opacity = _imageFadeInAnimation.value;
        } else {
          opacity = _imageFadeOutAnimation.value;
        }
      }
    }

    return SizedBox(
      width: width * 3,
      height: height * 3,
      child: Stack(
        children: [
          Opacity(
            opacity: opacity,
            child: SizedBox(
              width: _widthAnimation.value,
              height: _heightAnimation.value,
              child: Image.asset(imagePath),
            ),
          ),
          Positioned(
            top: height / 2,
            left: _userNameSlideAnimation.value,
            child: Opacity(
              opacity: _userNameOpacityAnimation.value,
              child: MyText(text: userCompany, fontSize: (width + height) / 10),
            ),
          ),
          Positioned(
            top: height * 1.3,
            left: _userNameSlideAnimation.value,
            child: Opacity(
              opacity: _userNameOpacityAnimation.value,
              child: MyText(text: userName, fontSize: (width + height) / 10),
            ),
          ),
          Positioned(
            top: height * 1.5,
            left: width * 2,
            child: Opacity(
              opacity: _userDesignationOpacityAnimation.value,
              child: MyText(
                  text: "($userDesignation)", fontSize: (width + height) / 20),
            ),
          ),
          Positioned(
            top: height * 2.2,
            left: width * 0.2 ,
            child: Opacity(
              opacity: _userDesignationOpacityAnimation.value,
              child: MyText(
                  text: 'Phone No : $userPhoneNo', fontSize: (width + height) / 12),
            ),
          ),
          Positioned(
            top: height * 2.5,
            left: _userEmailSlideAnimation.value,
            child: Opacity(
              opacity: _userNameOpacityAnimation.value,
              child: MyText(
                text: userEmail,
                fontSize: (width + height) / 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MyText extends StatelessWidget {
  final String text;
  final double fontSize;
  const MyText({
    super.key,
    required this.text,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.ebGaramond(
        textStyle: TextStyle(
          fontStyle: FontStyle.italic,
          color: Colors.white,
          fontSize: fontSize,
        ),
      ),
    );
  }
}
