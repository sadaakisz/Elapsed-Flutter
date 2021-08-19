import 'dart:math';
import 'dart:ui';

import 'package:cyclop/cyclop.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

const _buttonSize = 48.0;

class CustomColorButton extends StatefulWidget {
  final Color color;
  final double? width;
  final double height;
  final BoxDecoration? decoration;
  final BoxShape boxShape;
  final ColorPickerConfig config;
  final Set<Color> swatches;

  final ValueChanged<Color> onColorChanged;

  final ValueChanged<Set<Color>>? onSwatchesChanged;

  final bool darkMode;

  const CustomColorButton({
    required this.color,
    required this.onColorChanged,
    this.onSwatchesChanged,
    this.decoration,
    this.config = const ColorPickerConfig(),
    this.darkMode = false,
    this.width = double.maxFinite,
    this.height = _buttonSize,
    this.boxShape = BoxShape.circle,
    this.swatches = const {},
    Key? key,
  }) : super(key: key);

  @override
  _CustomColorButtonState createState() => _CustomColorButtonState();
}

class _CustomColorButtonState extends State<CustomColorButton>
    with WidgetsBindingObserver {
  OverlayEntry? pickerOverlay;

  late Color color;

  bool hidden = false;

  bool keyboardOn = false;

  double bottom = 30;

  @override
  void initState() {
    super.initState();
    color = widget.color;
    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  void didUpdateWidget(CustomColorButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.color != widget.color) color = widget.color;
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTapDown: (details) => _colorPick(context, details),
        child: Container(
          width: widget.width,
          height: widget.height,
          decoration: widget.decoration ??
              BoxDecoration(
                shape: widget.boxShape,
                color: widget.color,
                border: Border.all(width: 4, color: Colors.white),
                //boxShadow: darkShadowBox,
              ),
        ),
      );

  void _colorPick(BuildContext context, TapDownDetails details) async {
    final selectedColor =
        await showColorPicker(context, details.globalPosition);
    widget.onColorChanged(selectedColor);
  }

  Future<Color> showColorPicker(BuildContext rootContext, Offset offset) async {
    if (pickerOverlay != null) return Future.value(widget.color);

    pickerOverlay = _buildPickerOverlay(offset, rootContext);

    Overlay.of(rootContext)?.insert(pickerOverlay!);

    return Future.value(widget.color);
  }

  OverlayEntry _buildPickerOverlay(Offset offset, BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    final size = MediaQuery.of(context).size;
    final left = offset.dx + pickerWidth < size.width - 30
        ? offset.dx + _buttonSize
        : offset.dx - pickerWidth - _buttonSize;
    final top = offset.dy - pickerHeight / 2 > 0
        ? min(offset.dy - pickerHeight / 2, size.height - pickerHeight - 50)
        : 50.0;

    return OverlayEntry(
      maintainState: true,
      builder: (c) {
        /*print('_ColorButtonState._buildPickerOverlay... '
            '${MediaQuery.of(context).viewInsets.bottom}');*/
        return Positioned(
          left: isPhoneScreen ? (size.width - pickerWidth) / 2 : left,
          top: isPhoneScreen
              ? (keyboardOn ? height * 0.13 : (size.height - pickerHeight) / 2)
              : top,
          bottom: isPhoneScreen ? height * 0.13 + bottom : null,
          child: IgnorePointer(
            ignoring: hidden,
            child: Opacity(
              opacity: hidden ? 0 : 1,
              child: Material(
                borderRadius: BorderRadius.circular(8),
                child: ColorPicker(
                  darkMode: widget.darkMode,
                  config: widget.config,
                  selectedColor: color,
                  swatches: widget.swatches,
                  onClose: () {
                    pickerOverlay?.remove();
                    pickerOverlay = null;
                  },
                  onColorSelected: (c) {
                    color = c;
                    pickerOverlay?.markNeedsBuild();
                    widget.onColorChanged(c);
                  },
                  onSwatchesUpdate: widget.onSwatchesChanged,
                  onEyeDropper: () => _showEyeDropperOverlay(context),
                  onKeyboard: _onKeyboardOn,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _showEyeDropperOverlay(BuildContext context) {
    hidden = true;
    try {
      EyeDrop.of(context).capture(context, (value) {
        hidden = false;
        _onEyePick(value);
      });
    } catch (err) {
      print('ERROR !!! _buildPickerOverlay $err');
    }
  }

  void _onEyePick(Color value) {
    color = value;
    widget.onColorChanged(value);
    pickerOverlay?.markNeedsBuild();
  }

  void _onKeyboardOn() {
    keyboardOn = true;
    pickerOverlay?.markNeedsBuild();
    setState(() {});
  }

  @override
  void didChangeMetrics() {
    final keyboardTopPixels =
        window.physicalSize.height - window.viewInsets.bottom;

    final newBottom = (window.physicalSize.height - keyboardTopPixels) /
        window.devicePixelRatio;

    setState(() => bottom = newBottom);
    pickerOverlay?.markNeedsBuild();
  }
}
