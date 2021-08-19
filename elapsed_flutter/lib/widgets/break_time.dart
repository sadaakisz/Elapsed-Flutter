import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BreakTime extends StatefulWidget {
  const BreakTime({
    Key? key,
    required this.displayBreakMinutes,
    required this.displayBreakSeconds,
  }) : super(key: key);

  final String displayBreakMinutes;
  final String displayBreakSeconds;

  @override
  _BreakTimeState createState() => _BreakTimeState();
}

class _BreakTimeState extends State<BreakTime> {
  String fontFamily = 'Aldrich';

  _getFontFamily() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      fontFamily = prefs.getString('timerFontFamily')!;
    });
  }

  @override
  void initState() {
    _getFontFamily();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
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
        Padding(
          padding: const EdgeInsets.only(left: 5.0),
          child: Text(
            '${widget.displayBreakMinutes}:${widget.displayBreakSeconds}',
            style: GoogleFonts.getFont(fontFamily)
                .copyWith(color: Colors.white38, fontSize: width / 10),
          ),
        ),
      ],
    );
  }
}
