import 'dart:io';

import 'package:elapsed_flutter/colors/elapsed_colors.dart';
import 'package:elapsed_flutter/models/custom_routine.dart';
import 'package:elapsed_flutter/utils/color_utils.dart';
import 'package:elapsed_flutter/widgets/elapsed_title.dart';
import 'package:elapsed_flutter/widgets/empty_start.dart';
import 'package:elapsed_flutter/widgets/home_carousel.dart';
import 'package:elapsed_flutter/widgets/navbar.dart';
import 'package:elapsed_flutter/widgets/tutorial_start.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CustomRoutine> customRoutines = [
    /*CustomRoutine(name: 'Pomodoro 1', timerTime: 25, breakTime: 5),
    CustomRoutine(name: 'Second Pomodoro', timerTime: 30, breakTime: 3),
    CustomRoutine(name: 'Third Pomo', timerTime: 30, breakTime: 3),
    CustomRoutine(name: '4 Pomodoro', timerTime: 30, breakTime: 3),
    CustomRoutine(name: 'Go Pomodoro', timerTime: 30, breakTime: 3),*/
  ];

  String tutorialDismissed = 'NOT DISMISSED';

  Color backgroundColor = EColors.black;
  Color accentColor = EColors.green;
  String backgroundPath = '';

  late SharedPreferences prefs;

  _getTutorialState() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      tutorialDismissed = (prefs.containsKey('tutorialDismissed')
          ? prefs.getString('tutorialDismissed')
          : 'NOT DISMISSED')!;
    });
  }

  void _dismissTutorial() async {
    setState(() {
      tutorialDismissed = 'DISMISSED';
    });
    await prefs.setString('tutorialDismissed', tutorialDismissed);
  }

  _getColors() async {
    prefs = await SharedPreferences.getInstance();
    backgroundColor = (prefs.getString('backgroundColor'))!.toColorFromHex();
    accentColor = (prefs.getString('homePageAccentColor'))!.toColorFromHex();
  }

  _getBackgroundImage() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      backgroundPath = prefs.getString('backgroundImage')!;
    });
  }

  @override
  void initState() {
    _getTutorialState();
    _getColors();
    _getBackgroundImage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Stack(
        children: <Widget>[
          backgroundPath != ''
              ? Positioned.fill(
                  child: Opacity(
                  opacity: 0.5,
                  child: Image.file(
                    File(backgroundPath),
                    fit: BoxFit.cover,
                  ),
                ))
              : SizedBox(),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElapsedTitle(),
                customRoutines.length == 0
                    ? tutorialDismissed == 'NOT DISMISSED'
                        ? TutorialStart(
                            onDismiss: _dismissTutorial,
                          )
                        : EmptyStart()
                    : HomeCarousel(
                        customRoutines: customRoutines,
                        onDelete: _deleteRoutine,
                      ),
                //TutorialStart(),
                /*Flexible(
                  child: FractionallySizedBox(
                      heightFactor: 0.8, child: Center(child: EmptyStart())),
                ),*/
                SizedBox(height: 0),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            width: width,
            child: NavBar(accentColor: accentColor),
          )
        ],
      ),
      //bottomNavigationBar: NavBar(accentColor: accentColor),
    );
  }

  void _deleteRoutine(int index) {
    setState(() {
      customRoutines.removeAt(index);
    });
  }
}
