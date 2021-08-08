import 'dart:async';
import 'package:elapsed_flutter/pages/quick_timer_settings.dart';
import 'package:elapsed_flutter/widgets/break_time.dart';
import 'package:elapsed_flutter/widgets/timer_button.dart';
import 'package:elapsed_flutter/widgets/timer_time.dart';
import 'package:flutter/material.dart';

class QuickTimerPage extends StatefulWidget {
  QuickTimerPage({Key? key}) : super(key: key);

  @override
  _QuickTimerPageState createState() => _QuickTimerPageState();
}

class _QuickTimerPageState extends State<QuickTimerPage> {
  Timer? _timer;

  String buttonState = 'NOT STARTED';
  //NOT STARTED, STARTED, PAUSED

  bool timerTimeTurn = true;

  bool isTimerRunning = false;

  int timerMinutes = 10;
  int timerSeconds = 0;
  int actualTimerMinutes = 0;
  int actualTimerSeconds = 0;
  String displayTimerMinutes = '';
  String displayTimerSeconds = '';

  int breakMinutes = 5;
  int breakSeconds = 0;
  int actualBreakMinutes = 0;
  int actualBreakSeconds = 0;
  String displayBreakMinutes = '';
  String displayBreakSeconds = '';

  void startTimerParam(
      int timerMinutes, int timerSeconds, int breakMinutes, int breakSeconds) {
    if (_timer != null) {
      _timer?.cancel();
    }
    if (!isTimerRunning) {
      setState(() {
        actualTimerMinutes = timerMinutes;
        actualTimerSeconds = timerSeconds;
        actualBreakMinutes = breakMinutes;
        actualBreakSeconds = breakSeconds;
        isTimerRunning = true;
      });
    }
    setState(() {
      displayTimerMinutes = convertToTimeString(actualTimerMinutes);
      displayTimerSeconds = convertToTimeString(actualTimerSeconds);
      displayBreakMinutes = convertToTimeString(actualBreakMinutes);
      displayBreakSeconds = convertToTimeString(actualBreakSeconds);
    });
    const oneSec = const Duration(seconds: 1);
    //TODO: EDIT TIMER TIME AND BREAK TIME ON PENCIL CLICK
    //TODO: REFACTOR TICKS AND VARIABLES

    _timer = new Timer.periodic(
        oneSec,
        (Timer timer) => setState(() {
              if (timerTimeTurn) {
                tickTimerTime(timer);
              } else {
                tickBreakTime(timer);
              }
            }));
  }

  void tickTimerTime(timer) {
    if (actualTimerSeconds < 1) {
      if (actualTimerMinutes == 0) {
        setState(() {
          timerTimeTurn = false;
          tickBreakTime(timer);
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
  }

  void tickBreakTime(timer) {
    if (actualBreakSeconds < 1) {
      if (actualBreakMinutes == 0) {
        timer.cancel();
        resetTimer();
        Navigator.pop(context);
      } else {
        actualBreakMinutes = actualBreakMinutes - 1;
        actualBreakSeconds = 59;
      }
    } else {
      actualBreakSeconds = actualBreakSeconds - 1;
    }
    displayBreakMinutes = convertToTimeString(actualBreakMinutes);
    displayBreakSeconds = convertToTimeString(actualBreakSeconds);
  }

  void startTimer() {
    setState(() {
      buttonState = 'STARTED';
      timerTimeTurn = true;
    });
    startTimerParam(timerMinutes, timerSeconds, breakMinutes, breakSeconds);
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
    startTimerParam(timerMinutes, timerSeconds, breakMinutes, breakSeconds);
  }

  void resetTimer() {
    setState(() {
      buttonState = 'NOT STARTED';
      timerTimeTurn = true;
      isTimerRunning = false;
      actualTimerMinutes = timerMinutes;
      actualTimerSeconds = timerSeconds;
      actualBreakMinutes = breakMinutes;
      actualBreakSeconds = breakSeconds;
      displayTimerMinutes = convertToTimeString(actualTimerMinutes);
      displayTimerSeconds = convertToTimeString(actualTimerSeconds);
      displayBreakMinutes = convertToTimeString(actualBreakMinutes);
      displayBreakSeconds = convertToTimeString(actualBreakSeconds);
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

  void editQuickTimerTime(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => QuickTimerSettings()),
    );
    setState(() {
      timerMinutes = int.parse(result[0]);
      breakMinutes = int.parse(result[1]);
      displayTimerMinutes = result[0];
      displayBreakMinutes = result[1];
    });
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text('${result[0]} ${result[1]}')));
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Row(
                    children: [
                      Icon(
                        Icons.stop_rounded,
                        color: Colors.tealAccent.shade400,
                      ),
                      Text(
                        'Quick Routine',
                        style: TextStyle(
                            color: Colors.tealAccent.shade400,
                            fontWeight: FontWeight.w500,
                            fontSize: 20),
                      ),
                    ],
                  ),
                  IconButton(
                      icon: const Icon(
                        Icons.close,
                        size: 40,
                      ),
                      hoverColor: Colors.black,
                      highlightColor: Colors.black,
                      focusColor: Colors.black,
                      splashColor: Colors.black,
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: <Widget>[
                TimerTime(
                    displayTimerMinutes: displayTimerMinutes,
                    displayTimerSeconds: displayTimerSeconds),
                IconButton(
                    icon: const Icon(
                      Icons.edit_outlined,
                      size: 40,
                    ),
                    hoverColor: Colors.black,
                    highlightColor: Colors.black,
                    focusColor: Colors.black,
                    splashColor: Colors.black,
                    onPressed: () {
                      editQuickTimerTime(context);
                    }),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: BreakTime(
                      displayBreakMinutes: displayBreakMinutes,
                      displayBreakSeconds: displayBreakSeconds),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                button(),
                IconButton(
                    icon: const Icon(
                      Icons.restart_alt,
                      size: 40,
                    ),
                    hoverColor: Colors.black,
                    highlightColor: Colors.black,
                    focusColor: Colors.black,
                    splashColor: Colors.black,
                    onPressed: resetTimer),
              ],
            )
          ],
        ),
      ),
    );
  }

  TimerButton button() {
    if (buttonState == 'NOT STARTED') {
      return TimerButton(
        text: 'START',
        icon: Icons.play_arrow,
        event: startTimer,
      );
    }
    if (buttonState == 'STARTED') {
      return TimerButton(
        text: 'PAUSE',
        icon: Icons.pause,
        event: pauseTimer,
      );
    }
    return TimerButton(
      text: 'RESUME',
      icon: Icons.play_arrow,
      event: resumeTimer,
    );
  }
}
