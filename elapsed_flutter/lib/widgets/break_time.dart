import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BreakTime extends StatelessWidget {
  const BreakTime({
    Key? key,
    required this.displayBreakMinutes,
    required this.displayBreakSeconds,
  }) : super(key: key);

  final String displayBreakMinutes;
  final String displayBreakSeconds;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Icon(
                Icons.stop_rounded,
                color: Colors.white38,
              ),
              Text(
                'Break',
                style: Theme.of(context)
                    .textTheme
                    .headline3!
                    .copyWith(color: Colors.white38),
              ),
            ],
          ),
        ),
        Text(
          '$displayBreakMinutes:$displayBreakSeconds',
          style: GoogleFonts.aldrich(
              textStyle: TextStyle(color: Colors.white38, fontSize: 40)),
        ),
      ],
    );
  }
}