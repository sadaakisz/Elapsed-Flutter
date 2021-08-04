import 'dart:io';

import 'package:flutter/material.dart';

class CustomRoutine {
  String name;
  int timerTime;
  int breakTime;
  Color labelColor;
  File background;
  //TODO: Add notification sound variable
  int notificationVolume;
  bool vibrate;
  bool autoStart;
  CustomRoutine(this.name, this.timerTime, this.breakTime, this.labelColor,
      this.background, this.notificationVolume, this.vibrate, this.autoStart);
}
