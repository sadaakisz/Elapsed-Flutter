import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TimeOption extends StatefulWidget {
  final String title;
  final TextEditingController controller;
  final VoidCallback onTimeChange;
  final VoidCallback onReset;
  final VoidCallback? scrollDown;
  const TimeOption({
    Key? key,
    required this.title,
    required this.controller,
    required this.onTimeChange,
    required this.onReset,
    this.scrollDown,
  }) : super(key: key);

  @override
  _TimeOptionState createState() => _TimeOptionState();
}

class _TimeOptionState extends State<TimeOption> {
  String get title => widget.title;
  TextEditingController get controller => widget.controller;
  VoidCallback get onTimeChange => widget.onTimeChange;
  VoidCallback get onReset => widget.onReset;
  VoidCallback? get scrollDown => widget.scrollDown;
  FocusNode _focus = new FocusNode();

  int minValue = 1;
  int maxValue = 59;

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
    if (scrollDown != null) scrollDown!();
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
            title,
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
                          return 'Please enter a time between $minValue and $maxValue minutes';
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
                              onTimeChange();
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
