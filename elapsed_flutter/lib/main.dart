import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:elapsed_flutter/colors/elapsed_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
        nextScreen: Scaffold(
          backgroundColor: EColors.black,
          body: Center(
            child: Text(
              'elapsed.',
              style: GoogleFonts.getFont(
                'Rubik',
                fontSize: 48,
                color: Colors.white,
              ),
            ),
          ),
        ),
        backgroundColor: EColors.black,
        //TODO: Change duration accordingly
        duration: 1000,
        curve: Curves.easeInOut,
        splashTransition: SplashTransition.fadeTransition,
        pageTransitionType: PageTransitionType.rightToLeft,
      ),
    );
  }
}
