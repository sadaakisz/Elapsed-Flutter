import 'package:flutter/material.dart';

class HomeCustomTimer extends StatefulWidget {
  const HomeCustomTimer({Key? key}) : super(key: key);

  @override
  _HomeCustomTimerState createState() => _HomeCustomTimerState();
}

class _HomeCustomTimerState extends State<HomeCustomTimer> {
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.only(top: 30.0),
        child: FractionallySizedBox(
          widthFactor: 0.7,
          heightFactor: 0.9,
          child: Container(
            width: double.maxFinite,
            height: double.maxFinite,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 40.0),
              child: FractionallySizedBox(
                alignment: Alignment.bottomCenter,
                widthFactor: 0.75,
                heightFactor: 0.2,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Pomodoro 1',
                      style: Theme.of(context)
                          .textTheme
                          .headline5!
                          .copyWith(fontSize: 28, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      '25 min',
                      style: Theme.of(context)
                          .textTheme
                          .headline3!
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                    Text(
                      'Break · 5 min',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
            ),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/UnsplashBG.png"),
                colorFilter:
                    new ColorFilter.mode(Colors.black54, BlendMode.dstATop),
                fit: BoxFit.cover,
              ),
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
      ),
    );
  }
}
