import 'package:elapsed_flutter/colors/elapsed_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Icon(Icons.bolt, color: Colors.white54),
        ),
        Stack(
          alignment: Alignment.center,
          children: <Widget>[
            SvgPicture.asset(
              'assets/AddIconBG.svg',
              color: EColors.green,
            ),
            Image.asset(
              'assets/GreyIcon.png',
              scale: 1.8,
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: Icon(Icons.settings, color: Colors.white54),
        ),
      ],
    );
  }
}
