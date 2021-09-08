import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Background extends StatefulWidget {
  final String backgroundPath;
  const Background({
    Key? key,
    required this.backgroundPath,
  }) : super(key: key);

  @override
  _BackgroundState createState() => _BackgroundState();
}

class _BackgroundState extends State<Background> {
  late SharedPreferences prefs;

  String get backgroundPath => widget.backgroundPath;
  double opacity = 0.5;

  Future<void> _initializeSharedPrefs() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      opacity = prefs.getDouble('opacityBackgroundImage')!;
    });
  }

  @override
  void initState() {
    _initializeSharedPrefs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return backgroundPath != ''
        ? Positioned.fill(
            child: Opacity(
            opacity: opacity,
            child: Image.file(
              File(backgroundPath),
              fit: BoxFit.cover,
            ),
          ))
        : Positioned.fill(
            child: Opacity(
            opacity: opacity,
            child: Image.asset(
              "assets/UnsplashHomeBG.jpg",
              fit: BoxFit.cover,
            ),
          ));
  }
}
