import 'package:elapsed_flutter/colors/elapsed_colors.dart';
import 'package:elapsed_flutter/widgets/timer_button.dart';
import 'package:flutter/material.dart';

class QuickTimerSettings extends StatelessWidget {
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
                            width: MediaQuery.of(context).size.width * .25,
                            child: Row(
                                crossAxisAlignment: CrossAxisAlignment.baseline,
                                textBaseline: TextBaseline.alphabetic,
                                children: [
                                  Flexible(
                                    child: TextField(
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 48,
                                          fontWeight: FontWeight.w500,
                                          decoration: TextDecoration.underline),
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        errorBorder: InputBorder.none,
                                        disabledBorder: InputBorder.none,
                                      ),
                                      controller: TextEditingController(
                                        text: "45",
                                      ),
                                    ),
                                  ),
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
                            width: MediaQuery.of(context).size.width * .2,
                            child: Row(
                                crossAxisAlignment: CrossAxisAlignment.baseline,
                                mainAxisAlignment: MainAxisAlignment.end,
                                textBaseline: TextBaseline.alphabetic,
                                children: [
                                  Flexible(
                                    child: TextField(
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 48,
                                          fontWeight: FontWeight.w500,
                                          decoration: TextDecoration.underline),
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        errorBorder: InputBorder.none,
                                        disabledBorder: InputBorder.none,
                                      ),
                                      controller: TextEditingController(
                                        text: "5",
                                      ),
                                    ),
                                  ),
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
                          Navigator.pop(context);
                        })
                  ],
                )
              ]),
        ),
      ),
    );
  }
}
