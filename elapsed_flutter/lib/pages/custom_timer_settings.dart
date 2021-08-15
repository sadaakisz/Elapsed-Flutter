import 'package:cyclop/cyclop.dart';
import 'package:elapsed_flutter/widgets/settings_textfield.dart';
import 'package:elapsed_flutter/widgets/timer_button.dart';
import 'package:flutter/material.dart';

class CustomTimerSettings extends StatefulWidget {
  final int timerTime;
  final int breakTime;
  final String customName;
  final Color? timerColor;
  const CustomTimerSettings(this.timerTime, this.breakTime, this.customName,
      {this.timerColor});
  @override
  _CustomTimerSettingsState createState() => _CustomTimerSettingsState();
}

class _CustomTimerSettingsState extends State<CustomTimerSettings> {
  final timerTimeController = TextEditingController();
  final breakTimeController = TextEditingController();
  final customNameController = TextEditingController();

  int get timerTime => widget.timerTime;
  int get breakTime => widget.breakTime;
  String get customName => widget.customName;
  Color? get timerColor => widget.timerColor;
  Color actualColor = Color(0x123456);

  Set<Color> swatches = Colors.primaries.map((e) => Color(e.value)).toSet();

  @override
  void initState() {
    timerTimeController.text = timerTime.toString();
    breakTimeController.text = breakTime.toString();
    customNameController.text = customName.toString();
    if (timerColor != null) {
      actualColor = timerColor!;
    }
    super.initState();
  }

  @override
  void dispose() {
    timerTimeController.dispose();
    breakTimeController.dispose();
    customNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        width: MediaQuery.of(context).size.width * 1,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('CUSTOM ROUTINE',
                        style: Theme.of(context).textTheme.headline1),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Text('Routine Name',
                                style: Theme.of(context).textTheme.subtitle2),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * .5,
                            child: Row(
                                crossAxisAlignment: CrossAxisAlignment.baseline,
                                textBaseline: TextBaseline.alphabetic,
                                children: [
                                  Flexible(
                                      child: SettingsTextField(
                                          customNameController)),
                                ]),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Text('Timer Time',
                                style: Theme.of(context).textTheme.subtitle2),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * .5,
                            child: Row(
                                crossAxisAlignment: CrossAxisAlignment.baseline,
                                textBaseline: TextBaseline.alphabetic,
                                children: [
                                  Flexible(
                                      child: SettingsTextField(
                                          timerTimeController)),
                                  Text('min',
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle2),
                                ]),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Text('Break Time',
                                style: Theme.of(context).textTheme.subtitle2),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * .5,
                            child: Row(
                                crossAxisAlignment: CrossAxisAlignment.baseline,
                                mainAxisAlignment: MainAxisAlignment.end,
                                textBaseline: TextBaseline.alphabetic,
                                children: [
                                  Flexible(
                                      child: SettingsTextField(
                                          breakTimeController)),
                                  Text('min',
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle2),
                                ]),
                          ),
                        ],
                      ),
                    ),
                    ColorButton(
                      darkMode: true,
                      key: Key('c2'),
                      color: actualColor,
                      boxShape: BoxShape.rectangle,
                      swatches: swatches,
                      size: 32,
                      config: ColorPickerConfig(
                        enableOpacity: false,
                        enableLibrary: false,
                      ),
                      onColorChanged: (value) =>
                          setState(() => actualColor = value),
                      onSwatchesChanged: (newSwatches) =>
                          setState(() => swatches = newSwatches),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TimerButton(
                        text: 'START',
                        icon: Icons.play_arrow,
                        event: () {
                          if (timerTimeController.text != '' &&
                              breakTimeController.text != '') {
                            //TODO: Update the custom timer object's time
                            Navigator.pop(context, [
                              timerTimeController.text,
                              breakTimeController.text
                            ]);
                          } else {
                            ScaffoldMessenger.of(context)
                              ..removeCurrentSnackBar()
                              ..showSnackBar(SnackBar(
                                  content: Text('Please add a valid time')));
                          }
                        })
                  ],
                )
              ]),
        ),
      ),
    );
  }
}
