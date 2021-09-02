import 'package:elapsed_flutter/colors/elapsed_colors.dart';
import 'package:elapsed_flutter/utils/custom_navigator.dart';
import 'package:elapsed_flutter/widgets/settings_widgets/blur_container.dart';
import 'package:flutter/material.dart';

class BottomFloatingButton extends StatelessWidget {
  final Widget child;
  final double width;
  final Color foregroundColor;
  final VoidCallback onTap;
  final bool backButton;
  const BottomFloatingButton({
    Key? key,
    required this.child,
    required this.width,
    this.foregroundColor = const Color(0xFF424242),
    required this.onTap,
    this.backButton = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: width / 13,
      width: width * 0.86,
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              child: Container(
                height: width / 8,
                decoration: BoxDecoration(
                  color: foregroundColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(3),
                ),
                child: Stack(
                  children: [
                    BlurContainer(
                      borderRadius: 3,
                      blurStrength: 7,
                    ),
                    Center(
                      child: child,
                    ),
                  ],
                ),
              ),
              onTap: () {
                onTap();
              },
            ),
          ),
          backButton ? SizedBox(width: width / 20) : SizedBox(),
          backButton
              ? GestureDetector(
                  onTap: () => navPop(context),
                  child: Container(
                    width: width / 8,
                    height: width / 8,
                    decoration: BoxDecoration(
                      color: foregroundColor.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        BlurContainer(
                          borderRadius: 3,
                          blurStrength: 7,
                        ),
                        Icon(
                          Icons.clear,
                          color: EColors.red,
                        ),
                      ],
                    ),
                  ),
                )
              : SizedBox(),
        ],
      ),
    );
  }
}
