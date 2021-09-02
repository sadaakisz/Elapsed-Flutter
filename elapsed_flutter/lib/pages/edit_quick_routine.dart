import 'dart:io';

import 'package:elapsed_flutter/colors/elapsed_colors.dart';
import 'package:elapsed_flutter/utils/color_utils.dart';
import 'package:elapsed_flutter/widgets/settings_widgets/app_title.dart';
import 'package:elapsed_flutter/widgets/settings_widgets/bottom_fade_background.dart';
import 'package:elapsed_flutter/widgets/settings_widgets/bottom_floating_button.dart';
import 'package:elapsed_flutter/widgets/settings_widgets/time_option.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditQuickRoutine extends StatefulWidget {
  final int timerTime;
  final int breakTime;
  const EditQuickRoutine({
    Key? key,
    required this.timerTime,
    required this.breakTime,
  }) : super(key: key);

  @override
  _EditQuickRoutineState createState() => _EditQuickRoutineState();
}

class _EditQuickRoutineState extends State<EditQuickRoutine> {
  final _formKey = GlobalKey<FormState>();
  late SharedPreferences prefs;

  Color backgroundColor = EColors.black;
  String backgroundPath = '';
  Color accentColor = EColors.green;

  final timerTimeController = TextEditingController();
  final breakTimeController = TextEditingController();

  int timerTime = 25;
  int breakTime = 5;

  Future<void> _initializeSharedPrefs() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      backgroundColor = (prefs.getString('backgroundColor')!.toColorFromHex());
      backgroundPath = prefs.getString('backgroundImage')!;
      accentColor = (prefs.getString('homePageAccentColor')!.toColorFromHex());
    });
  }

  Future<void> _setMinutesSharedPrefs(timerTime, breakTime) async {
    await prefs.setInt('timerMinutes', timerTime);
    await prefs.setInt('breakMinutes', breakTime);
  }

  void _setTimerTime() {
    timerTime = int.parse(timerTimeController.text);
  }

  void _resetTimerTime() {
    setState(() {
      timerTimeController.text = '25';
    });
    timerTime = 25;
  }

  void _setBreakTime() {
    breakTime = int.parse(breakTimeController.text);
  }

  void _resetBreakTime() {
    setState(() {
      breakTimeController.text = '5';
    });
    breakTime = 5;
  }

  @override
  void initState() {
    _initializeSharedPrefs();
    timerTime = widget.timerTime;
    breakTime = widget.breakTime;
    timerTimeController.text = timerTime.toString();
    breakTimeController.text = breakTime.toString();
    super.initState();
  }

  @override
  void dispose() {
    timerTimeController.dispose();
    breakTimeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        if (_formKey.currentState!.validate())
          FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
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
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: width / 14),
                    child: Form(
                      key: _formKey,
                      child: ListView(
                        children: <Widget>[
                          SizedBox(height: height * 0.25),
                          AppTitle(width: width, title: 'EDIT\nQUICK ROUTINE'),
                          SizedBox(height: width / 50),
                          TimeOption(
                            title: 'Timer Time',
                            controller: timerTimeController,
                            onTimeChange: _setTimerTime,
                            onReset: _resetTimerTime,
                          ),
                          TimeOption(
                            title: 'Break Time',
                            controller: breakTimeController,
                            onTimeChange: _setBreakTime,
                            onReset: _resetBreakTime,
                          ),
                          SizedBox(height: width / 4),
                        ],
                      ),
                    ),
                  ),
                  BottomFadeBackground(
                    width: width,
                    fadeBackgroundColor: backgroundColor,
                  ),
                  BottomFloatingButton(
                    child:
                        Text('SAVE', style: Theme.of(context).textTheme.button),
                    width: width,
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        _setMinutesSharedPrefs(
                            int.parse(timerTimeController.text),
                            int.parse(breakTimeController.text));
                        Navigator.pop(context, [
                          timerTimeController.text,
                          breakTimeController.text
                        ]);
                      }
                    },
                    backButton: true,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
