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
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final customRoutineBox = Hive.box('custom_routines');
  List<CustomRoutine> customRoutines = [];

  String tutorialDismissed = 'NOT DISMISSED';

  Color backgroundColor = EColors.black;
  Color accentColor = EColors.green;
  String backgroundPath = '';

  late SharedPreferences prefs;

  _getCustomRoutines() async {
    Hive.openBox('custom_routines');
    for (var i = 0; i < customRoutineBox.length; i++) {
      customRoutines.add(customRoutineBox.getAt(i));
    }
  }

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

  void _deleteRoutine(int index) {
    setState(() {
      customRoutines.removeAt(index);
    });
    customRoutineBox.deleteAt(index);
  }

  @override
  void initState() {
    _getTutorialState();
    _getColors();
    _getBackgroundImage();
    _getCustomRoutines();
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
                SizedBox(height: width / 20),
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
    );
  }
}
