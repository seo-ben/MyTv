import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../language/language_controller.dart';
import '../../utils/custom_style.dart';
import '../../utils/device_info.dart';

class TitleHeading4Widget extends StatelessWidget {
  TitleHeading4Widget({
    super.key,
    required this.text,
    this.textAlign,
    this.textOverflow,
    this.padding = paddingValue,
    this.opacity = 1.0,
    this.maxLines,
    this.fontSize,
    this.fontWeight,
    this.color,
  });

  final String text;
  final TextAlign? textAlign;
  final TextOverflow? textOverflow;
  final EdgeInsetsGeometry padding;
  final double opacity;
  final int? maxLines;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  static const paddingValue = EdgeInsets.all(0.0);
  final languageController = Get.find<LanguageController>();
  @override
  Widget build(BuildContext context) {
    // Reduce font size by 30% on TV if no custom fontSize is specified
    final double? effectiveFontSize =
        fontSize ??
        (DeviceInfo.isTv
            ? (Get.isDarkMode
                      ? CustomStyle.darkHeading4TextStyle.fontSize
                      : CustomStyle.lightHeading4TextStyle.fontSize)! *
                  0.7
            : null);

    return Obx(
      () => languageController.isLoading
          ? const Text('')
          : Opacity(
              opacity: opacity,
              child: Padding(
                padding: padding,
                child: Text(
                  languageController.getTranslation(text),
                  style: Get.isDarkMode
                      ? CustomStyle.darkHeading4TextStyle.copyWith(
                          fontSize: effectiveFontSize,
                          fontWeight: fontWeight,
                          color: color,
                        )
                      : CustomStyle.lightHeading4TextStyle.copyWith(
                          fontSize: effectiveFontSize,
                          fontWeight: fontWeight,
                          color: color,
                        ),
                  textAlign: textAlign,
                  overflow: textOverflow,
                  maxLines: maxLines,
                ),
              ),
            ),
    );
  }
}
