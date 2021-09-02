import 'package:elapsed_flutter/widgets/settings_widgets/blur_container.dart';
import 'package:flutter/material.dart';

class CustomSlider extends StatefulWidget {
  final String title;
  final double min;
  final double max;
  final Function(double) onChanged;
  final Color color;
  const CustomSlider(
      {Key? key,
      required this.title,
      this.min = 0,
      this.max = 100,
      required this.onChanged,
      required this.color})
      : super(key: key);

  @override
  _CustomSliderState createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {
  String get title => widget.title;
  double get min => widget.min;
  double get max => widget.max;
  Function(double) get onChanged => widget.onChanged;
  Color get color => widget.color;
  double _currentValue = 100;
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 9,
                child: Container(
                  height: width / 10,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(width / 6),
                  ),
                  child: Stack(
                    children: [
                      BlurContainer(borderRadius: width / 6),
                      SliderTheme(
                        data: SliderThemeData(
                          activeTrackColor: color.withOpacity(0.7),
                          inactiveTrackColor: Colors.white30,
                          thumbColor: color,
                          // Use this if you don't want padding.
                          //trackShape: CustomTrackShape(),
                        ),
                        child: Slider(
                          min: min,
                          max: max,
                          value: _currentValue,
                          divisions: (max - min).toInt(),
                          onChanged: (newValue) {
                            setState(() {
                              _currentValue = newValue;
                              onChanged(_currentValue);
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: width / 22),
              Container(
                width: width / 9,
                alignment: Alignment.center,
                child: Text(
                  _currentValue.toInt().toString() + '%',
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2!
                      .copyWith(color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
