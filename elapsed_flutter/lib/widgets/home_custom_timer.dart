import 'dart:ui';

import 'package:flutter/cupertino.dart';
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
  late bool moreExpanded;
  late double moreOpacity;

  @override
  void initState() {
    super.initState();
    moreExpanded = false;
    moreOpacity = 0;
    controller = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);
    curve = CurvedAnimation(parent: controller, curve: Curves.easeInOut);
    tween = Tween<double>(begin: 0, end: 80).animate(curve)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _changeOpacity() {
    setState(() => moreOpacity = moreOpacity == 0 ? 1.0 : 0.0);
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
          AnimatedPositioned(
            left: 30,
            bottom: 75,
            height: moreExpanded ? 110 : 0,
            curve: Curves.easeInOut,
            duration: Duration(milliseconds: 300),
            child: AnimatedOpacity(
              opacity: moreOpacity,
              duration: Duration(milliseconds: 300),
              child: Container(
                height: 110,
                width: 55,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: <Widget>[
                    Flexible(
                        child: SizedBox(
                      height: 5,
                    )),
                    Flexible(
                      child: IconButton(
                        icon: Icon(
                          Icons.edit,
                          color: Colors.black,
                          size: moreExpanded ? 25 : 0,
                        ),
                        onPressed: () {},
                      ),
                    ),
                    Flexible(
                        child: SizedBox(
                      height: 15,
                    )),
                    Flexible(
                      child: Divider(
                        height: 25,
                        thickness: moreExpanded ? 1 : 0,
                        indent: 7,
                        endIndent: 7,
                        color: Colors.black38,
                      ),
                    ),
                    Flexible(
                      child: IconButton(
                        icon: Icon(
                          Icons.delete,
                          color: Colors.black,
                          size: moreExpanded ? 25 : 0,
                        ),
                        onPressed: () {},
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          FractionallySizedBox(
            widthFactor: 0.55,
            child: Container(
              height: 55,
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
                            moreExpanded = !moreExpanded;
                            _changeOpacity();
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
          ),
        ],
      ),
    );
  }
}
