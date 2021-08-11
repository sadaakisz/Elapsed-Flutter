import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ElapsedTitle extends StatelessWidget {
  const ElapsedTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Column(
        children: [
          SizedBox(
            height: width / 6.5,
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 4.0),
                child: Image.asset(
                  'assets/DarkIcon.png',
                  width: width / 11,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Text(
                  'elapsed.',
                  style: GoogleFonts.rubik(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: width / 18,
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: width / 20,
          ),
          FractionallySizedBox(
            widthFactor: 0.7,
            child: Container(
              color: Colors.white60,
              height: 1,
            ),
          ),
        ],
      ),
    );
  }
}
