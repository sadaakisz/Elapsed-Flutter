import 'dart:async';
import 'package:elapsed_flutter/widgets/timer_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class QuickTimerPage extends StatefulWidget {
  QuickTimerPage({Key? key}) : super(key: key);

  @override
  _QuickTimerPageState createState() => _QuickTimerPageState();
}

class _QuickTimerPageState extends State<QuickTimerPage> {
  late Timer _timer;
  //TODO: separate int variable and display variable
  //TODO: implement timerMinutes, timerSeconds and their respective display variables
  var breakMinutes = DateTime.parse("1969-07-20 20:18:04Z").minute;
  var breakSeconds = DateTime.parse("1969-07-20 20:18:04Z").second;
  int _start = 10;

  void startTimerParam(int timerDuration) {
    if (_timer != null) {
      _timer.cancel();
    }
    setState(() {
      _start = timerDuration;
    });
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (_start < 1) {
            timer.cancel();
          } else {
            _start = _start - 1;
          }
        },
      ),
    );
  }

  void startTimer() {
    startTimerParam(10);
  }

  void pauseTimer() {
    // ignore: unnecessary_null_comparison
    if (_timer != null) _timer.cancel();
  }

  void unpauseTimer() => startTimerParam(_start);

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Quick Routine',
                style: TextStyle(
                    color: Colors.lightBlueAccent,
                    fontWeight: FontWeight.w500,
                    fontSize: 18),
              ),
            ),
            Text(
              '$_start',
              style: GoogleFonts.aldrich(
                  textStyle: TextStyle(color: Colors.white, fontSize: 100)),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Text(
                '..',
                style: GoogleFonts.aldrich(
                    textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 100,
                  height: 0.10,
                )),
              ),
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
              '$breakMinutes : $breakSeconds',
              style: GoogleFonts.aldrich(
                  textStyle: TextStyle(color: Colors.white38, fontSize: 30)),
            ),
            TimerButton(
              text: 'START',
              icon: Icons.play_arrow,
              event: startTimer,
            ),
            TimerButton(
              text: 'PAUSE',
              icon: Icons.pause,
              event: pauseTimer,
            ),
            TimerButton(
              text: 'UNPAUSE',
              icon: Icons.pause,
              event: unpauseTimer,
            ),
          ],
        ),
      ),
    );
  }
}
