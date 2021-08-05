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
  Timer? _timer;

  String buttonState = 'NOT STARTED';
  //NOT STARTED, STARTED, PAUSED

  int timerMinutes = 1;
  int timerSeconds = 0;
  int actualTimerMinutes = 0;
  int actualTimerSeconds = 0;
  String displayTimerMinutes = '';
  String displayTimerSeconds = '';

  int breakMinutes = 1;
  int breakSeconds = 0;
  String displayBreakMinutes = '';
  String displayBreakSeconds = '';
  int actualBreakMinutes = 0;
  int actualBreakSeconds = 0;

  void startTimerParam(int timerMinutes, int timerSeconds) {
    if (_timer != null) {
      _timer?.cancel();
    }
    if (actualTimerMinutes == 0 && actualTimerSeconds == 0) {
      setState(() {
        actualTimerMinutes = timerMinutes;
        actualTimerSeconds = timerSeconds;
      });
    }
    setState(() {
      actualBreakMinutes = breakMinutes;
      actualBreakSeconds = breakSeconds;
      displayTimerMinutes = convertToTimeString(actualTimerMinutes);
      displayTimerSeconds = convertToTimeString(actualTimerSeconds);
    });
    const oneSec = const Duration(seconds: 1);
    //TODO: CONTINUE WITH BREAK TIME AFTER FINISHING TIMER TIME
    //TODO: SEND TO FINISH SCREEN AFTER FINISHING BREAK TIME
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (actualTimerSeconds < 1) {
            if (actualTimerMinutes == 0) {
              timer.cancel();
              setState(() {
                buttonState = 'NOT STARTED';
              });
            } else {
              actualTimerMinutes = actualTimerMinutes - 1;
              actualTimerSeconds = 59;
            }
          } else {
            actualTimerSeconds = actualTimerSeconds - 1;
          }
          displayTimerMinutes = convertToTimeString(actualTimerMinutes);
          displayTimerSeconds = convertToTimeString(actualTimerSeconds);
        },
      ),
    );
  }

  void startTimer() {
    setState(() {
      buttonState = 'STARTED';
    });
    startTimerParam(timerMinutes, timerSeconds);
  }

  void pauseTimer() {
    setState(() {
      buttonState = 'PAUSED';
    });
    if (_timer != null) _timer?.cancel();
  }

  void resumeTimer() {
    setState(() {
      buttonState = 'STARTED';
    });
    startTimerParam(timerMinutes, timerSeconds);
  }

  void resetTimer() {
    setState(() {
      buttonState = 'NOT STARTED';
      actualTimerMinutes = timerMinutes;
      actualTimerSeconds = timerSeconds;
      displayTimerMinutes = convertToTimeString(actualTimerMinutes);
      displayTimerSeconds = convertToTimeString(actualTimerSeconds);
    });
    if (_timer != null) _timer?.cancel();
  }

  String convertToTimeString(number) {
    return number < 10 ? '0' + number.toString() : number.toString();
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      displayTimerMinutes = convertToTimeString(timerMinutes);
      displayTimerSeconds = convertToTimeString(timerSeconds);
      displayBreakMinutes = convertToTimeString(breakMinutes);
      displayBreakSeconds = convertToTimeString(breakSeconds);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
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
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Text(
                'Quick Routine',
                style: TextStyle(
                    color: Colors.lightBlueAccent,
                    fontWeight: FontWeight.w500,
                    fontSize: 18),
              ),
            ),
            Text(
              '$displayTimerMinutes',
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
              '$displayTimerSeconds',
              style: GoogleFonts.aldrich(
                  textStyle: TextStyle(color: Colors.white, fontSize: 100)),
            ),
            Text(
              'Break',
              style: TextStyle(color: Colors.white38),
            ),
            Text(
              '$displayBreakMinutes : $displayBreakSeconds',
              style: GoogleFonts.aldrich(
                  textStyle: TextStyle(color: Colors.white38, fontSize: 30)),
            ),
            if (buttonState == 'NOT STARTED')
              TimerButton(
                text: 'START',
                icon: Icons.play_arrow,
                event: startTimer,
              ),
            if (buttonState == 'STARTED')
              TimerButton(
                text: 'PAUSE',
                icon: Icons.pause,
                event: pauseTimer,
              ),
            if (buttonState == 'PAUSED')
              TimerButton(
                text: 'RESUME',
                icon: Icons.play_arrow,
                event: resumeTimer,
              ),
            IconButton(
              icon: const Icon(
                Icons.restart_alt,
                color: Colors.white,
              ),
              onPressed: resetTimer,
            ),
          ],
        ),
      ),
    );
  }
}
