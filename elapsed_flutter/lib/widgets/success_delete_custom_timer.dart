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
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0))),
      backgroundColor: EColors.black,
      insetPadding: EdgeInsets.symmetric(horizontal: 70, vertical: 80),
      child: FractionallySizedBox(
        widthFactor: 0.78,
        heightFactor: 0.26,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 25),
            Icon(
              Icons.check,
              color: Colors.white,
            ),
            SizedBox(height: 15),
            Text(
              'Success!',
              style: Theme.of(context)
                  .textTheme
                  .headline3!
                  .copyWith(color: Colors.white),
            ),
            SizedBox(height: 15),
            Text(
              'The routine was successfully deleted.',
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ],
        ),
      ),
    );
  }
}
