import 'package:MyTelevision/language/language_controller.dart';

import '../../../backend/utils/custom_loading_api.dart';
import '../../../controller/auth/sign_in/forget_password/forget_password_controller.dart';
import '../../../utils/basic_screen_imports.dart';
import '../../../widgets/inputs/otp_input_widget.dart';

class ForgetPasswordOtpScreen extends StatelessWidget {
  ForgetPasswordOtpScreen({super.key});
  final controller = Get.put(ForgetPasswordController());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColor.primaryLightScaffoldBackgroundColor,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back, color: CustomColor.whiteColor),
        ),
      ),
      backgroundColor: CustomColor.primaryLightScaffoldBackgroundColor,
      body: _bodyWidget(context),
    );
  }

  _bodyWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Dimensions.widthSize * 1.5),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: mainStart,
          crossAxisAlignment: crossStart,
          children: [
            verticalSpace(Dimensions.heightSize * 2),
            TitleHeading1Widget(text: Strings.pleaseEnterTheCode),
            verticalSpace(Dimensions.heightSize * .5),
            TitleHeading4Widget(
              text:
                  "${Get.find<LanguageController>().getTranslation(Strings.sentCode)} ${controller.emailController.text}",
            ),
            verticalSpace(Dimensions.heightSize),
            OtpInputTextFieldWidget(controller: controller.otpController),
            verticalSpace(Dimensions.heightSize * .5),
            Row(
              children: [
                TitleHeading4Widget(text: Strings.youCanSendTheCodeAfter),
                SizedBox(width: 5.w),
                Obx(
                  () => TitleHeading4Widget(
                    text:
                        '0${controller.minuteRemaining.value}:${controller.secondsRemaining.value}',
                    color: CustomColor.primaryLightColor,
                  ),
                ),
              ],
            ),
            verticalSpace(Dimensions.heightSize * 2),
            _buttonWidget(context),
            verticalSpace(Dimensions.heightSize),
            _resendButton(context),
          ],
        ),
      ),
    );
  }

  _buttonWidget(BuildContext context) {
    return Obx(
      () => controller.isLoading
          ? const CustomLoadingAPI()
          : PrimaryButton(
              title: Strings.submit,
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  controller.otpVerifyProcess();
                }
              },
            ),
    );
  }

  _resendButton(BuildContext context) {
    return Obx(
      () => Center(
        child: Visibility(
          visible: controller.enableResend.value,
          child: Obx(
            () => controller.isOtpResendLoading
                ? const CustomLoadingAPI()
                : InkWell(
                    onTap: () {
                      controller.resendCode();
                    },
                    child: CustomTitleHeadingWidget(
                      text: Strings.resendCode,
                      style: const TextStyle(
                        color: CustomColor.primaryLightColor,
                      ),
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
