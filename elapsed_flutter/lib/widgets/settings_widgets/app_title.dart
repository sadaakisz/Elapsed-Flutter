import 'package:flutter/material.dart';

class AppTitle extends StatelessWidget {
  final double width;
  final String title;
  const AppTitle({Key? key, required this.width, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: width / 16),
      child: Text(
        title,
        style: Theme.of(context).textTheme.headline1,
      ),
    );
  }
}
