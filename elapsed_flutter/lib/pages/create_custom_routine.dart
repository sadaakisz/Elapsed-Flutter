import 'dart:io';

import 'package:elapsed_flutter/colors/elapsed_colors.dart';
import 'package:elapsed_flutter/utils/color_utils.dart';
import 'package:elapsed_flutter/widgets/settings_widgets/app_title.dart';
import 'package:elapsed_flutter/widgets/settings_widgets/bottom_fade_background.dart';
import 'package:elapsed_flutter/widgets/settings_widgets/bottom_floating_button.dart';
import 'package:elapsed_flutter/widgets/settings_widgets/color_selector.dart';
import 'package:elapsed_flutter/widgets/settings_widgets/image_selector.dart';
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

  Color labelColor = EColors.red;
  String routineBackgroundPath = '';

  Future<void> _initializeSharedPrefs() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      backgroundColor = (prefs.getString('backgroundColor')!.toColorFromHex());
      backgroundPath = prefs.getString('backgroundImage')!;
    });
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
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width / 14),
                  child: Form(
                    key: _formKey,
                    child: ListView(
                      children: <Widget>[
                        AppTitle(width: width, title: 'CUSTOM ROUTINE'),
                        SizedBox(height: width / 50),
                        ColorSelector(
                          title: 'Label Color',
                          displayColor: backgroundColor,
                          onColorChange: _setLabelColor,
                          enableReset: false,
                        ),
                        ImageSelector(
                          imagePath: backgroundPath,
                          onTap: _setBackgroundImage,
                          enableReset: false,
                        ),
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
                  onTap: () {},
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
