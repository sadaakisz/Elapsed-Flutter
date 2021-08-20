import 'dart:io';

import 'package:cyclop/cyclop.dart';
import 'package:elapsed_flutter/colors/elapsed_colors.dart';
import 'package:elapsed_flutter/utils/color_utils.dart';
import 'package:elapsed_flutter/widgets/custom_color_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_material_pickers/flutter_material_pickers.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
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

  String backgroundPath = '';
  final picker = ImagePicker();

  _getBackgroundImage() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      backgroundPath = prefs.getString('backgroundImage')!;
    });
  }

  Future<void> _openImagePicker() async {
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        backgroundPath = pickedImage.path;
      });
      await prefs.setString('backgroundImage', backgroundPath);
    }
  }

  resetBackgroundImage() async {
    setState(() {
      backgroundPath = '';
    });
    await prefs.setString('backgroundImage', '');
  }

  late SharedPreferences prefs;

  final fontFamilyController = TextEditingController();
  final fontSizeController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  final _formKey = GlobalKey<FormState>();

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

  _getTimerFontFamily() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      fontFamilyController.text = prefs.getString('timerFontFamily')!;
    });
  }

  _setTimerFontFamily() async {
    await prefs.setString('timerFontFamily', fontFamilyController.text);
  }

  _resetTimerFontFamily() async {
    setState(() {
      fontFamilyController.text = 'Aldrich';
    });
    await prefs.setString('timerFontFamily', 'Aldrich');
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

  _scrollDown() {
    scrollController.jumpTo(scrollController.position.maxScrollExtent);
  }

  @override
  void initState() {
    fontFamilyController.text = 'Aldrich';
    _getColors();
    _getBackgroundImage();
    _getTimerFontSize();
    _getTimerFontFamily();
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
        backgroundColor: backgroundColor,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: width / 14),
            child: Form(
              key: _formKey,
              child: Stack(
                children: [
                  ListView(
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
                      _Subtitle(subtitleText: 'General'),
                      ColorOption(
                        colorText: 'Background Color',
                        displayColor: backgroundColor,
                        hexText: backgroundColor.toHex(),
                        onColorChange: setBackgroundColor,
                        onColorReset: resetBackgroundColor,
                      ),
                      _ImageSelector(
                        imagePath: backgroundPath,
                        onTap: _openImagePicker,
                        onReset: resetBackgroundImage,
                      ),
                      _Subtitle(subtitleText: 'Timer'),
                      ColorOption(
                        colorText: 'Timer Font Color',
                        displayColor: timerFontColor,
                        hexText: timerFontColor.toHex(),
                        onColorChange: setTimerFontColor,
                        onColorReset: resetTimerFontColor,
                      ),
                      FontOption(
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
                        if (_formKey.currentState!.validate()) {
                          Navigator.of(context).pushReplacementNamed('/home');
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
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
                    config: ColorPickerConfig(
                        enableEyePicker: false, enableLibrary: false),
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
  final String? imagePath;
  final Function onTap;
  final VoidCallback onReset;
  const _ImageSelector({
    Key? key,
    this.imagePath,
    required this.onTap,
    required this.onReset,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () => onTap(),
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Container(
                      height: width / 10,
                      width: width * 0.74,
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
                      width: width / 10,
                      height: width / 10,
                      child: imagePath != ''
                          ? Image.file(File(imagePath!), fit: BoxFit.cover)
                          : Icon(
                              Icons.image_outlined,
                              color: Colors.white,
                              size: width / 16,
                            ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () => onReset(),
                child: Icon(Icons.restart_alt),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class FontOption extends StatefulWidget {
  final TextEditingController controller;
  final VoidCallback onFontFamilyChange;
  final VoidCallback onReset;
  const FontOption({
    Key? key,
    required this.controller,
    required this.onFontFamilyChange,
    required this.onReset,
  }) : super(key: key);

  @override
  _FontOptionState createState() => _FontOptionState();
}

class _FontOptionState extends State<FontOption> {
  VoidCallback get onFontFamilyChange => widget.onFontFamilyChange;
  VoidCallback get onReset => widget.onReset;
  List<String> fontFamilyList = GoogleFonts.asMap().keys.toList();
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
          //TODO: Remove notice when spacing problem is fixed.
          Text(
            'EXPERIMENTAL FEATURE! Expect\nmisaligned/uneven spacing in the timer.',
            style: Theme.of(context)
                .textTheme
                .bodyText2!
                .copyWith(color: EColors.red),
          ),
          SizedBox(height: width / 33),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  showMaterialScrollPicker<String>(
                    headerColor:
                        EColors.black, // background color of the header area
                    headerTextColor: Colors.white, // text fcolor of the header
                    backgroundColor:
                        EColors.black, // background color of the entire dialog
                    buttonTextColor: EColors.red,
                    context: context,
                    title: 'Pick your font family',
                    items: fontFamilyList,
                    selectedItem: widget.controller.text,
                    onChanged: (value) => setState(() {
                      widget.controller.text = value;
                      onFontFamilyChange();
                    }),
                  );
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Container(
                      height: width / 10,
                      width: width * 0.74,
                      decoration: BoxDecoration(
                        color: Colors.white10,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    Positioned(
                      left: width / 20,
                      child: Text(
                        widget.controller.text,
                        style: Theme.of(context).textTheme.subtitle2!.copyWith(
                              color: Colors.white,
                              fontFamily:
                                  GoogleFonts.getFont(widget.controller.text)
                                      .fontFamily,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () => onReset(),
                child: Icon(Icons.restart_alt),
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
  final VoidCallback scrollDown;
  const FontSizeOption({
    Key? key,
    required this.controller,
    required this.onFontSizeChange,
    required this.onReset,
    required this.scrollDown,
  }) : super(key: key);

  @override
  _FontSizeOptionState createState() => _FontSizeOptionState();
}

class _FontSizeOptionState extends State<FontSizeOption> {
  TextEditingController get controller => widget.controller;
  VoidCallback get onFontSizeChange => widget.onFontSizeChange;
  VoidCallback get onReset => widget.onReset;
  VoidCallback get scrollDown => widget.scrollDown;
  FocusNode _focus = new FocusNode();

  int minValue = 10;
  int maxValue = 40;

  @override
  void initState() {
    super.initState();
    _focus.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _focus.removeListener(_onFocusChange);
    _focus.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    scrollDown();
  }

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
                  height: width / 6,
                  child: Center(
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty)
                          return 'Please enter a font size between $minValue and $maxValue';
                        int numValue = int.parse(value);
                        if (numValue < minValue || maxValue < numValue)
                          return 'Please enter a font size between $minValue and $maxValue';
                        return null;
                      },
                      focusNode: _focus,
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
                            int numValue = int.parse(text);
                            if (minValue <= numValue && numValue <= maxValue)
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
                            fontSize: width / 10,
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
