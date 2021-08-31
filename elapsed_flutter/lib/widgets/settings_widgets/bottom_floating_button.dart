import 'package:flutter/material.dart';

class BottomFloatingButton extends StatelessWidget {
  final Widget child;
  final double width;
  final Color foregroundColor;
  final VoidCallback onTap;
  const BottomFloatingButton({
    Key? key,
    required this.child,
    required this.width,
    this.foregroundColor = const Color(0xFF424242),
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: width / 13,
      width: width * 0.86,
      child: GestureDetector(
        child: Container(
          height: width / 8,
          decoration: BoxDecoration(
            color: foregroundColor,
            borderRadius: BorderRadius.circular(3),
          ),
          child: Center(
            child: child,
          ),
        ),
        onTap: () {
          onTap();
        },
      ),
    );
  }
}
