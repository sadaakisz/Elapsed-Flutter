import 'package:elapsed_flutter/colors/elapsed_colors.dart';
import 'package:elapsed_flutter/models/custom_routine.dart';
import 'package:elapsed_flutter/widgets/elapsed_title.dart';
import 'package:elapsed_flutter/widgets/home_custom_timer.dart';
import 'package:elapsed_flutter/widgets/navbar.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CustomRoutine> customRoutines =
      List<CustomRoutine>.empty(growable: true);
  @override
  void initState() {
    customRoutines
        .add(CustomRoutine(name: 'Pomodoro 1', timerTime: 25, breakTime: 5));
    customRoutines.add(
        CustomRoutine(name: 'Second Pomodoro', timerTime: 30, breakTime: 3));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: EColors.black,
      body: Center(
        child: Column(
          children: [
            ElapsedTitle(),
            HomeCustomTimer(
                name: customRoutines[1].name,
                timerTime: customRoutines[0].timerTime,
                breakTime: customRoutines[0].breakTime),
            //TutorialStart(),
            /*Flexible(
              child: FractionallySizedBox(
                  heightFactor: 0.8, child: Center(child: EmptyStart())),
            ),*/
          ],
        ),
      ),
      bottomNavigationBar: NavBar(),
    );
  }
}
