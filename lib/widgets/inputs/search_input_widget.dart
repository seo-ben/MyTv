import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/basic_screen_imports.dart';

class SearchInputWidget extends StatefulWidget {
  const SearchInputWidget({
    super.key,
    required this.controller,
    required this.hint,
    this.icon = "",
    this.isValidator = true,
    this.maxLines = 1,
    this.paddings,
    this.keyboardType,
    this.inputFormatters,
    this.onChanged,
    this.onFieldSubmitted,
    this.readOnly,
    this.suffixIcon,
    this.prefixIcon,
    this.optionalLabel,
    this.radius,
  });
  final String hint, icon;
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

  @override
  State<SearchInputWidget> createState() => _SearchInputWidgetState();
}

class _SearchInputWidgetState extends State<SearchInputWidget> {
  FocusNode? focusNode;

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
  }

  @override
  void dispose() {
    focusNode!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 51.h,
      child: TextSelectionTheme(
        data: const TextSelectionThemeData(
            cursorColor: CustomColor.primaryLightColor,
            selectionColor: CustomColor.primaryLightColor,
            selectionHandleColor: CustomColor.primaryLightColor),
        child: TextFormField(
          cursorColor: CustomColor.primaryLightColor,
          readOnly: widget.readOnly ?? false,
          validator: widget.isValidator == false
              ? null
              : (String? value) {
                  if (value!.isEmpty) {
                    return Strings.pleaseFillOutTheField;
                  } else {
                    return null;
                  }
                },
          textInputAction: TextInputAction.none,
          controller: widget.controller,
          onTap: () {
            setState(() {
              focusNode!.requestFocus();
            });
          },
          onFieldSubmitted: widget.onFieldSubmitted ??
              (value) {
                setState(() {
                  focusNode!.unfocus();
                });
              },
          onTapOutside: (value) {
            setState(() {
              focusNode!.unfocus();
            });
          },
          onEditingComplete: () {
            setState(() {
              focusNode!.unfocus();
            });
          },
          onChanged: widget.onChanged,
          focusNode: focusNode,
          style: Get.isDarkMode
              ? CustomStyle.darkHeading3TextStyle
              : CustomStyle.lightHeading3TextStyle,
          keyboardType: widget.keyboardType,
          inputFormatters: widget.inputFormatters,
          maxLines: widget.maxLines,
          decoration: InputDecoration(
            hintText: widget.hint,
            hintStyle: GoogleFonts.inter(
              fontSize: Dimensions.headingTextSize3,
              fontWeight: FontWeight.w500,
              color: Get.isDarkMode
                  ? CustomColor.primaryDarkTextColor.withValues(alpha: 0.2)
                  : CustomColor.primaryLightTextColor.withValues(alpha: 0.2),
            ),
            border: OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(widget.radius ?? Dimensions.radius * 3),
              borderSide: BorderSide(
                color: focusNode!.hasFocus
                    ? CustomColor.primaryLightColor
                    : CustomColor.whiteColor.withValues(alpha: .20),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(widget.radius ?? Dimensions.radius * 3),
              borderSide: BorderSide(
                color: focusNode!.hasFocus
                    ? CustomColor.primaryLightColor
                    : CustomColor.whiteColor.withValues(alpha: .20),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(widget.radius ?? Dimensions.radius * 3),
              borderSide: const BorderSide(
                width: 2,
                color: CustomColor.primaryLightColor,
              ),
            ),
            fillColor: CustomColor.boxColor.withValues(alpha: .5),
            filled: true,
            contentPadding: EdgeInsets.symmetric(
              horizontal: Dimensions.widthSize * 2,
            ),
            prefixIcon: widget.prefixIcon,
          ),
        ),
      ),
    );
  }
}
