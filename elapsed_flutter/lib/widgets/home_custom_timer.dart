import 'dart:ui';

import 'package:elapsed_flutter/models/custom_routine.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeCustomTimer extends StatefulWidget {
  final CustomRoutine routine;
  const HomeCustomTimer({Key? key, required this.routine}) : super(key: key);

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
  static const Duration duration = Duration(milliseconds: 300);

  String get name => widget.routine.name;
  int get timerTime => widget.routine.timerTime;
  int get breakTime => widget.routine.breakTime;

  @override
  void initState() {
    super.initState();
    moreExpanded = false;
    moreOpacity = 0;
    controller = AnimationController(duration: duration, vsync: this);
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
              child: _CustomTimerInfo(
                name: name,
                timerTime: timerTime,
                breakTime: breakTime,
                offset: tween.value,
              ),
            ),
          ),
          _CustomTimerMoreMenu(
              moreExpanded: moreExpanded,
              duration: duration,
              moreOpacity: moreOpacity,
              tween: tween),
          _buildCustomTimerButtons(),
        ],
      ),
    );
  }

  FractionallySizedBox _buildCustomTimerButtons() {
    return FractionallySizedBox(
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
                  splashRadius: 1,
                  iconSize: 35,
                  icon: Icon(
                    Icons.more_horiz,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    setState(() {
                      if (controller.status == AnimationStatus.completed ||
                          controller.status == AnimationStatus.dismissed) {
                        controller.status == AnimationStatus.completed
                            ? controller.reverse()
                            : controller.forward();
                        moreExpanded = !moreExpanded;
                        _changeOpacity();
                      }
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
    );
  }
}

class _CustomTimerInfo extends StatelessWidget {
  final String name;
  final int timerTime;
  final int breakTime;

  final double offset;
  const _CustomTimerInfo(
      {Key? key,
      required this.name,
      required this.timerTime,
      required this.breakTime,
      required this.offset})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: double.maxFinite,
      decoration: BoxDecoration(
        image: DecorationImage(
          //TODO: Replace with default or specific background of custom timer
          image: AssetImage("assets/UnsplashBG.png"),
          colorFilter: new ColorFilter.mode(Colors.black54, BlendMode.dstATop),
          fit: BoxFit.cover,
        ),
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(offset, 0.0, 0.0, 45.0),
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
                name,
                overflow: TextOverflow.fade,
                softWrap: false,
                maxLines: 1,
                style: Theme.of(context)
                    .textTheme
                    .headline5!
                    .copyWith(fontSize: 28, fontWeight: FontWeight.w600),
              ),
              Text(
                '$timerTime min',
                style: Theme.of(context)
                    .textTheme
                    .headline3!
                    .copyWith(fontWeight: FontWeight.w600),
              ),
              Text(
                'Break · $breakTime min',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontWeight: FontWeight.normal),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CustomTimerMoreMenu extends StatelessWidget {
  const _CustomTimerMoreMenu({
    Key? key,
    required this.moreExpanded,
    required this.duration,
    required this.moreOpacity,
    required this.tween,
  }) : super(key: key);

  final bool moreExpanded;
  final Duration duration;
  final double moreOpacity;
  final Animation<double> tween;

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      left: 30,
      bottom: 75,
      height: moreExpanded ? 110 : 0,
      curve: Curves.easeInOut,
      duration: duration,
      child: AnimatedOpacity(
        opacity: moreOpacity,
        duration: duration,
        child: Container(
          height: 110,
          width: 55,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            children: <Widget>[
              Flexible(child: SizedBox(height: 10)),
              InkWell(
                child: SizedBox(
                  width: 50,
                  height: tween.value / 2.7,
                  child: Icon(
                    Icons.edit,
                    color: Colors.black,
                    size: tween.value / 3.2,
                  ),
                ),
                onTap: () {
                  print('Hello');
                },
              ),
              Flexible(child: SizedBox(height: 8)),
              Flexible(
                child: Divider(
                  height: 25,
                  thickness: tween.value / 80,
                  indent: 7,
                  endIndent: 7,
                  color: Colors.black38,
                ),
              ),
              Flexible(child: SizedBox(height: 8)),
              InkWell(
                child: SizedBox(
                  width: 50,
                  height: tween.value / 2.7,
                  child: Icon(
                    Icons.delete,
                    color: Colors.black,
                    size: tween.value / 3.2,
                  ),
                ),
                //TODO: Show delete dialog
                onTap: () {
                  showAnimatedDialog(
                    context: context,
                    barrierDismissible: true,
                    builder: (BuildContext context) {
                      return Container();
                    },
                    animationType: DialogTransitionType.slideFromBottomFade,
                    curve: Curves.easeInOut,
                    duration: Duration(milliseconds: 300),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
