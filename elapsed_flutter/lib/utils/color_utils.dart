import 'dart:ui';

import 'package:flutter/material.dart';

extension StringColorExtension on String {
  Color toColorFromHex() {
    var hexColor = this.replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    if (hexColor.length == 8) {
      return Color(int.parse("0x$hexColor"));
    } else {
      return Colors.transparent;
    }
  }
}

extension ColorExtension on Color {
  String toHex() {
    var colorString = this.toString();
    return '#' +
        colorString.split('(0x')[1].split(')')[0].substring(2).toUpperCase();
  }
}
