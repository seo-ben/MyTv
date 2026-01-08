import '/backend/utils/custom_loading_api.dart';
import '/language/language_controller.dart';
import '../../../controller/auth/sign_up/sign_up_otp/sign_up_otp_controller.dart';
import '../../../utils/basic_screen_imports.dart';
import '../../../widgets/inputs/otp_input_widget.dart';

class SignUpOtpScreen extends StatelessWidget {
  SignUpOtpScreen({super.key});
  final controller = Get.put(SignUpOtpController());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColor.primaryLightScaffoldBackgroundColor,
        automaticallyImplyLeading: true,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: CustomColor.whiteColor,
          ),
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
            verticalSpace(Dimensions.heightSize * 3),
            TitleHeading1Widget(text: Strings.pleaseEnterTheCode),
            verticalSpace(Dimensions.heightSize * .5),
            TitleHeading4Widget(
              text:
                  "${Get.find<LanguageController>().getTranslation(Strings.sentCode)} ${controller.emailController.text}",
            ),
            verticalSpace(Dimensions.heightSize),
            OtpInputTextFieldWidget(
              controller: controller.otpController,
            ),
            verticalSpace(Dimensions.heightSize * .5),
            Row(
              children: [
                TitleHeading4Widget(text: Strings.youCanSendTheCodeAfter),
                SizedBox(
                  width: 5.w,
                ),
                Obx(() => TitleHeading4Widget(
                      text:
                          '0${controller.minuteRemaining.value}:${controller.secondsRemaining.value}',
                      color: CustomColor.primaryLightColor,
                    ))
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
                  controller.emailOtpSubmitProcess();
                }
              },
            ),
    );
  }

  _resendButton(BuildContext context) {
    return Obx(
      () => Visibility(
        visible: controller.enableResend.value,
        child: Obx(() => controller.resendLoading
            ? const CustomLoadingAPI()
            : InkWell(
                onTap: () {
                  controller.resendCode();
                },
                child: CustomTitleHeadingWidget(
                  text: Strings.resendCode,
                  style: const TextStyle(color: CustomColor.primaryLightColor),
                ),
              )),
      ),
    );
  }
}
