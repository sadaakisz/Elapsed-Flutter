import 'package:flutter/material.dart';

class TimerButton extends StatelessWidget {
  TimerButton(
      {Key? key, required this.text, required this.event, required this.icon})
      : super(key: key);

  final String text;
  final Function event;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: () {
        event();
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.black26),
        foregroundColor: MaterialStateProperty.all<Color>(Colors.white70),
        overlayColor: MaterialStateProperty.all<Color>(Colors.blue),
      ),
      icon: Icon(
        icon,
        color: Colors.white,
      ),
      label: Text(
        text,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400),
      ),
    );
  }
}
