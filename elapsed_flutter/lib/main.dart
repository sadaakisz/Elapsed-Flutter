import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Rubik'),
      debugShowCheckedModeBanner: false,
      home: QuickTimerPage(),
    );
  }
}

class QuickTimerPage extends StatefulWidget {
  QuickTimerPage({Key? key}) : super(key: key);

  @override
  _QuickTimerPageState createState() => _QuickTimerPageState();
}

class _QuickTimerPageState extends State<QuickTimerPage> {
  late Timer _timer;
  int _start = 10;

  void startTimer() {
    _start = 10;
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black87,
        height: MediaQuery.of(context).size.height * 1,
        width: MediaQuery.of(context).size.height * 1,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Quick Routine',
              style: TextStyle(
                  color: Colors.lightBlueAccent, fontWeight: FontWeight.w500),
            ),
            Text(
              '$_start',
              style: GoogleFonts.aldrich(
                  textStyle: TextStyle(color: Colors.white, fontSize: 100)),
            ),
            Text(
              '..',
              style: GoogleFonts.aldrich(
                  textStyle: TextStyle(color: Colors.white, fontSize: 100)),
            ),
            Text(
              '$_start',
              style: GoogleFonts.aldrich(
                  textStyle: TextStyle(color: Colors.white, fontSize: 100)),
            ),
            Text(
              'Break',
              style: TextStyle(color: Colors.white38),
            ),
            Text(
              '$_start : $_start',
              style: GoogleFonts.aldrich(
                  textStyle: TextStyle(color: Colors.white38, fontSize: 30)),
            ),
            TextButton(
              onPressed: startTimer,
              child: Text('START'),
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.black26),
                foregroundColor:
                    MaterialStateProperty.all<Color>(Colors.white70),
                overlayColor: MaterialStateProperty.all<Color>(Colors.blue),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
