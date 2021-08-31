import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

class CustomNameInput extends StatefulWidget {
  final String title;
  final TextEditingController controller;
  final VoidCallback onTextChange;
  final VoidCallback? scrollDown;
  const CustomNameInput(
      {Key? key,
      required this.title,
      required this.controller,
      required this.onTextChange,
      this.scrollDown})
      : super(key: key);

  @override
  _CustomNameInputState createState() => _CustomNameInputState();
}

class _CustomNameInputState extends State<CustomNameInput> {
  String get title => widget.title;
  TextEditingController get controller => widget.controller;
  VoidCallback get onTextChange => widget.onTextChange;
  VoidCallback? get scrollDown => widget.scrollDown;
  FocusNode _focus = new FocusNode();
  String hintText = WordPair.random().asPascalCase;

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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(left: width / 20),
                  height: width / 10,
                  decoration: BoxDecoration(
                    color: Colors.white10,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty)
                        setState(() {
                          controller.text = hintText;
                          onTextChange();
                        });
                    },
                    focusNode: _focus,
                    textAlign: TextAlign.start,
                    onChanged: (text) {
                      setState(() {
                        if (controller.text.isNotEmpty) {
                          onTextChange();
                        }
                      });
                    },
                    style: Theme.of(context).textTheme.subtitle2!.copyWith(
                          color: Colors.white,
                        ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      hintText: hintText,
                      hintStyle: Theme.of(context).textTheme.subtitle2,
                    ),
                    controller: widget.controller,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
