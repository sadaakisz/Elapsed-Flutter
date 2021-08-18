import 'package:cyclop/cyclop.dart';
import 'package:elapsed_flutter/colors/elapsed_colors.dart';
import 'package:elapsed_flutter/utils/color_utils.dart';
import 'package:elapsed_flutter/widgets/custom_color_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSettings extends StatefulWidget {
  const AppSettings({Key? key}) : super(key: key);

  @override
  _AppSettingsState createState() => _AppSettingsState();
}

class _AppSettingsState extends State<AppSettings> {
  Color backgroundColor = EColors.black;
  Color timerFontColor = Colors.white;
  Color quickRoutineAccentColor = Colors.tealAccent.shade400;
  Color homePageAccentColor = EColors.green;

  late SharedPreferences prefs;

  final fontSizeController = TextEditingController();

  _getColors() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      backgroundColor = (prefs.getString('backgroundColor')!.toColorFromHex());
      timerFontColor = (prefs.getString('timerFontColor')!.toColorFromHex());
      quickRoutineAccentColor =
          (prefs.getString('quickRoutineAccentColor')!.toColorFromHex());
      homePageAccentColor =
          (prefs.getString('homePageAccentColor')!.toColorFromHex());
    });
  }

  setBackgroundColor(Color color) async {
    setState(() {
      backgroundColor = color;
    });
    await prefs.setString('backgroundColor', color.toHex());
  }

  resetBackgroundColor() async {
    setState(() {
      backgroundColor = EColors.black;
    });
    await prefs.setString('backgroundColor', EColors.black.toHex());
  }

  setTimerFontColor(Color color) async {
    setState(() {
      timerFontColor = color;
    });
    await prefs.setString('timerFontColor', color.toHex());
  }

  resetTimerFontColor() async {
    setState(() {
      timerFontColor = Colors.white;
    });
    await prefs.setString('timerFontColor', Colors.white.toHex());
  }

  setQuickRoutineAccentColor(Color color) async {
    setState(() {
      quickRoutineAccentColor = color;
    });
    await prefs.setString('quickRoutineAccentColor', color.toHex());
  }

  resetQuickRoutineAccentColor() async {
    setState(() {
      quickRoutineAccentColor = Colors.tealAccent.shade400;
    });
    await prefs.setString(
        'quickRoutineAccentColor', Colors.tealAccent.shade400.toHex());
  }

  setHomePageAccentColor(Color color) async {
    setState(() {
      homePageAccentColor = color;
    });
    await prefs.setString('homePageAccentColor', color.toHex());
  }

  resetHomePageAccentColor() async {
    setState(() {
      homePageAccentColor = EColors.green;
    });
    await prefs.setString('homePageAccentColor', EColors.green.toHex());
  }

  _getTimerFontSize() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      fontSizeController.text =
          prefs.getDouble('timerFontSize')!.toInt().toString();
    });
  }

  _setTimerFontSize() async {
    await prefs.setDouble(
        'timerFontSize', double.parse(fontSizeController.text));
  }

  _resetTimerFontSize() async {
    await prefs.setDouble('timerFontSize', 30);
    fontSizeController.text = '30';
  }

  @override
  void initState() {
    _getColors();
    _getTimerFontSize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width / 14),
          child: Stack(
            children: [
              ListView(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: width / 16),
                    child: Text(
                      'APP SETTINGS',
                      style: Theme.of(context).textTheme.headline1,
                    ),
                  ),
                  SizedBox(height: width / 50),
                  _Subtitle(subtitleText: 'General'),
                  ColorOption(
                    colorText: 'Background Color',
                    displayColor: backgroundColor,
                    hexText: backgroundColor.toHex(),
                    onColorChange: setBackgroundColor,
                    onColorReset: resetBackgroundColor,
                  ),
                  _ImageSelector(),
                  _Subtitle(subtitleText: 'Timer'),
                  ColorOption(
                    colorText: 'Timer Font Color',
                    displayColor: timerFontColor,
                    hexText: timerFontColor.toHex(),
                    onColorChange: setTimerFontColor,
                    onColorReset: resetTimerFontColor,
                  ),
                  _FontOption(selectedFont: 'Aldrich'),
                  FontSizeOption(
                    controller: fontSizeController,
                    onFontSizeChange: _setTimerFontSize,
                    onReset: _resetTimerFontSize,
                  ),
                  ColorOption(
                    colorText: 'Quick Routine Accent Color',
                    displayColor: quickRoutineAccentColor,
                    hexText: quickRoutineAccentColor.toHex(),
                    onColorChange: setQuickRoutineAccentColor,
                    onColorReset: resetQuickRoutineAccentColor,
                  ),
                  _Subtitle(subtitleText: 'Home page'),
                  ColorOption(
                    colorText: 'Home Page Accent Color',
                    displayColor: homePageAccentColor,
                    hexText: homePageAccentColor.toHex(),
                    onColorChange: setHomePageAccentColor,
                    onColorReset: resetHomePageAccentColor,
                  ),
                  SizedBox(height: width / 4),
                ],
              ),
              Positioned(
                width: width,
                height: width / 4,
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
                width: width * 6 / 7,
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
                    Navigator.of(context).pushReplacementNamed('/home');
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _Subtitle extends StatelessWidget {
  final String subtitleText;
  const _Subtitle({
    Key? key,
    required this.subtitleText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: width / 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            subtitleText,
            style: Theme.of(context).textTheme.subtitle1,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: width / 25),
              child: Container(
                height: 2,
                decoration: BoxDecoration(
                  color: Colors.white38,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ColorOption extends StatefulWidget {
  final String colorText;
  final Color displayColor;
  final String hexText;
  final Function(Color) onColorChange;
  final VoidCallback onColorReset;
  const ColorOption({
    Key? key,
    required this.colorText,
    required this.displayColor,
    required this.hexText,
    required this.onColorChange,
    required this.onColorReset,
  }) : super(key: key);

  @override
  _ColorOptionState createState() => _ColorOptionState();
}

class _ColorOptionState extends State<ColorOption> {
  String get colorText => widget.colorText;
  Color get displayColor => widget.displayColor;
  String get hexText => widget.hexText;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: width / 33),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            colorText,
            style: Theme.of(context).textTheme.subtitle2,
          ),
          SizedBox(height: width / 33),
          Row(
            children: <Widget>[
              Flexible(
                flex: 9,
                child: CustomColorButton(
                    darkMode: true,
                    color: displayColor,
                    boxShape: BoxShape.rectangle,
                    height: width / 10,
                    decoration: BoxDecoration(
                      color: displayColor,
                      border: Border.all(color: Colors.white38, width: 0.5),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    config: ColorPickerConfig(enableEyePicker: false),
                    onColorChanged: (value) {
                      setState(() {
                        widget.onColorChange(value);
                      });
                    }),
              ),
              SizedBox(width: width / 22),
              Flexible(
                flex: 5,
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Container(
                      height: width / 10,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    Text(
                      hexText,
                      style: Theme.of(context).textTheme.overline,
                    )
                  ],
                ),
              ),
              SizedBox(width: width / 22),
              GestureDetector(
                child: Icon(Icons.restart_alt),
                onTap: () {
                  setState(() {
                    widget.onColorReset();
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ImageSelector extends StatelessWidget {
  const _ImageSelector({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: width / 33),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Background Image',
            style: Theme.of(context).textTheme.subtitle2,
          ),
          SizedBox(height: width / 33),
          Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Container(
                height: width / 10,
                decoration: BoxDecoration(
                  color: Colors.white10,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              Positioned(
                left: width / 20,
                child: Text(
                  'Select photo from library',
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2!
                      .copyWith(color: Colors.white),
                ),
              ),
              Positioned(
                right: width / 20,
                child: Icon(
                  Icons.image_outlined,
                  color: Colors.white,
                  size: width / 16,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _FontOption extends StatelessWidget {
  final String selectedFont;
  const _FontOption({
    Key? key,
    required this.selectedFont,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: width / 33),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Timer Font Family',
            style: Theme.of(context).textTheme.subtitle2,
          ),
          SizedBox(height: width / 33),
          Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Container(
                height: width / 10,
                decoration: BoxDecoration(
                  color: Colors.white10,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              Positioned(
                left: width / 20,
                child: Text(
                  selectedFont,
                  style: Theme.of(context).textTheme.subtitle2!.copyWith(
                        color: Colors.white,
                        fontFamily:
                            GoogleFonts.getFont(selectedFont).fontFamily,
                      ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class FontSizeOption extends StatefulWidget {
  final TextEditingController controller;
  final VoidCallback onFontSizeChange;
  final VoidCallback onReset;
  const FontSizeOption({
    Key? key,
    required this.controller,
    required this.onFontSizeChange,
    required this.onReset,
  }) : super(key: key);

  @override
  _FontSizeOptionState createState() => _FontSizeOptionState();
}

class _FontSizeOptionState extends State<FontSizeOption> {
  TextEditingController get controller => widget.controller;
  VoidCallback get onFontSizeChange => widget.onFontSizeChange;
  VoidCallback get onReset => widget.onReset;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: width / 33),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Timer Font Size',
            style: Theme.of(context).textTheme.subtitle2,
          ),
          SizedBox(height: width / 33),
          Row(
            children: <Widget>[
              Expanded(
                flex: 9,
                child: Container(
                  padding: EdgeInsets.only(left: width / 131),
                  height: width / 10,
                  child: TextField(
                    textAlign: TextAlign.start,
                    keyboardType: TextInputType.number,
                    onChanged: (text) {
                      setState(() {
                        if (controller.text.isNotEmpty) {
                          String firstChar = controller.text[0];
                          if (firstChar == '0') {
                            controller.text =
                                text.replaceFirst(new RegExp(r'^0+'), '');
                            controller.selection = TextSelection.fromPosition(
                                TextPosition(offset: 0));
                          }
                          onFontSizeChange();
                        }
                      });
                    },
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    style: Theme.of(context).textTheme.headline1!.copyWith(
                          color: Colors.white,
                          decoration: TextDecoration.underline,
                        ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                    ),
                    controller: widget.controller,
                  ),
                ),
              ),
              SizedBox(width: width / 22),
              GestureDetector(
                child: Icon(Icons.restart_alt),
                onTap: () => onReset(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
