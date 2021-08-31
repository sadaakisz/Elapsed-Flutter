import 'package:flutter/material.dart';

class BottomFadeBackground extends StatelessWidget {
  final double width;
  final Color fadeBackgroundColor;

  BottomFadeBackground(
      {Key? key, required this.width, required this.fadeBackgroundColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      width: width,
      height: width / 5,
      bottom: 0,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                fadeBackgroundColor,
                fadeBackgroundColor.withOpacity(0)
              ]),
        ),
      ),
    );
  }
}
