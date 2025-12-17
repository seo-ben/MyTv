import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'custom_color.dart';
import 'dimensions.dart';

class CustomStyle {
  //------------------------dark--------------------------------
  static var darkHeading1TextStyle = GoogleFonts.montserrat(
    color: CustomColor.whiteColor,
    fontSize: Dimensions.headingTextSize1,
    fontWeight: FontWeight.w700,
  );
  static var darkHeading2TextStyle = GoogleFonts.montserrat(
    color: CustomColor.whiteColor,
    fontSize: Dimensions.headingTextSize2,
    fontWeight: FontWeight.w700,
  );
  static var darkHeading3TextStyle = GoogleFonts.montserrat(
    color: CustomColor.whiteColor,
    fontSize: Dimensions.headingTextSize3,
    fontWeight: FontWeight.w700,
  );
  static var darkHeading4TextStyle = GoogleFonts.montserrat(
    color: CustomColor.whiteColor.withValues(alpha: 0.6),
    fontSize: Dimensions.headingTextSize4,
    fontWeight: FontWeight.w400,
  );
  static var darkHeading5TextStyle = GoogleFonts.montserrat(
    color: CustomColor.whiteColor,
    fontSize: Dimensions.headingTextSize5,
    fontWeight: FontWeight.w400,
  );

  //------------------------light--------------------------------
  static var lightHeading1TextStyle = GoogleFonts.montserrat(
    color: CustomColor.primaryLightTextColor,
    fontSize: Dimensions.headingTextSize1,
    fontWeight: FontWeight.w700,
  );
  static var lightHeading2TextStyle = GoogleFonts.montserrat(
    color: CustomColor.primaryLightTextColor,
    fontSize: Dimensions.headingTextSize2,
    fontWeight: FontWeight.w700,
  );
  static var lightHeading3TextStyle = GoogleFonts.montserrat(
    color: CustomColor.primaryLightTextColor,
    fontSize: Dimensions.headingTextSize3,
    fontWeight: FontWeight.w700,
  );
  static var lightHeading4TextStyle = GoogleFonts.montserrat(
    color: CustomColor.primaryLightTextColor,
    fontSize: Dimensions.headingTextSize4,
    fontWeight: FontWeight.w400,
  );
  static var lightHeading5TextStyle = GoogleFonts.montserrat(
    color: CustomColor.primaryLightTextColor,
    fontSize: Dimensions.headingTextSize5,
    fontWeight: FontWeight.w400,
  );

  static var screenGradientBG2 = const BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [CustomColor.primaryDarkColor, CustomColor.primaryBGDarkColor],
    ),
  );

  static var onboardTitleStyle = GoogleFonts.montserrat(
    textStyle: TextStyle(
      color: CustomColor.primaryLightTextColor,
      fontSize: Dimensions.headingTextSize2,
      fontWeight: FontWeight.w900,
    ),
  );

  static var onboardSubTitleStyle = GoogleFonts.montserrat(
    textStyle: TextStyle(
      color: CustomColor.primaryLightTextColor.withValues(alpha: 0.6),
      fontSize: Dimensions.headingTextSize4 * 0.9,
      fontWeight: FontWeight.w400,
    ),
  );

  static var onboardSkipStyle = GoogleFonts.montserrat(
    textStyle: TextStyle(
      color: CustomColor.primaryLightTextColor,
      fontSize: Dimensions.headingTextSize5,
      fontWeight: FontWeight.w500,
    ),
  );
  static var signInInfoTitleStyle = GoogleFonts.montserrat(
    textStyle: TextStyle(
      color: CustomColor.primaryLightTextColor,
      fontSize: Dimensions.headingTextSize2,
      fontWeight: FontWeight.w700,
    ),
  );
  static var signInInfoSubTitleStyle = GoogleFonts.montserrat(
    textStyle: TextStyle(
      color: CustomColor.primaryLightTextColor,
      fontSize: Dimensions.headingTextSize4,
      fontWeight: FontWeight.w400,
    ),
  );
  static var f20w600pri = GoogleFonts.montserrat(
    textStyle: GoogleFonts.montserrat(
      color: CustomColor.primaryLightTextColor,
      fontSize: Dimensions.headingTextSize2,
      fontWeight: FontWeight.w600,
    ),
  );
  static var labelTextStyle = GoogleFonts.montserrat(
    textStyle: GoogleFonts.montserrat(
      fontWeight: FontWeight.w600,
      color: CustomColor.primaryLightColor,
      fontSize: Dimensions.headingTextSize4,
    ),
  );

  static var whiteTextStyle = TextStyle(
    color: CustomColor.whiteColor,
    fontSize: Dimensions.headingTextSize3,
    fontWeight: FontWeight.w500,
  );

  static var statusTextStyle = TextStyle(
    fontSize: Dimensions.headingTextSize6,
    fontWeight: FontWeight.w600,
  );

  static var yellowTextStyle = TextStyle(
    color: CustomColor.yellowColor,
    fontSize: Dimensions.headingTextSize6,
    fontWeight: FontWeight.w600,
  );
  static var premiumGradient = const BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        CustomColor.secondaryDarkColor,
        CustomColor.primaryDarkColor,
        CustomColor.primaryBGDarkColor,
      ],
    ),
  );

  static var glassBoxDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(Dimensions.radius * 2),
    color: Colors.white.withOpacity(0.05),
    border: Border.all(color: Colors.white.withOpacity(0.1), width: 1.5),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.1),
        blurRadius: 20,
        spreadRadius: 5,
      ),
    ],
  );
}
