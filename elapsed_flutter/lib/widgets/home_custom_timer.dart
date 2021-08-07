import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeCustomTimer extends StatefulWidget {
  const HomeCustomTimer({Key? key}) : super(key: key);

  @override
  _HomeCustomTimerState createState() => _HomeCustomTimerState();
}

class _HomeCustomTimerState extends State<HomeCustomTimer>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> curve;
  late Animation<double> tween;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    curve = CurvedAnimation(parent: controller, curve: Curves.easeInOut);
    tween = Tween<double>(begin: 0, end: 80).animate(curve)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 27.0),
            child: FractionallySizedBox(
              widthFactor: 0.7,
              heightFactor: 0.92,
              child: Container(
                width: double.maxFinite,
                height: double.maxFinite,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(tween.value, 0.0, 0.0, 45.0),
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
                          //TODO: Replace with title of custom timer
                          'Pomodoro 1',
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .headline5!
                              .copyWith(
                                  fontSize: 28, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          //TODO: Replace with active time of custom timer
                          '25 min',
                          style: Theme.of(context)
                              .textTheme
                              .headline3!
                              .copyWith(fontWeight: FontWeight.w600),
                        ),
                        Text(
                          //TODO: Replace with break time of custom timer
                          'Break · 5 min',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(fontWeight: FontWeight.normal),
                        ),
                      ],
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    //TODO: Replace with default or specific background of custom timer
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
          FractionallySizedBox(
            widthFactor: 0.55,
            child: Container(
              width: double.maxFinite,
              height: 55,
              child: Row(
                children: <Widget>[
                  Container(
                    width: 55,
                    height: 55,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    child: IconButton(
                      iconSize: 35,
                      icon: Icon(
                        Icons.more_horiz,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        setState(() {
                          controller.status == AnimationStatus.completed
                              ? controller.reverse()
                              : controller.forward();
                        });
                      },
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: Container(
                      height: double.maxFinite,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                      child: Center(
                        child: Text(
                          'Start',
                          style: GoogleFonts.rubik(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            textStyle: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
