import 'package:elapsed_flutter/colors/elapsed_colors.dart';
import 'package:elapsed_flutter/widgets/elapsed_title.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: EColors.black,
      body: Center(
        child: Column(
          children: [
            ElapsedTitle(),
            Text(
              'Hello',
              style: Theme.of(context).textTheme.headline1,
            )
          ],
        ),
      ),
    );
  }
}
