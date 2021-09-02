import 'dart:ui';

import 'package:elapsed_flutter/colors/elapsed_colors.dart';
import 'package:elapsed_flutter/widgets/settings_widgets/app_shortcut.dart';
import 'package:elapsed_flutter/widgets/settings_widgets/blur_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_pickers/flutter_material_pickers.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class FontSelector extends StatefulWidget {
  final TextEditingController controller;
  final VoidCallback onFontFamilyChange;
  final VoidCallback onReset;
  const FontSelector({
    Key? key,
    required this.controller,
    required this.onFontFamilyChange,
    required this.onReset,
  }) : super(key: key);

  @override
  _FontSelectorState createState() => _FontSelectorState();
}

class _FontSelectorState extends State<FontSelector> {
  VoidCallback get onFontFamilyChange => widget.onFontFamilyChange;
  VoidCallback get onReset => widget.onReset;
  List<String> fontFamilyList = GoogleFonts.asMap().keys.toList();

  void _launchGoogleFontsUrl() async {
    const _url = 'https://fonts.google.com/';
    await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';
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
                .copyWith(color: EColors.red.withOpacity(0.8)),
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
                    headerTextColor: Colors.white, // text color of the header
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
                child: Container(
                  height: width / 10,
                  width: width * 0.74,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      BlurContainer(),
                      Positioned(
                        left: width / 20,
                        child: Text(
                          widget.controller.text,
                          style: Theme.of(context)
                              .textTheme
                              .subtitle2!
                              .copyWith(
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
              ),
              GestureDetector(
                onTap: () => onReset(),
                child: Icon(Icons.restart_alt),
              ),
            ],
          ),
          SizedBox(height: width / 33),
          AppShortcut(
              title: "Don't know which font to choose?",
              content: 'Open Google Fonts',
              icon: Icons.north_east_rounded,
              onTap: _launchGoogleFontsUrl)
        ],
      ),
    );
  }
}
