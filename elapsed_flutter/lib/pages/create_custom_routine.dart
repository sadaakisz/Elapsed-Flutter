import 'dart:io';

import 'package:elapsed_flutter/colors/elapsed_colors.dart';
import 'package:elapsed_flutter/utils/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateCustomRoutine extends StatefulWidget {
  const CreateCustomRoutine({Key? key}) : super(key: key);

  @override
  _CreateCustomRoutineState createState() => _CreateCustomRoutineState();
}

class _CreateCustomRoutineState extends State<CreateCustomRoutine> {
  late SharedPreferences prefs;

  Color backgroundColor = EColors.black;
  String backgroundPath = '';

  Future<void> _initializeSharedPrefs() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      backgroundColor = (prefs.getString('backgroundColor')!.toColorFromHex());
      backgroundPath = prefs.getString('backgroundImage')!;
    });
  }

  @override
  void initState() {
    _initializeSharedPrefs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: backgroundColor,
      body: Stack(
        children: <Widget>[
          backgroundPath != ''
              ? Positioned.fill(
                  child: Opacity(
                  opacity: 0.5,
                  child: Image.file(
                    File(backgroundPath),
                    fit: BoxFit.cover,
                  ),
                ))
              : SizedBox(),
          SafeArea(
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[],
            ),
          )
        ],
      ),
    );
  }
}
