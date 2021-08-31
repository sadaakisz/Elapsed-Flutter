import 'dart:io';

import 'package:app_settings/app_settings.dart';
import 'package:elapsed_flutter/colors/elapsed_colors.dart';
import 'package:elapsed_flutter/utils/color_utils.dart';
import 'package:elapsed_flutter/widgets/settings_widgets/app_shortcut.dart';
import 'package:elapsed_flutter/widgets/settings_widgets/app_title.dart';
import 'package:elapsed_flutter/widgets/settings_widgets/bottom_fade_background.dart';
import 'package:elapsed_flutter/widgets/settings_widgets/bottom_floating_button.dart';
import 'package:elapsed_flutter/widgets/settings_widgets/color_selector.dart';
import 'package:elapsed_flutter/widgets/settings_widgets/custom_name_input.dart';
import 'package:elapsed_flutter/widgets/settings_widgets/custom_slider.dart';
import 'package:elapsed_flutter/widgets/settings_widgets/image_selector.dart';
import 'package:elapsed_flutter/widgets/settings_widgets/time_option.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateCustomRoutine extends StatefulWidget {
  const CreateCustomRoutine({Key? key}) : super(key: key);

  @override
  _CreateCustomRoutineState createState() => _CreateCustomRoutineState();
}

class _CreateCustomRoutineState extends State<CreateCustomRoutine> {
  final _formKey = GlobalKey<FormState>();
  late SharedPreferences prefs;
  final picker = ImagePicker();

  Color backgroundColor = EColors.black;
  String backgroundPath = '';
  Color accentColor = EColors.green;

  final routineNameController = TextEditingController();
  String routineName = '';
  final timerTimeController = TextEditingController();
  int timerTime = 25;
  final breakTimeController = TextEditingController();
  int breakTime = 5;
  Color labelColor = EColors.red;
  String routineBackgroundPath = '';
  double notificationVolume = 1;

  Future<void> _initializeSharedPrefs() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      backgroundColor = (prefs.getString('backgroundColor')!.toColorFromHex());
      backgroundPath = prefs.getString('backgroundImage')!;
      accentColor = (prefs.getString('homePageAccentColor')!.toColorFromHex());
    });
  }

  void _initializeDefaultValues() {
    timerTimeController.text = '25';
    breakTimeController.text = '5';
  }

  void _setRoutineName() {
    routineName = routineNameController.text;
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

  void _setLabelColor(Color color) {
    setState(() {
      labelColor = color;
    });
  }

  Future<void> _setBackgroundImage() async {
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        routineBackgroundPath = pickedImage.path;
      });
    }
  }

  void _resetBackgroundImage() {
    setState(() {
      routineBackgroundPath = '';
    });
  }

  void _openSoundSettings() {
    AppSettings.openSoundSettings();
  }

  void _setNotificationVolume(double value) {
    notificationVolume = value / 100;
  }

  //TODO: Remove after implementing all parameters.
  void printParams() {
    print(routineName);
    print(timerTime);
    print(breakTime);
    print(labelColor.toHex());
    print(routineBackgroundPath);
    print(notificationVolume);
  }

  @override
  void initState() {
    _initializeSharedPrefs();
    _initializeDefaultValues();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
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
                          AppTitle(width: width, title: 'CUSTOM ROUTINE'),
                          SizedBox(height: width / 50),
                          CustomNameInput(
                              title: 'Routine Name',
                              controller: routineNameController,
                              onTextChange: _setRoutineName),
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
                          ColorSelector(
                            title: 'Label Color',
                            displayColor: labelColor,
                            onColorChange: _setLabelColor,
                            enableReset: false,
                          ),
                          ImageSelector(
                            imagePath: routineBackgroundPath,
                            onTap: _setBackgroundImage,
                            onReset: _resetBackgroundImage,
                          ),
                          AppShortcut(
                            title: 'Notification Sound',
                            content: 'Open sound settings',
                            icon: Icons.app_settings_alt_outlined,
                            onTap: _openSoundSettings,
                          ),
                          CustomSlider(
                            title: 'Notification Volume',
                            onChanged: _setNotificationVolume,
                            color: accentColor,
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
                    //TODO: Validate form
                    onTap: printParams,
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
