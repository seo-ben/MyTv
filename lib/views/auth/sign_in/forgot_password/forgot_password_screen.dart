import 'package:MyTelevision/backend/utils/custom_loading_api.dart';

import '../../../../controller/auth/sign_in/forget_password/forget_password_controller.dart';
import '../../../../utils/basic_screen_imports.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});
  final controller = Get.put(ForgetPasswordController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.primaryLightScaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: CustomColor.primaryLightScaffoldBackgroundColor,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back, color: CustomColor.whiteColor),
        ),
      ),
      body: _bodyWidget(context),
    );
  }

  _bodyWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Dimensions.widthSize * 1.5),
      child: Column(
        mainAxisAlignment: mainStart,
        children: [
          verticalSpace(Dimensions.heightSize),
          TitleHeading1Widget(text: Strings.resetYourForgottenPassword),
          verticalSpace(Dimensions.heightSize * .5),
          TitleHeading4Widget(text: Strings.resetYourForgottenPasswordInfo),
          verticalSpace(Dimensions.heightSize * .5),
          PrimaryInputWidget(
            controller: controller.emailController,
            hint: Strings.enterEmailAddress,
            label: Strings.emailAddress,
          ),
          verticalSpace(Dimensions.heightSize * 2),
          _buttonWidget(context),
        ],
      ),
    );
  }

  _buttonWidget(BuildContext context) {
    return Obx(
      () => controller.isForgotPasswordLoading
          ? const CustomLoadingAPI()
          : PrimaryButton(
              title: Strings.sendOtp,
              onPressed: () {
                controller.forgotPasswordProcess();
              },
            ),
    );
  }
}
