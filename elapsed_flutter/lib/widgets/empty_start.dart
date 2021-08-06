import 'package:flutter/material.dart';
import 'package:ms_undraw/ms_undraw.dart';

class EmptyStart extends StatelessWidget {
  const EmptyStart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        FractionallySizedBox(
          widthFactor: 0.65,
          child: UnDraw(
            illustration: UnDrawIllustration.empty,
            color: Colors.grey,
            height: 200,
          ),
        ),
        Flexible(child: FractionallySizedBox(heightFactor: 0.6)),
        Text(
          'There are no custom routines.\nExplore all the options for your own\npomodoro timer for all your activities!',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyText1,
        ),
        Flexible(child: FractionallySizedBox(heightFactor: 0.3)),
        Icon(
          Icons.expand_more,
          color: Colors.white54,
        ),
      ],
    );
  }
}
