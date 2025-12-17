// import 'package:flutter/services.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// import '../../utils/basic_screen_imports.dart';
//
// class PasswordInputWidget extends StatefulWidget {
//   final String hint, icon, label;
//   final int maxLines;
//   final bool isValidator;
//   final EdgeInsetsGeometry? paddings;
//   final TextEditingController controller;
//   final double? radius;
//   final ValueChanged? onChanged;
//   final ValueChanged? onFieldSubmitted;
//   final bool? readOnly;
//   final TextInputType? keyboardType;
//   final List<TextInputFormatter>? inputFormatters;
//   final Widget? suffixIcon;
//   final Widget? prefixIcon;
//
//   const PasswordInputWidget({
//     super.key,
//     required this.controller,
//     required this.hint,
//     this.icon = "",
//     this.isValidator = true,
//     this.maxLines = 1,
//     this.paddings,
//     required this.label,
//     this.radius,
//     this.onChanged,
//     this.onFieldSubmitted,
//     this.readOnly,
//     this.keyboardType,
//     this.inputFormatters,
//     this.suffixIcon,
//     this.prefixIcon,
//   });
//
//   @override
//   State<PasswordInputWidget> createState() => _PrimaryInputWidgetState();
// }
//
// class _PrimaryInputWidgetState extends State<PasswordInputWidget> {
//   FocusNode? focusNode;
//   bool obscureText = true;
//
//   @override
//   void initState() {
//     super.initState();
//     focusNode = FocusNode();
//   }
//
//   @override
//   void dispose() {
//     focusNode!.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     bool isFieldSubmit = false;
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.start,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         TextSelectionTheme(
//           data: const TextSelectionThemeData(
//               cursorColor: CustomColor.primaryLightColor,
//               selectionColor: CustomColor.primaryLightColor,
//               selectionHandleColor: CustomColor.primaryLightColor),
//           child: TextFormField(
//             cursorColor: CustomColor.primaryLightColor,
//             readOnly: widget.readOnly ?? false,
//             validator: widget.isValidator == false
//                 ? null
//                 : (String? value) {
//                     if (value!.isEmpty) {
//                       return Strings.pleaseFillOutTheField;
//                     } else {
//                       return null;
//                     }
//                   },
//             textInputAction: TextInputAction.next,
//             controller: widget.controller,
//             onTap: () {
//               setState(() {
//                 focusNode!.requestFocus();
//                 isFieldSubmit = true;
//               });
//             },
//             onFieldSubmitted: widget.onFieldSubmitted ??
//                 (value) {
//                   setState(() {
//                     focusNode!.unfocus();
//                     isFieldSubmit = true;
//                   });
//                 },
//             onTapOutside: (value) {
//               setState(() {
//                 focusNode!.unfocus();
//               });
//             },
//             onEditingComplete: () {
//               setState(() {
//                 focusNode!.unfocus();
//               });
//             },
//             onChanged: widget.onChanged,
//             obscureText: obscureText,
//             focusNode: focusNode,
//             style: Get.isDarkMode
//                 ? CustomStyle.darkHeading3TextStyle
//                 : CustomStyle.lightHeading3TextStyle,
//             keyboardType: widget.keyboardType,
//             inputFormatters: widget.inputFormatters,
//             maxLines: widget.maxLines,
//             decoration: InputDecoration(
//               hintText: widget.hint,
//               labelText: widget.controller.text.isEmpty && !isFieldSubmit
//                   ? widget.label
//                   : focusNode!.hasFocus
//                       ? widget.label
//                       : "",
//               floatingLabelBehavior: FloatingLabelBehavior.auto,
//               labelStyle: focusNode!.hasFocus
//                   ? CustomStyle.lightHeading3TextStyle
//                       .copyWith(color: CustomColor.primaryLightColor)
//                   : CustomStyle.lightHeading3TextStyle.copyWith(
//                       color: CustomColor.primaryLightTextColor.withValues(alpha: .20),
//                     ),
//               hintStyle: GoogleFonts.inter(
//                 fontSize: Dimensions.headingTextSize3,
//                 fontWeight: FontWeight.w500,
//                 color: Get.isDarkMode
//                     ? CustomColor.primaryDarkTextColor.withValues(alpha: 0.2)
//                     : CustomColor.primaryLightTextColor.withValues(alpha: 0.2),
//               ),
//               border: UnderlineInputBorder(
//                 borderRadius: BorderRadius.circular(
//                     widget.radius ?? Dimensions.radius * 0.0),
//                 borderSide: BorderSide(
//                   color: focusNode!.hasFocus
//                       ? CustomColor.primaryLightColor
//                       : CustomColor.whiteColor.withValues(alpha: .20),
//                 ),
//               ),
//               enabledBorder: UnderlineInputBorder(
//                 borderRadius: BorderRadius.circular(
//                     widget.radius ?? Dimensions.radius * 0.0),
//                 borderSide: BorderSide(
//                   color: focusNode!.hasFocus
//                       ? CustomColor.primaryLightColor
//                       : CustomColor.whiteColor.withValues(alpha: .20),
//                 ),
//               ),
//               focusedBorder: UnderlineInputBorder(
//                 borderRadius: BorderRadius.circular(
//                     widget.radius ?? Dimensions.radius * 0.0),
//                 borderSide: const BorderSide(
//                   width: 2,
//                   color: CustomColor.primaryLightColor,
//                 ),
//               ),
//               contentPadding: EdgeInsets.symmetric(
//                 // horizontal: Dimensions.widthSize * 1.7,
//                 vertical: Dimensions.heightSize,
//               ),
//               prefixIcon: widget.prefixIcon,
//               suffixIcon: GestureDetector(
//                 onTap: () {
//                   setState(() {
//                     obscureText = !obscureText;
//                   });
//                 },
//                 child: Icon(
//                   obscureText ? Icons.visibility_off : Icons.visibility,
//                   color: focusNode!.hasFocus
//                       ? CustomColor.primaryLightColor
//                       : Get.isDarkMode
//                           ? CustomColor.primaryDarkTextColor.withValues(alpha: 0.2)
//                           : CustomColor.primaryLightTextColor.withValues(alpha: 0.2),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../language/language_controller.dart';
import '../../language/strings.dart';
import '../../utils/custom_color.dart';
import '../../utils/custom_style.dart';
import '../../utils/dimensions.dart';

class PasswordInputWidget extends StatefulWidget {
  final String hint, icon, label;
  final int maxLines;
  final bool isValidator;
  final EdgeInsetsGeometry? paddings;
  final TextEditingController controller;
  final double? radius;
  final ValueChanged? onChanged;
  final ValueChanged? onFieldSubmitted;
  final bool? readOnly;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode; // New FocusNode parameter

  const PasswordInputWidget({
    super.key,
    required this.controller,
    required this.hint,
    this.icon = "",
    this.isValidator = true,
    this.maxLines = 1,
    this.paddings,
    required this.label,
    this.radius,
    this.onChanged,
    this.onFieldSubmitted,
    this.readOnly,
    this.keyboardType,
    this.inputFormatters,
    this.suffixIcon,
    this.prefixIcon,
    this.textInputAction = TextInputAction.next,
    this.focusNode, // Accept external FocusNode
  });

  @override
  State<PasswordInputWidget> createState() => _PasswordInputWidgetState();
}

class _PasswordInputWidgetState extends State<PasswordInputWidget> {
  FocusNode? internalFocusNode; // Local focus node
  bool obscureText = true;

  @override
  void initState() {
    super.initState();
    internalFocusNode =
        widget.focusNode ?? FocusNode(); // Use external or create a new one
  }

  @override
  void dispose() {
    if (widget.focusNode == null) {
      internalFocusNode!.dispose(); // Dispose if created internally
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
            readOnly: widget.readOnly ?? false,
            validator: (String? value) {
              if (value!.isEmpty) {
                return Strings.pleaseFillOutTheField;
              } else {
                return null;
              }
            },
            textInputAction: widget.textInputAction,
            controller: widget.controller,
            onTap: () {
              setState(() {
                internalFocusNode!.requestFocus();
                isFieldSubmit = true;
              });
            },
            onFieldSubmitted: widget.onFieldSubmitted ??
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
            onChanged: widget.onChanged,
            obscureText: obscureText,
            focusNode: internalFocusNode, // Use the assigned focus node
            style: Get.isDarkMode
                ? CustomStyle.darkHeading3TextStyle
                : CustomStyle.lightHeading3TextStyle,
            keyboardType: widget.keyboardType,
            inputFormatters: widget.inputFormatters,
            maxLines: widget.maxLines,
            decoration: InputDecoration(
              hintText:
                  Get.find<LanguageController>().getTranslation(widget.hint),
              labelText: widget.controller.text.isEmpty && !isFieldSubmit
                  ? Get.find<LanguageController>().getTranslation(widget.label)
                  : internalFocusNode!.hasFocus
                      ? Get.find<LanguageController>()
                          .getTranslation(widget.label)
                      : Get.find<LanguageController>()
                          .getTranslation(widget.label),
              floatingLabelBehavior: FloatingLabelBehavior.auto,
              labelStyle: internalFocusNode!.hasFocus
                  ? CustomStyle.lightHeading3TextStyle
                      .copyWith(color: CustomColor.primaryLightColor)
                  : CustomStyle.lightHeading3TextStyle.copyWith(
                      color: CustomColor.primaryLightTextColor.withValues(alpha: .20),
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
                    widget.radius ?? Dimensions.radius * 0.0),
                borderSide: BorderSide(
                  color: internalFocusNode!.hasFocus
                      ? CustomColor.primaryLightColor
                      : CustomColor.whiteColor.withValues(alpha: .20),
                ),
              ),
              enabledBorder: UnderlineInputBorder(
                borderRadius: BorderRadius.circular(
                    widget.radius ?? Dimensions.radius * 0.0),
                borderSide: BorderSide(
                  color: internalFocusNode!.hasFocus
                      ? CustomColor.primaryLightColor
                      : CustomColor.whiteColor.withValues(alpha: .20),
                ),
              ),
              focusedBorder: UnderlineInputBorder(
                borderRadius: BorderRadius.circular(
                    widget.radius ?? Dimensions.radius * 0.0),
                borderSide: const BorderSide(
                  width: 2,
                  color: CustomColor.primaryLightColor,
                ),
              ),
              contentPadding: EdgeInsets.symmetric(
                vertical: Dimensions.heightSize,
              ),
              prefixIcon: widget.prefixIcon,
              suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    obscureText = !obscureText;
                  });
                },
                child: Icon(
                  obscureText ? Icons.visibility_off : Icons.visibility,
                  color: internalFocusNode!.hasFocus
                      ? CustomColor.primaryLightColor
                      : Get.isDarkMode
                          ? CustomColor.primaryDarkTextColor.withValues(alpha: 0.2)
                          : CustomColor.primaryLightTextColor.withValues(alpha: 0.2),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
