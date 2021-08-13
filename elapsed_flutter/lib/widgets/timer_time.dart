import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TimerTime extends StatelessWidget {
  const TimerTime({
    Key? key,
    required this.displayTimerMinutes,
    required this.displayTimerSeconds,
  }) : super(key: key);

  final String displayTimerMinutes;
  final String displayTimerSeconds;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      transform: Matrix4.translationValues(-2.0, 0.0, 0.0),
      child: Column(
        verticalDirection: VerticalDirection.up,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            '$displayTimerSeconds',
            style: GoogleFonts.aldrich(
                textStyle:
                    TextStyle(color: Colors.white, fontSize: width * 0.3)),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Text(
              '..',
              style: GoogleFonts.aldrich(
                  textStyle: TextStyle(
                color: Colors.white,
                fontSize: width * 0.3,
                height: 0.20,
              )),
            ),
          ),
          Text(
            '$displayTimerMinutes',
            style: GoogleFonts.aldrich(
                textStyle:
                    TextStyle(color: Colors.white, fontSize: width * 0.3)),
          ),
        ],
      ),
    );
  }
}
