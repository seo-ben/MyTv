import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:MyTelevision/language/language_controller.dart';

import '../../language/strings.dart';
import '../../utils/custom_color.dart';
import '../../utils/custom_style.dart';
import '../../utils/dimensions.dart';

// ignore: must_be_immutable
class PrimaryInputWidget extends StatefulWidget {
  final String hint, icon, label;
  final int maxLines;
  final bool isValidator;
  final EdgeInsetsGeometry? paddings;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final ValueChanged? onChanged;
  final ValueChanged? onFieldSubmitted;
  final bool? readOnly;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final String? optionalLabel;
  final double? radius;
  void Function()? onTab;
  TextInputAction? textInputAction;
  final FocusNode? focusNode;

  PrimaryInputWidget({
    super.key,
    required this.controller,
    required this.hint,
    this.icon = "",
    this.isValidator = true,
    this.maxLines = 1,
    this.paddings,
    required this.label,
    this.keyboardType,
    this.inputFormatters,
    this.onChanged,
    this.onFieldSubmitted,
    this.readOnly,
    this.suffixIcon,
    this.prefixIcon,
    this.optionalLabel,
    this.onTab,
    this.textInputAction,
    this.radius,
    this.focusNode,
  });

  @override
  State<PrimaryInputWidget> createState() => _PrimaryInputWidgetState();
}

class _PrimaryInputWidgetState extends State<PrimaryInputWidget> {
  FocusNode? internalFocusNode;

  @override
  void initState() {
    super.initState();
    internalFocusNode = widget.focusNode ?? FocusNode();
  }

  @override
  void dispose() {
    if (widget.focusNode == null) {
      internalFocusNode!.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isFieldSubmit = false;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextSelectionTheme(
          data: const TextSelectionThemeData(
            cursorColor: CustomColor.primaryLightColor,
            selectionColor: CustomColor.primaryLightColor,
            selectionHandleColor: CustomColor.primaryLightColor,
          ),
          child: TextFormField(
            cursorColor: CustomColor.primaryLightColor,
            magnifierConfiguration: const TextMagnifierConfiguration(
              shouldDisplayHandlesInMagnifier: true,
            ),

            readOnly: widget.readOnly ?? false,
            validator: widget.isValidator == false
                ? null
                : (String? value) {
                    if (value!.isEmpty) {
                      return Get.find<LanguageController>().getTranslation(
                        Strings.pleaseFillOutTheField,
                      );
                    } else {
                      return null;
                    }
                  },
            textInputAction: widget.textInputAction ?? TextInputAction.next,
            controller: widget.controller,
            onTap:
                widget.onTab ??
                () {
                  setState(() {
                    internalFocusNode!.requestFocus();
                    isFieldSubmit = true;
                  });
                },
            onFieldSubmitted:
                widget.onFieldSubmitted ??
                (value) {
                  setState(() {
                    internalFocusNode!.unfocus();
                    isFieldSubmit = true;
                  });
                },
            onTapOutside: (value) {
              setState(() {
                internalFocusNode!.unfocus();
              });
            },
            onEditingComplete: () {
              setState(() {
                internalFocusNode!.unfocus();
              });
            },
            autovalidateMode: AutovalidateMode.disabled,
            onChanged: widget.onChanged,
            focusNode: internalFocusNode, // Use the assigned focus node
            style: Get.isDarkMode
                ? CustomStyle.darkHeading3TextStyle
                : CustomStyle.lightHeading3TextStyle,
            keyboardType: widget.keyboardType,
            inputFormatters: widget.inputFormatters,
            maxLines: widget.maxLines,
            decoration: InputDecoration(
              hintText: Get.find<LanguageController>().getTranslation(
                widget.hint,
              ),
              labelText: widget.controller.text.isEmpty && !isFieldSubmit
                  ? Get.find<LanguageController>().getTranslation(widget.label)
                  : internalFocusNode!.hasFocus
                  ? Get.find<LanguageController>().getTranslation(widget.label)
                  : Get.find<LanguageController>().getTranslation(widget.label),
              floatingLabelBehavior: FloatingLabelBehavior.auto,
              labelStyle: internalFocusNode!.hasFocus
                  ? CustomStyle.lightHeading3TextStyle.copyWith(
                      color: CustomColor.primaryLightColor,
                    )
                  : CustomStyle.lightHeading3TextStyle.copyWith(
                      color: CustomColor.primaryLightTextColor.withValues(
                        alpha: .20,
                      ),
                    ),
              hintStyle: GoogleFonts.inter(
                fontSize: Dimensions.headingTextSize3,
                fontWeight: FontWeight.w500,
                color: Get.isDarkMode
                    ? CustomColor.primaryDarkTextColor.withValues(alpha: 0.2)
                    : CustomColor.primaryLightTextColor.withValues(alpha: 0.2),
              ),
              border: UnderlineInputBorder(
                borderRadius: BorderRadius.circular(
                  widget.radius ?? Dimensions.radius * 0.0,
                ),
                borderSide: BorderSide(
                  color: internalFocusNode!.hasFocus
                      ? CustomColor.primaryLightColor
                      : CustomColor.whiteColor.withValues(alpha: .20),
                ),
              ),
              enabledBorder: UnderlineInputBorder(
                borderRadius: BorderRadius.circular(
                  widget.radius ?? Dimensions.radius * 0.0,
                ),
                borderSide: BorderSide(
                  color: internalFocusNode!.hasFocus
                      ? CustomColor.primaryLightColor
                      : CustomColor.whiteColor.withValues(alpha: .20),
                ),
              ),
              focusedBorder: UnderlineInputBorder(
                borderRadius: BorderRadius.circular(
                  widget.radius ?? Dimensions.radius * 0.0,
                ),
                borderSide: const BorderSide(
                  width: 2,
                  color: CustomColor.primaryLightColor,
                ),
              ),
              contentPadding: EdgeInsets.symmetric(
                vertical: Dimensions.heightSize,
              ),
              prefixIcon: widget.prefixIcon,
            ),
          ),
        ),
      ],
    );
  }
}
