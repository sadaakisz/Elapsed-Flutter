import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

void main() {
  runApp(Elapsed());
}

class Elapsed extends StatefulWidget {
  const Elapsed({Key? key}) : super(key: key);

  @override
  _ElapsedState createState() => _ElapsedState();
}

class _ElapsedState extends State<Elapsed> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AnimatedSplashScreen(
        //TODO: Change splash to Widget
        splash: 'assets/DarkIcon.png',
        //TODO: Replace Scaffold with Start Screen
        nextScreen: Scaffold(),
        backgroundColor: Colors.black54,
        //TODO: Change duration accordingly
        duration: 1000,
        curve: Curves.easeInOut,
        splashTransition: SplashTransition.fadeTransition,
        pageTransitionType: PageTransitionType.rightToLeft,
      ),
    );
  }
}
