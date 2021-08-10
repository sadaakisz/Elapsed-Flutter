import 'dart:async';
import 'package:elapsed_flutter/models/time_model.dart';
import 'package:flutter/material.dart';

class Time {
  void tickTimerTime(Timer timer, TimeModel timerTime, TimeModel breakTime,
      bool timerTimeTurn, Function resetTimer, BuildContext context) {
    if (timerTime.actualSeconds! < 1) {
      if (timerTime.actualMinutes == 0) {
        timerTimeTurn = false;
        tickBreakTime(
            timer, timerTime, breakTime, timerTimeTurn, resetTimer, context);
      } else {
        timerTime.actualMinutes = (timerTime.actualMinutes! - 1);
        timerTime.actualSeconds = 59;
      }
    } else {
      timerTime.actualSeconds = timerTime.actualSeconds! - 1;
    }
    timerTime.updateDisplay();
  }

  void tickBreakTime(Timer timer, TimeModel timerTime, TimeModel breakTime,
      bool timerTimeTurn, Function resetTimer, BuildContext context) {
    if (breakTime.actualSeconds! < 1) {
      if (breakTime.actualMinutes == 0) {
        timer.cancel();
        resetTimer();
        Navigator.pop(context);
      } else {
        breakTime.actualMinutes = breakTime.actualMinutes! - 1;
        breakTime.actualSeconds = 59;
      }
    } else {
      breakTime.actualSeconds = breakTime.actualSeconds! - 1;
    }
    breakTime.updateDisplay();
  }
}
