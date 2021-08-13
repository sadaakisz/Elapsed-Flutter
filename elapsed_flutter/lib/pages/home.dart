import 'package:elapsed_flutter/colors/elapsed_colors.dart';
import 'package:elapsed_flutter/models/custom_routine.dart';
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

  _getTutorialState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      tutorialDismissed = (prefs.containsKey('tutorialDismissed')
          ? prefs.getString('tutorialDismissed')
          : 'NOT DISMISSED')!;
    });
  }

  void _dismissTutorial() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      tutorialDismissed = 'DISMISSED';
    });
    await prefs.setString('tutorialDismissed', tutorialDismissed);
  }

  @override
  void initState() {
    _getTutorialState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: EColors.black,
      body: Center(
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
      bottomNavigationBar: NavBar(),
    );
  }

  void _deleteRoutine(int index) {
    setState(() {
      customRoutines.removeAt(index);
    });
  }
}
