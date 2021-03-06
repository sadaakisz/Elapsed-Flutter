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
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(left: 5.0),
      child: SizedBox(
        width: width / 2,
        height: width / 7,
        child: TextButton.icon(
          onPressed: () {
            event();
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.white10),
            overlayColor: MaterialStateProperty.all<Color>(Colors.black),
          ),
          icon: Icon(
            icon,
            color: Theme.of(context).textTheme.button!.color,
          ),
          label: Text(
            text,
            style: Theme.of(context).textTheme.button,
          ),
        ),
      ),
    );
  }
}
