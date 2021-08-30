import 'package:elapsed_flutter/pages/app_settings.dart';
import 'package:elapsed_flutter/pages/create_custom_routine.dart';
import 'package:elapsed_flutter/pages/quick_timer.dart';
import 'package:elapsed_flutter/utils/custom_navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NavBar extends StatefulWidget {
  final Color accentColor;
  const NavBar({Key? key, required this.accentColor}) : super(key: key);

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  Color get accentColor => widget.accentColor;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: GestureDetector(
            child: Icon(Icons.bolt, color: Colors.white54),
            onTap: () {
              navPush(context, QuickTimerPage());
            },
          ),
        ),
        GestureDetector(
          onTap: () => navPush(context, CreateCustomRoutine()),
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              SvgPicture.asset(
                'assets/AddIconBG.svg',
                width: width / 2.1,
                color: accentColor,
              ),
              Image.asset(
                'assets/GreyIcon.png',
                width: width / 13,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: GestureDetector(
            child: Icon(Icons.settings, color: Colors.white54),
            onTap: () {
              navPush(context, AppSettings());
            },
          ),
        ),
      ],
    );
  }
}
