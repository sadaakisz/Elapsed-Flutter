import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:elapsed_flutter/models/custom_routine.dart';
import 'package:elapsed_flutter/models/time_model.dart';
import 'package:elapsed_flutter/pages/edit_custom_routine.dart';
import 'package:elapsed_flutter/pages/home.dart';
import 'package:elapsed_flutter/utils/color_utils.dart';
import 'package:elapsed_flutter/utils/custom_navigator.dart';
import 'package:elapsed_flutter/utils/custom_page_route.dart';
import 'package:elapsed_flutter/utils/time.dart';
import 'package:elapsed_flutter/utils/timer_button.dart';
import 'package:elapsed_flutter/widgets/break_time.dart';
import 'package:elapsed_flutter/widgets/timer_time.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomTimerPage extends StatefulWidget {
  final CustomRoutine customRoutine;
  final int index;

  CustomTimerPage({Key? key, required this.customRoutine, required this.index})
      : super(key: key);

  @override
  _CustomTimerPageState createState() => _CustomTimerPageState();
}

class _CustomTimerPageState extends State<CustomTimerPage> {
  int get index => widget.index;
  Timer? _timer;
  CustomRoutine get customRoutine => widget.customRoutine;
  double get volume => widget.customRoutine.notificationVolume;
  bool get vibrate => widget.customRoutine.vibrate;
  String get backgroundPath => widget.customRoutine.background;

  TimeModel timerTime = new TimeModel(minutes: 10, seconds: 0);
  TimeModel breakTime = new TimeModel(minutes: 5, seconds: 0);
  Time time = new Time();

  String buttonState = 'NOT STARTED';
  //NOT STARTED, STARTED, PAUSED

  bool timerTimeTurn = true;
  bool isTimerRunning = false;

  Color timerFontColor = Colors.white;

  getSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    timerFontColor = prefs.getString('timerFontColor')!.toColorFromHex();
  }

  @override
  void initState() {
    //SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    super.initState();
    setState(() {
      timerTime.minutes = customRoutine.timerTime;
      breakTime.minutes = customRoutine.breakTime;
      timerTime.updateActual();
      breakTime.updateActual();
      timerTime.updateDisplay();
      breakTime.updateDisplay();
    });
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
                    resetTimer, volume, vibrate, context);
              } else {
                time.tickBreakTime(timer, timerTime, breakTime, timerTimeTurn,
                    resetTimer, volume, vibrate, context);
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

  void editCustomTimerTime(BuildContext context) async {
    resetTimer();
    final result = await Navigator.push(context,
        CustomPageRoute(EditCustomRoutine(index: index, editingInTimer: true)));
    if (result != null) {
      setState(() {
        timerTime.minutes = result[0];
        breakTime.minutes = result[1];
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
    //SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black87,
      body: Stack(
        children: [
          backgroundPath != ''
              ? Positioned.fill(
                  child: ImageFiltered(
                  //TODO: Make this blur customizable
                  imageFilter: ImageFilter.blur(
                    sigmaX: 5,
                    sigmaY: 5,
                  ),
                  child: Opacity(
                    opacity: 0.5,
                    child: Image.file(
                      File(backgroundPath),
                      fit: BoxFit.cover,
                      cacheHeight: 1920,
                    ),
                  ),
                ))
              : SizedBox(),
          Padding(
            padding: EdgeInsets.all(width / 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: width / 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.stop_rounded,
                        color: customRoutine.labelColor.toColorFromHex(),
                      ),
                      Expanded(
                        child: Text(
                          customRoutine.name,
                          overflow: TextOverflow.fade,
                          maxLines: 1,
                          softWrap: false,
                          style: Theme.of(context)
                              .textTheme
                              .headline3!
                              .copyWith(
                                color:
                                    customRoutine.labelColor.toColorFromHex(),
                                fontWeight: FontWeight.w500,
                                fontSize: width / 20,
                              ),
                        ),
                      ),
                      TimerIconButton(
                        icon: Icons.close,
                        event: () {
                          navPushReplace(context, Home(index: index));
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
                      displayTimerSeconds: timerTime.displaySeconds!,
                      fontColor: timerFontColor,
                    ),
                    TimerIconButton(
                      icon: Icons.edit_outlined,
                      event: () {
                        editCustomTimerTime(context);
                      },
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(bottom: width / 20),
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
        ],
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
    double width = MediaQuery.of(context).size.width;
    return Container(
      height: width / 7,
      child: IconButton(
        icon: Icon(
          icon,
          size: width / 10,
        ),
        hoverColor: Colors.black,
        highlightColor: Colors.black,
        focusColor: Colors.black,
        splashColor: Colors.black,
        onPressed: () {
          event();
        },
      ),
    );
  }
}
