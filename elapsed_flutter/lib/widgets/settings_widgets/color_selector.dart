import 'package:cyclop/cyclop.dart';
import 'package:elapsed_flutter/colors/elapsed_colors.dart';
import 'package:elapsed_flutter/utils/color_utils.dart';
import 'package:elapsed_flutter/widgets/custom_color_button.dart';
import 'package:flutter/material.dart';

class ColorSelector extends StatefulWidget {
  final String title;
  final Color displayColor;
  final Function(Color) onColorChange;
  final VoidCallback? onColorReset;
  final bool enableReset;
  final bool enableOutline;
  //TODO: Remove notice when light theme is implemented.
  final bool warning;
  const ColorSelector({
    Key? key,
    required this.title,
    required this.displayColor,
    required this.onColorChange,
    this.onColorReset,
    this.enableReset = true,
    this.enableOutline = false,
    this.warning = false,
  }) : super(key: key);

  @override
  _ColorSelectorState createState() => _ColorSelectorState();
}

class _ColorSelectorState extends State<ColorSelector> {
  String get title => widget.title;
  Color get displayColor => widget.displayColor;
  Function(Color) get onColorChange => widget.onColorChange;
  VoidCallback? get onColorReset => widget.onColorReset;
  bool get enableReset => widget.enableReset;
  bool get enableOutline => widget.enableOutline;

  //TODO: Remove notice when light theme is implemented.
  bool get warning => widget.warning;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: width / 33),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: Theme.of(context).textTheme.subtitle2,
          ),
          SizedBox(height: width / 33),
          //TODO: Remove notice when light theme is implemented.
          warning
              ? Text(
                  'Avoid using light colors for now,\nwe are working on a light theme 🙌',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2!
                      .copyWith(color: Colors.white38),
                )
              : SizedBox(),
          warning ? SizedBox(height: width / 33) : SizedBox(),
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
                    border: enableOutline
                        ? Border.all(color: Colors.white38, width: 0.5)
                        : Border.all(width: 0),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  config: ColorPickerConfig(
                      enableEyePicker: false, enableLibrary: false),
                  onColorChanged: (value) {
                    setState(() {
                      onColorChange(value);
                    });
                  },
                ),
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
                      displayColor.toHex(),
                      style: Theme.of(context).textTheme.overline,
                    )
                  ],
                ),
              ),
              enableReset ? SizedBox(width: width / 22) : SizedBox(),
              enableReset
                  ? GestureDetector(
                      child: Icon(Icons.restart_alt,
                          color: warning ? EColors.red : Colors.white38),
                      onTap: () {
                        setState(() {
                          onColorReset!();
                        });
                      },
                    )
                  : SizedBox(),
            ],
          ),
        ],
      ),
    );
  }
}
