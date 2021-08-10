import 'package:elapsed_flutter/widgets/timer_button.dart';
import 'package:flutter/material.dart';

class TimerButtonClass {
  static TimerButton button(buttonState, startTimer, pauseTimer, resumeTimer) {
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
