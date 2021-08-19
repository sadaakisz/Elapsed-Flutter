import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TimerTime extends StatefulWidget {
  const TimerTime({
    Key? key,
    required this.displayTimerMinutes,
    required this.displayTimerSeconds,
    required this.fontColor,
  }) : super(key: key);

  final String displayTimerMinutes;
  final String displayTimerSeconds;
  final Color fontColor;

  @override
  _TimerTimeState createState() => _TimerTimeState();
}

class _TimerTimeState extends State<TimerTime> {
  String get displayTimerMinutes => widget.displayTimerMinutes;
  String get displayTimerSeconds => widget.displayTimerSeconds;
  Color get fontColor => widget.fontColor;

  double fontSize = 30;

  _getFontSize() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      fontSize = prefs.getDouble('timerFontSize')!;
      fontSize /= 100;
    });
  }

  @override
  void initState() {
    _getFontSize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.only(top: fontSize * 40),
      transform:
          Matrix4.translationValues(-2.0 - (fontSize - 0.3) * 20, 0.0, 0.0),
      child: Column(
        verticalDirection: VerticalDirection.up,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            '$displayTimerSeconds',
            style: GoogleFonts.aldrich(
                textStyle:
                    TextStyle(color: fontColor, fontSize: width * fontSize)),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: width * fontSize * 0.16),
            child: Text(
              '..',
              style: GoogleFonts.aldrich(
                  textStyle: TextStyle(
                color: fontColor,
                fontSize: width * fontSize,
                height: 0.20,
              )),
            ),
          ),
          Text(
            '$displayTimerMinutes',
            style: GoogleFonts.aldrich(
                textStyle:
                    TextStyle(color: fontColor, fontSize: width * fontSize)),
          ),
        ],
      ),
    );
  }
}
