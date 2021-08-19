import 'dart:ui';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:elapsed_flutter/colors/elapsed_colors.dart';
import 'package:elapsed_flutter/pages/app_settings.dart';
import 'package:elapsed_flutter/pages/home.dart';
import 'package:elapsed_flutter/pages/quick_timer.dart';
import 'package:elapsed_flutter/utils/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wakelock/wakelock.dart';

void main() {
  var pixelRatio = window.devicePixelRatio;
  var logicalScreenSize = window.physicalSize / pixelRatio;
  var logicalWidth = logicalScreenSize.width;
  var logicalHeight = logicalScreenSize.height;
  print('$logicalWidth, $logicalHeight');
  WidgetsFlutterBinding.ensureInitialized();
  _initializeSharedPrefsVariables();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .whenComplete(() {
    runApp(MaterialApp(
      title: 'elapsed.',
      theme: ThemeData(
        textTheme: Typography.whiteMountainView,
        iconTheme: IconThemeData(
          size: logicalWidth / 13,
          color: Colors.white24,
        ),
      ).copyWith(
        textTheme: TextTheme(
          headline1: GoogleFonts.rubik(
              fontSize: logicalWidth / 13,
              fontWeight: FontWeight.w500,
              color: Colors.white60),
          headline2: GoogleFonts.rubik(
            fontSize: logicalWidth / 14,
            fontWeight: FontWeight.w500,
            shadows: <Shadow>[
              Shadow(
                  offset: Offset(2.0, 2.0),
                  blurRadius: 8,
                  color: Colors.white.withOpacity(0.15))
            ],
          ),
          headline3: GoogleFonts.rubik(
              fontSize: logicalWidth / 22,
              fontWeight: FontWeight.w500,
              color: Colors.white54),
          headline4: GoogleFonts.rubik(
              fontSize: logicalWidth / 18,
              fontWeight: FontWeight.w400,
              color: Colors.white70),
          headline5: GoogleFonts.rubik(
              fontSize: logicalWidth / 11,
              fontWeight: FontWeight.w500,
              color: Colors.white),
          headline6: GoogleFonts.rubik(
              fontSize: logicalWidth / 22,
              fontWeight: FontWeight.w700,
              color: Colors.black),
          subtitle1: GoogleFonts.rubik(
              fontSize: logicalWidth / 16.5,
              fontWeight: FontWeight.w500,
              color: Colors.white54),
          subtitle2: GoogleFonts.rubik(
              fontSize: logicalWidth / 24.5,
              fontWeight: FontWeight.w400,
              color: Colors.white54),
          button: GoogleFonts.rubik(
              fontSize: logicalWidth / 24.5,
              fontWeight: FontWeight.w500,
              color: Colors.white70),
          overline: GoogleFonts.rubik(
            fontSize: logicalWidth / 28,
            fontWeight: FontWeight.w400,
            color: Colors.black,
            decoration: TextDecoration.underline,
          ),
          bodyText1: GoogleFonts.rubik(
              fontSize: logicalWidth / 28,
              fontWeight: FontWeight.w300,
              color: Colors.white70),
          bodyText2: GoogleFonts.rubik(
              fontSize: logicalWidth / 33,
              fontWeight: FontWeight.w400,
              color: Colors.white54),
        ),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => Elapsed(),
        '/home': (context) => Home(),
        '/quick-timer': (context) => QuickTimerPage(),
        '/settings': (context) => AppSettings(),
      },
    ));
  });
}

_initializeSharedPrefsVariables() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (!prefs.containsKey('backgroundColor'))
    await prefs.setString('backgroundColor', EColors.black.toHex());
  if (!prefs.containsKey('timerFontColor'))
    await prefs.setString('timerFontColor', Colors.white.toHex());
  if (!prefs.containsKey('quickRoutineAccentColor'))
    await prefs.setString(
        'quickRoutineAccentColor', Colors.tealAccent.shade400.toHex());
  if (!prefs.containsKey('homePageAccentColor'))
    await prefs.setString('homePageAccentColor', EColors.green.toHex());
  if (!prefs.containsKey('timerFontFamily'))
    await prefs.setString('timerFontFamily', 'Aldrich');
  if (!prefs.containsKey('timerFontSize'))
    await prefs.setDouble('timerFontSize', 30);
}

class Elapsed extends StatefulWidget {
  const Elapsed({Key? key}) : super(key: key);

  @override
  _ElapsedState createState() => _ElapsedState();
}

class _ElapsedState extends State<Elapsed> {
  @override
  Widget build(BuildContext context) {
    Wakelock.enable();
    return AnimatedSplashScreen(
      //TODO: Change splash to Widget
      splash: 'assets/DarkIcon.png',
      nextScreen: Home(),
      backgroundColor: EColors.black,
      //TODO: Change duration accordingly
      duration: 1000,
      curve: Curves.easeInOut,
      splashTransition: SplashTransition.fadeTransition,
      pageTransitionType: PageTransitionType.bottomToTop,
    );
  }
}
