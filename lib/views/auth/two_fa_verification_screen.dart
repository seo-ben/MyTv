import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:MyTelevision/utils/basic_screen_imports.dart';

import '../../../../backend/utils/custom_loading_api.dart';
import '../../../widgets/text_labels/title_subtitle_widget.dart';
import '../../controller/auth/two_fa/two_fa_verification_controller.dart';

class TwoFaOtpVerificationScreenMobile extends StatelessWidget {
  TwoFaOtpVerificationScreenMobile({super.key});

  final controller = Get.put(TwoFaOtpVerificationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TitleHeading2Widget(text: Strings.twoFaVerification),
      ),
      body: _bodyWidget(context),
    );
  }

  _bodyWidget(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: crossCenter,
        children: [
          // _appLogoWidget(context),
          verticalSpace(Dimensions.heightSize * 2),
          _otpWidget(context),
        ],
      ),
    );
  }

  _buttonWidget(context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: Dimensions.marginSizeVertical),
      child: Obx(
        () => controller.isLoading
            ? const CustomLoadingAPI()
            : PrimaryButton(
                title: Strings.submit,
                onPressed: () {
                  controller.onSubmit;
                },
              ),
      ),
    );
  }

  // _appLogoWidget(BuildContext context) {
  //   return Center(child: Image.network(LocalStorage.getLogoImage()));
  // }

  _otpWidget(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: Dimensions.marginSizeHorizontal * 0.8,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(Dimensions.radius * 4),
          topRight: Radius.circular(Dimensions.radius * 4),
        ),
      ),
      child: Column(
        children: [
          const TitleSubTitleWidget(
            title: Strings.twoFactorAuthorization,
            subtitle: Strings.enterTheTwoFaVerification,
          ),
          _otpInputWidget(context),
          _buttonWidget(context),
        ],
      ),
    );
  }

  _otpInputWidget(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: Dimensions.heightSize * 1.5),
      child: Form(
        //key: twoFaOtpFormKey,
        child: PinCodeTextField(
          appContext: context,
          backgroundColor: Colors.transparent,
          textStyle: Get.isDarkMode
              ? CustomStyle.darkHeading2TextStyle
              : CustomStyle.lightHeading2TextStyle,
          enableActiveFill: true,
          pastedTextStyle: TextStyle(
            color: Colors.orange.shade600,
            fontWeight: FontWeight.bold,
          ),
          length: 6,
          obscureText: false,
          blinkWhenObscuring: true,
          animationType: AnimationType.fade,
          validator: (v) {
            if (v!.length < 3) {
              return Strings.pleaseFillOutTheField;
            } else {
              return null;
            }
          },
          pinTheme: PinTheme(
            shape: PinCodeFieldShape.box,
            fieldHeight: 48,
            fieldWidth: 50,
            inactiveColor: CustomColor.primaryLightColor,
            activeColor: CustomColor.primaryLightColor,
            selectedColor: Colors.transparent,
            inactiveFillColor: CustomColor.primaryLightColor,
            activeFillColor: CustomColor.primaryLightColor,
            selectedFillColor: CustomColor.primaryLightColor,
            borderRadius: BorderRadius.circular(Dimensions.radius * 0.5),
          ),
          cursorColor: CustomColor.whiteColor,
          animationDuration: const Duration(milliseconds: 300),
          errorAnimationController: controller.errorController,
          controller: controller.pinCodeController,
          keyboardType: TextInputType.number,
          onCompleted: (v) {},
          onChanged: (value) {
            controller.changeCurrentText(value);
          },
          beforeTextPaste: (text) {
            return true;
          },
        ),
      ),
    );
  }
}
