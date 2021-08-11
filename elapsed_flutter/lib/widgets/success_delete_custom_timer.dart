import 'dart:async';

import 'package:elapsed_flutter/colors/elapsed_colors.dart';
import 'package:flutter/material.dart';

class SuccessDeleteCustomTimer extends StatefulWidget {
  const SuccessDeleteCustomTimer({Key? key}) : super(key: key);

  @override
  _SuccessDeleteCustomTimerState createState() =>
      _SuccessDeleteCustomTimerState();
}

class _SuccessDeleteCustomTimerState extends State<SuccessDeleteCustomTimer> {
  late Timer timer;

  @override
  void initState() {
    super.initState();
    timer = new Timer(const Duration(milliseconds: 2000), closeSuccess);
  }

  void closeSuccess() {
    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0))),
      backgroundColor: EColors.black,
      insetPadding: EdgeInsets.symmetric(horizontal: 70, vertical: 80),
      child: Container(
        height: height * 0.2,
        width: width * 0.6,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Icon(
                Icons.check,
                color: Colors.white,
              ),
              Text(
                'Success!',
                style: Theme.of(context)
                    .textTheme
                    .headline3!
                    .copyWith(color: Colors.white),
              ),
              Text(
                'The routine was successfully deleted.',
                style: Theme.of(context).textTheme.bodyText2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
