import 'package:flutter/material.dart';

class ElapsedTitle extends StatelessWidget {
  const ElapsedTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 4.0),
                child: Image.asset(
                  'assets/DarkIcon.png',
                  scale: 2.5,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Text(
                  'elapsed.',
                  style: Theme.of(context)
                      .textTheme
                      .headline2!
                      .copyWith(fontWeight: FontWeight.w400, fontSize: 22),
                ),
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          FractionallySizedBox(
            widthFactor: 0.7,
            child: Container(
              color: Colors.white60,
              height: 1,
            ),
          ),
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}
