import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
