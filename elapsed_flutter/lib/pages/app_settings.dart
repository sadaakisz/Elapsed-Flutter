import 'dart:io';

import 'package:elapsed_flutter/colors/elapsed_colors.dart';
import 'package:elapsed_flutter/pages/home.dart';
import 'package:elapsed_flutter/utils/color_utils.dart';
import 'package:elapsed_flutter/utils/custom_navigator.dart';
import 'package:elapsed_flutter/widgets/settings_widgets/color_option.dart';
import 'package:elapsed_flutter/widgets/settings_widgets/font_selector.dart';
import 'package:elapsed_flutter/widgets/settings_widgets/font_size_option.dart';
import 'package:elapsed_flutter/widgets/settings_widgets/image_selector.dart';
import 'package:elapsed_flutter/widgets/settings_widgets/subtitle.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSettings extends StatefulWidget {
  const AppSettings({Key? key}) : super(key: key);

  @override
  _AppSettingsState createState() => _AppSettingsState();
}

class _AppSettingsState extends State<AppSettings> {
  final _formKey = GlobalKey<FormState>();
  late SharedPreferences prefs;
  final picker = ImagePicker();
  final ScrollController scrollController = ScrollController();

  Color backgroundColor = EColors.black;
  String backgroundPath = '';
  Color timerFontColor = Colors.white;
  final fontFamilyController = TextEditingController();
  final fontSizeController = TextEditingController();
  Color quickRoutineAccentColor = Colors.tealAccent.shade400;
  Color homePageAccentColor = EColors.green;

  Future<void> _initializeSharedPrefs() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      backgroundColor = (prefs.getString('backgroundColor')!.toColorFromHex());
      backgroundPath = prefs.getString('backgroundImage')!;
      timerFontColor = (prefs.getString('timerFontColor')!.toColorFromHex());
      fontFamilyController.text = prefs.getString('timerFontFamily')!;
      fontSizeController.text =
          prefs.getDouble('timerFontSize')!.toInt().toString();
      quickRoutineAccentColor =
          (prefs.getString('quickRoutineAccentColor')!.toColorFromHex());
      homePageAccentColor =
          (prefs.getString('homePageAccentColor')!.toColorFromHex());
    });
  }

  Future<void> _setBackgroundColor(Color color) async {
    setState(() {
      backgroundColor = color;
    });
    await prefs.setString('backgroundColor', color.toHex());
    _resetBackgroundImage();
  }

  Future<void> _resetBackgroundColor() async {
    setState(() {
      backgroundColor = EColors.black;
    });
    await prefs.setString('backgroundColor', EColors.black.toHex());
  }

  Future<void> _setBackgroundImage() async {
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        backgroundPath = pickedImage.path;
      });
      await prefs.setString('backgroundImage', backgroundPath);
    }
    _resetBackgroundColor();
  }

  Future<void> _resetBackgroundImage() async {
    setState(() {
      backgroundPath = '';
    });
    await prefs.setString('backgroundImage', '');
  }

  Future<void> _setTimerFontColor(Color color) async {
    setState(() {
      timerFontColor = color;
    });
    await prefs.setString('timerFontColor', color.toHex());
  }

  Future<void> _resetTimerFontColor() async {
    setState(() {
      timerFontColor = Colors.white;
    });
    await prefs.setString('timerFontColor', Colors.white.toHex());
  }

  Future<void> _setTimerFontFamily() async {
    await prefs.setString('timerFontFamily', fontFamilyController.text);
  }

  Future<void> _resetTimerFontFamily() async {
    setState(() {
      fontFamilyController.text = 'Aldrich';
    });
    await prefs.setString('timerFontFamily', 'Aldrich');
  }

  Future<void> _setTimerFontSize() async {
    await prefs.setDouble(
        'timerFontSize', double.parse(fontSizeController.text));
  }

  Future<void> _resetTimerFontSize() async {
    setState(() {
      fontSizeController.text = '30';
    });
    await prefs.setDouble('timerFontSize', 30);
  }

  Future<void> _setQuickRoutineAccentColor(Color color) async {
    setState(() {
      quickRoutineAccentColor = color;
    });
    await prefs.setString('quickRoutineAccentColor', color.toHex());
  }

  Future<void> _resetQuickRoutineAccentColor() async {
    setState(() {
      quickRoutineAccentColor = Colors.tealAccent.shade400;
    });
    await prefs.setString(
        'quickRoutineAccentColor', Colors.tealAccent.shade400.toHex());
  }

  Future<void> _setHomePageAccentColor(Color color) async {
    setState(() {
      homePageAccentColor = color;
    });
    await prefs.setString('homePageAccentColor', color.toHex());
  }

  Future<void> _resetHomePageAccentColor() async {
    setState(() {
      homePageAccentColor = EColors.green;
    });
    await prefs.setString('homePageAccentColor', EColors.green.toHex());
  }

  void _scrollDown() {
    scrollController.jumpTo(scrollController.position.maxScrollExtent);
  }

  @override
  void initState() {
    fontFamilyController.text = 'Aldrich';
    _initializeSharedPrefs();
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
                        controller: scrollController,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(top: width / 16),
                            child: Text(
                              'APP SETTINGS',
                              style: Theme.of(context).textTheme.headline1,
                            ),
                          ),
                          SizedBox(height: width / 50),
                          Subtitle(subtitleText: 'General'),
                          ColorSelector(
                            title: 'Background Color',
                            displayColor: backgroundColor,
                            onColorChange: _setBackgroundColor,
                            onColorReset: _resetBackgroundColor,
                          ),
                          ImageSelector(
                            imagePath: backgroundPath,
                            onTap: _setBackgroundImage,
                            onReset: _resetBackgroundImage,
                          ),
                          Subtitle(subtitleText: 'Timer'),
                          ColorSelector(
                            title: 'Timer Font Color',
                            displayColor: timerFontColor,
                            onColorChange: _setTimerFontColor,
                            onColorReset: _resetTimerFontColor,
                          ),
                          FontSelector(
                            controller: fontFamilyController,
                            onFontFamilyChange: _setTimerFontFamily,
                            onReset: _resetTimerFontFamily,
                          ),
                          FontSizeOption(
                            controller: fontSizeController,
                            onFontSizeChange: _setTimerFontSize,
                            onReset: _resetTimerFontSize,
                            scrollDown: _scrollDown,
                          ),
                          ColorSelector(
                            title: 'Quick Routine Accent Color',
                            displayColor: quickRoutineAccentColor,
                            onColorChange: _setQuickRoutineAccentColor,
                            onColorReset: _resetQuickRoutineAccentColor,
                          ),
                          Subtitle(subtitleText: 'Home page'),
                          ColorSelector(
                            title: 'Home Page Accent Color',
                            displayColor: homePageAccentColor,
                            onColorChange: _setHomePageAccentColor,
                            onColorReset: _resetHomePageAccentColor,
                          ),
                          SizedBox(height: width / 4),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    width: width,
                    height: width / 5,
                    bottom: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              backgroundColor,
                              backgroundColor.withOpacity(0)
                            ]),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: width / 13,
                    width: width * 0.86,
                    child: GestureDetector(
                      child: Container(
                        height: width / 8,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade800,
                          borderRadius: BorderRadius.circular(3),
                        ),
                        child: Center(
                          child: Text('SAVE',
                              style: Theme.of(context).textTheme.button),
                        ),
                      ),
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          navPush(context, Home());
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
