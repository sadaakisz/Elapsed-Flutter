import 'dart:io';

import 'package:app_settings/app_settings.dart';
import 'package:elapsed_flutter/colors/elapsed_colors.dart';
import 'package:elapsed_flutter/models/custom_routine.dart';
import 'package:elapsed_flutter/pages/home.dart';
import 'package:elapsed_flutter/utils/color_utils.dart';
import 'package:elapsed_flutter/utils/custom_navigator.dart';
import 'package:elapsed_flutter/widgets/settings_widgets/app_shortcut.dart';
import 'package:elapsed_flutter/widgets/settings_widgets/app_title.dart';
import 'package:elapsed_flutter/widgets/settings_widgets/bottom_fade_background.dart';
import 'package:elapsed_flutter/widgets/settings_widgets/bottom_floating_button.dart';
import 'package:elapsed_flutter/widgets/settings_widgets/color_selector.dart';
import 'package:elapsed_flutter/widgets/settings_widgets/custom_name_input.dart';
import 'package:elapsed_flutter/widgets/settings_widgets/custom_slider.dart';
import 'package:elapsed_flutter/widgets/settings_widgets/custom_switch.dart';
import 'package:elapsed_flutter/widgets/settings_widgets/image_selector.dart';
import 'package:elapsed_flutter/widgets/settings_widgets/time_option.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditCustomRoutine extends StatefulWidget {
  final int index;
  const EditCustomRoutine({Key? key, required this.index}) : super(key: key);

  @override
  _EditCustomRoutineState createState() => _EditCustomRoutineState();
}

class _EditCustomRoutineState extends State<EditCustomRoutine> {
  int get index => widget.index;

  late CustomRoutine customRoutine;

  final _formKey = GlobalKey<FormState>();
  late SharedPreferences prefs;
  final customRoutineBox = Hive.box('custom_routines');
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
  bool vibrate = true;
  bool autoStart = false;

  Future<void> _initializeSharedPrefs() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      backgroundColor = (prefs.getString('backgroundColor')!.toColorFromHex());
      backgroundPath = prefs.getString('backgroundImage')!;
      accentColor = (prefs.getString('homePageAccentColor')!.toColorFromHex());
    });
  }

  void _initializeValues() {
    customRoutine = customRoutineBox.getAt(index);
    routineNameController.text = customRoutine.name;
    routineName = customRoutine.name;
    timerTimeController.text = customRoutine.timerTime.toString();
    timerTime = customRoutine.timerTime;
    breakTimeController.text = customRoutine.breakTime.toString();
    breakTime = customRoutine.breakTime;
    labelColor = customRoutine.labelColor.toColorFromHex();
    routineBackgroundPath = customRoutine.background;
    notificationVolume =
        double.parse(customRoutine.notificationVolume.toString());
    vibrate = customRoutine.vibrate;
    autoStart = customRoutine.autoStart;
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

  void _setVibration(bool value) {
    vibrate = value;
  }

  void _setAutostart(bool value) {
    autoStart = value;
  }

  void _editCustomRoutine() {
    _formKey.currentState!.validate();
    CustomRoutine customRoutine = CustomRoutine(
      name: routineName,
      timerTime: timerTime,
      breakTime: breakTime,
      labelColor: labelColor.toHex(),
      background: routineBackgroundPath,
      notificationVolume: notificationVolume.toInt(),
      vibrate: vibrate,
      autoStart: autoStart,
    );
    setState(() {
      customRoutineBox.putAt(index, customRoutine);
    });
    navPushReplace(context, Home());
  }

  @override
  void initState() {
    _initializeSharedPrefs();
    Hive.openBox('custom_routines');
    _initializeValues();
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
                          AppTitle(width: width, title: 'EDIT\nCUSTOM ROUTINE'),
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
                          CustomSwitch(
                            title: 'Vibrate',
                            subtitle:
                                'Phone will vibrate during each notification',
                            onSwitch: _setVibration,
                          ),
                          CustomSwitch(
                            title: 'Auto-Start',
                            subtitle:
                                'Timer will start as soon as the app is opened',
                            onSwitch: _setAutostart,
                            defaultValue: false,
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
                    onTap: _editCustomRoutine,
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
