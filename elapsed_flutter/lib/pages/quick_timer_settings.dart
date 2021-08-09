import 'package:elapsed_flutter/widgets/settings_textfield.dart';
import 'package:elapsed_flutter/widgets/timer_button.dart';
import 'package:flutter/material.dart';

class QuickTimerSettings extends StatefulWidget {
  final int timerTime;
  final int breakTime;
  const QuickTimerSettings(this.timerTime, this.breakTime);
  @override
  _QuickTimerSettingsState createState() => _QuickTimerSettingsState();
}

class _QuickTimerSettingsState extends State<QuickTimerSettings> {
  final timerTimeController = TextEditingController();
  final breakTimeController = TextEditingController();

  int get timerTime => widget.timerTime;
  int get breakTime => widget.breakTime;
  @override
  void initState() {
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
                    Text('QUICK ROUTINE',
                        style: Theme.of(context).textTheme.headline1),
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
