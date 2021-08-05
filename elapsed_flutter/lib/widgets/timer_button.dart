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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: 200,
        height: 50,
        child: TextButton.icon(
          onPressed: () {
            event();
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.white10),
            overlayColor: MaterialStateProperty.all<Color>(Colors.white54),
          ),
          icon: Icon(
            icon,
            color: Colors.white60,
          ),
          label: Text(
            text,
            style:
                TextStyle(color: Colors.white60, fontWeight: FontWeight.w400),
          ),
        ),
      ),
    );
  }
}
