import 'package:elapsed_flutter/colors/elapsed_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomSwitch extends StatefulWidget {
  final String title;
  final String subtitle;
  final Function(bool) onSwitch;
  final bool defaultValue;
  const CustomSwitch({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.onSwitch,
    this.defaultValue = true,
  }) : super(key: key);

  @override
  _CustomSwitchState createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch> {
  String get title => widget.title;
  String get subtitle => widget.subtitle;
  Function(bool) get onSwitch => widget.onSwitch;
  late bool value;

  @override
  void initState() {
    value = widget.defaultValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: width / 33),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: Theme.of(context).textTheme.subtitle2,
              ),
              SizedBox(height: width / 100),
              Text(
                subtitle,
                style: Theme.of(context).textTheme.subtitle2!.copyWith(
                    fontSize: width / 32, fontWeight: FontWeight.w300),
              ),
            ],
          ),
          Switch(
            value: value,
            onChanged: (newValue) {
              setState(() {
                value = newValue;
                onSwitch(value);
              });
            },
            activeColor: EColors.green,
            activeTrackColor: Colors.white30,
            inactiveTrackColor: Colors.white30,
          ),
        ],
      ),
    );
  }
}
