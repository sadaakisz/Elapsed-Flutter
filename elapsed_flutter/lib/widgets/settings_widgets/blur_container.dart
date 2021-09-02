import 'dart:ui';

import 'package:flutter/material.dart';

class BlurContainer extends StatelessWidget {
  final double borderRadius;
  final double blurStrength;
  const BlurContainer({Key? key, this.borderRadius = 5, this.blurStrength = 3})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blurStrength, sigmaY: blurStrength),
        child: Container(
          color: Colors.white.withOpacity(0.07),
        ),
      ),
    );
  }
}
