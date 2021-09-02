import 'dart:async';

import 'package:elapsed_flutter/models/time_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';

class Time {
  bool playedTimerFinished = false;
  bool playedBreakFinished = false;
  void tickTimerTime(
      Timer timer,
      TimeModel timerTime,
      TimeModel breakTime,
      bool timerTimeTurn,
      Function resetTimer,
      double volume,
      BuildContext context) {
    if (timerTime.actualSeconds! < 1) {
      if (timerTime.actualMinutes == 0) {
        timerTimeTurn = false;
        if (!playedTimerFinished) {
          FlutterRingtonePlayer.play(
            android: AndroidSounds.notification,
            ios: IosSounds.glass,
            looping: false, // Android only - API >= 28
            volume: volume, // Android only - API >= 28
            asAlarm: false, // Android only - all APIs
          );
          playedTimerFinished = true;
        }
        tickBreakTime(timer, timerTime, breakTime, timerTimeTurn, resetTimer,
            volume, context);
      } else {
        timerTime.actualMinutes = (timerTime.actualMinutes! - 1);
        timerTime.actualSeconds = 59;
      }
    } else {
      timerTime.actualSeconds = timerTime.actualSeconds! - 1;
    }
    timerTime.updateDisplay();
  }

  void tickBreakTime(
      Timer timer,
      TimeModel timerTime,
      TimeModel breakTime,
      bool timerTimeTurn,
      Function resetTimer,
      double volume,
      BuildContext context) {
    if (breakTime.actualSeconds! < 1) {
      if (breakTime.actualMinutes == 0) {
        timer.cancel();
        resetTimer();
        if (!playedBreakFinished) {
          FlutterRingtonePlayer.play(
            android: AndroidSounds.notification,
            ios: IosSounds.glass,
            looping: false, // Android only - API >= 28
            volume: volume, // Android only - API >= 28
            asAlarm: false, // Android only - all APIs
          );
          playedBreakFinished = true;
        }
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
