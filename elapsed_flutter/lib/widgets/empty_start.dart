import 'package:flutter/material.dart';
import 'package:ms_undraw/ms_undraw.dart';

class EmptyStart extends StatelessWidget {
  const EmptyStart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        SizedBox(height: width * 0.2),
        FractionallySizedBox(
          widthFactor: 0.65,
          child: UnDraw(
            illustration: UnDrawIllustration.empty,
            color: Colors.grey,
            height: width / 2,
          ),
        ),
        SizedBox(height: width * 0.2),
        Text(
          'There are no custom routines.\nExplore all the options for your own\npomodoro timer for all your activities!',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyText1,
        ),
        SizedBox(height: width * 0.1),
        Icon(
          Icons.expand_more,
          color: Colors.white54,
        ),
      ],
    );
  }
}
