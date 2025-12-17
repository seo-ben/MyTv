import 'package:flutter/material.dart';

import '../../utils/custom_color.dart';
import '../../utils/dimensions.dart';
import '../text_labels/title_heading3_widget.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.borderColor = CustomColor.primaryLightColor,
    this.borderWidth = 0,
    this.height,
    this.buttonColor = CustomColor.primaryLightColor,
    this.buttonTextColor = Colors.white,
    this.shape,
    this.icon,
    this.fontSize,
    this.fontWeight,
    this.disable = false,
  });
  final String title;
  final VoidCallback onPressed;
  final Color? borderColor;
  final double borderWidth;
  final double? height;
  final Color? buttonColor;
  final Color buttonTextColor;
  final OutlinedBorder? shape;
  final Widget? icon;
  final double? fontSize;
  final FontWeight? fontWeight;
  final bool disable;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? Dimensions.buttonHeight * .75,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: shape ??
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Dimensions.radius)),
          backgroundColor: buttonColor,
          foregroundColor: CustomColor.primaryLightColor,
          side: BorderSide(
            width: borderWidth,
            color: borderColor!,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon ?? const SizedBox(),
            TitleHeading3Widget(
              text: title,
              fontWeight: FontWeight.w700,
              color: CustomColor.whiteColor,
            ),
          ],
        ),
      ),
    );
  }
}
