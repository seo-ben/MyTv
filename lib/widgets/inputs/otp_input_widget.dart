import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../language/strings.dart';
import '../../utils/custom_color.dart';
import '../../utils/dimensions.dart';

class OtpInputTextFieldWidget extends StatelessWidget {
  const OtpInputTextFieldWidget({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      controller: controller,
      appContext: context,
      cursorColor: CustomColor.primaryLightTextColor,
      length: 6,
      obscureText: false,
      keyboardType: TextInputType.number,
      validator: (String? value) {
        if (value!.isEmpty) {
          return Strings.pleaseFillOutTheField;
        } else {
          return null;
        }
      },
      textStyle: const TextStyle(color: CustomColor.primaryLightTextColor),
      animationType: AnimationType.fade,
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(
          Dimensions.radius,
        ),
        selectedColor: CustomColor.primaryLightTextColor,
        activeColor: CustomColor.primaryLightTextColor,
        inactiveColor: CustomColor.primaryLightTextColor,
        fieldHeight: 52.h,
        fieldWidth: 47.w,
        activeFillColor: CustomColor.transparent,
        borderWidth: 1,
      ),
      onChanged: (String value) {},
    );
  }
}
