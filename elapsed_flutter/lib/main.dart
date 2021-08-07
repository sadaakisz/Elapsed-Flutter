import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:elapsed_flutter/colors/elapsed_colors.dart';
import 'package:elapsed_flutter/pages/home.dart';
import 'package:elapsed_flutter/pages/quick_timer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

void main() {
  String? fontFamily = GoogleFonts.getFont('Rubik').fontFamily;
  runApp(MaterialApp(
    title: 'elapsed.',
    theme: ThemeData(
      textTheme: Typography.whiteMountainView,
      iconTheme: IconThemeData(
        size: 30,
        color: Colors.white24,
      ),
    ).copyWith(
      textTheme: TextTheme(
        headline1: GoogleFonts.rubik(
            fontSize: 30, fontWeight: FontWeight.w500, color: Colors.white60),
        headline2: GoogleFonts.rubik(
          fontSize: 28,
          fontWeight: FontWeight.w500,
          shadows: <Shadow>[
            Shadow(
                offset: Offset(2.0, 2.0),
                blurRadius: 8,
                color: Colors.white.withOpacity(0.15))
          ],
        ),
        headline3: GoogleFonts.rubik(
            fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white54),
        headline4: GoogleFonts.rubik(
            fontSize: 22, fontWeight: FontWeight.w400, color: Colors.white70),
        headline5: GoogleFonts.rubik(
            fontSize: 36, fontWeight: FontWeight.w500, color: Colors.white),
        headline6: GoogleFonts.rubik(
            fontSize: 18, fontWeight: FontWeight.w700, color: Colors.black),
        subtitle1: GoogleFonts.rubik(
            fontSize: 24, fontWeight: FontWeight.w500, color: Colors.white54),
        subtitle2: GoogleFonts.rubik(
            fontSize: 16, fontWeight: FontWeight.w400, color: Colors.white54),
        button: GoogleFonts.rubik(
            fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white70),
        overline: GoogleFonts.rubik(
            fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black),
        bodyText1: GoogleFonts.rubik(
            fontSize: 14, fontWeight: FontWeight.w300, color: Colors.white70),
        bodyText2: GoogleFonts.rubik(
            fontSize: 12, fontWeight: FontWeight.w400, color: Colors.white54),
      ),
    ),
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    routes: {
      '/': (context) => Elapsed(),
      '/quick-timer': (context) => QuickTimerPage(),
    },
  ));
}

class Elapsed extends StatefulWidget {
  const Elapsed({Key? key}) : super(key: key);

  @override
  _ElapsedState createState() => _ElapsedState();
}

class _ElapsedState extends State<Elapsed> {
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      //TODO: Change splash to Widget
      splash: 'assets/DarkIcon.png',
      nextScreen: Home(),
      backgroundColor: EColors.black,
      //TODO: Change duration accordingly
      duration: 1000,
      curve: Curves.easeInOut,
      splashTransition: SplashTransition.fadeTransition,
      pageTransitionType: PageTransitionType.rightToLeft,
    );
  }
}
