import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SettingsTextField extends StatefulWidget {
  final TextEditingController controller;
  const SettingsTextField(this.controller);
  @override
  _SettingsTextFieldState createState() => _SettingsTextFieldState();
}

class _SettingsTextFieldState extends State<SettingsTextField> {
  TextEditingController get controller => widget.controller;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return TextField(
      textAlign: TextAlign.end,
      keyboardType: TextInputType.number,
      onChanged: (text) {
        setState(() {
          if (controller.text.isNotEmpty) {
            String firstChar = controller.text[0];
            if (firstChar == '0') {
              controller.text = text.replaceFirst(new RegExp(r'^0+'), '');
              controller.selection =
                  TextSelection.fromPosition(TextPosition(offset: 0));
            }
          }
        });
      },
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly
      ],
      style: TextStyle(
          color: Colors.white,
          fontSize: width / 8.18,
          fontWeight: FontWeight.w500,
          decoration: TextDecoration.underline),
      decoration: InputDecoration(
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
      ),
      controller: widget.controller,
    );
  }
}
