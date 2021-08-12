import 'dart:async';
import 'package:elapsed_flutter/pages/quick_timer_settings.dart';
import 'package:elapsed_flutter/utils/time.dart';
import 'package:elapsed_flutter/utils/timer_button.dart';
import 'package:elapsed_flutter/widgets/break_time.dart';
import 'package:elapsed_flutter/models/time_model.dart';
import 'package:elapsed_flutter/widgets/timer_time.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QuickTimerPage extends StatefulWidget {
  QuickTimerPage({Key? key}) : super(key: key);

  @override
  _QuickTimerPageState createState() => _QuickTimerPageState();
}

class _QuickTimerPageState extends State<QuickTimerPage> {
  Timer? _timer;

  TimeModel timerTime = new TimeModel(minutes: 10, seconds: 0);
  TimeModel breakTime = new TimeModel(minutes: 5, seconds: 0);
  Time time = new Time();

  String buttonState = 'NOT STARTED';
  //NOT STARTED, STARTED, PAUSED

  bool timerTimeTurn = true;
  bool isTimerRunning = false;

  getMinutesFromSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final timerMinutes = (prefs.getInt('timerMinutes'));
    final breakMinutes = (prefs.getInt('breakMinutes'));

    if (timerMinutes != null) {
      setState(() {
        timerTime.minutes = timerMinutes;
      });
    }
    if (breakMinutes != null) {
      setState(() {
        breakTime.minutes = breakMinutes;
      });
    }
    setState(() {
      timerTime.updateActual();
      breakTime.updateActual();
      timerTime.updateDisplay();
      breakTime.updateDisplay();
    });
  }

  @override
  void initState() {
    super.initState();
    getMinutesFromSharedPrefs();
  }

  void startTimerParam() {
    if (_timer != null) {
      _timer?.cancel();
    }
    if (!isTimerRunning) {
      setState(() {
        timerTime.updateActual();
        breakTime.updateActual();
        isTimerRunning = true;
      });
    }
    setState(() {
      timerTime.updateDisplay();
      breakTime.updateDisplay();
    });

    const oneSec = const Duration(seconds: 1);

    _timer = new Timer.periodic(
        oneSec,
        (Timer timer) => setState(() {
              if (timerTimeTurn) {
                time.tickTimerTime(timer, timerTime, breakTime, timerTimeTurn,
                    resetTimer, context);
              } else {
                time.tickBreakTime(timer, timerTime, breakTime, timerTimeTurn,
                    resetTimer, context);
              }
            }));
  }

  void startTimer() {
    setState(() {
      buttonState = 'STARTED';
      timerTimeTurn = true;
    });
    startTimerParam();
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
    startTimerParam();
  }

  void resetTimer() {
    setState(() {
      buttonState = 'NOT STARTED';
      timerTimeTurn = true;
      isTimerRunning = false;

      timerTime.updateActual();
      breakTime.updateActual();
      timerTime.updateDisplay();
      breakTime.updateDisplay();
    });
    if (_timer != null) _timer?.cancel();
  }

  void editQuickTimerTime(BuildContext context) async {
    resetTimer();
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => QuickTimerSettings(
              int.parse(timerTime.displayMinutes!),
              int.parse(breakTime.displayMinutes!))),
    );
    if (result != null) {
      setState(() {
        timerTime.minutes = int.parse(result[0]);
        breakTime.minutes = int.parse(result[1]);
        timerTime.updateActual();
        breakTime.updateActual();
        timerTime.updateDisplay();
        breakTime.updateDisplay();
      });
    }
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
                  TimerIconButton(
                    icon: Icons.close,
                    event: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: <Widget>[
                TimerTime(
                    displayTimerMinutes: timerTime.displayMinutes!,
                    displayTimerSeconds: timerTime.displaySeconds!),
                TimerIconButton(
                  icon: Icons.edit_outlined,
                  event: () {
                    editQuickTimerTime(context);
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: BreakTime(
                      displayBreakMinutes: breakTime.displayMinutes!,
                      displayBreakSeconds: breakTime.displaySeconds!),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TimerButtonClass.button(
                    buttonState, startTimer, pauseTimer, resumeTimer),
                TimerIconButton(
                  icon: Icons.restart_alt,
                  event: resetTimer,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class TimerIconButton extends StatelessWidget {
  const TimerIconButton({
    Key? key,
    required this.event,
    required this.icon,
  }) : super(key: key);

  final Function event;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        icon,
        size: 40,
      ),
      hoverColor: Colors.black,
      highlightColor: Colors.black,
      focusColor: Colors.black,
      splashColor: Colors.black,
      onPressed: () {
        event();
      },
    );
  }
}
