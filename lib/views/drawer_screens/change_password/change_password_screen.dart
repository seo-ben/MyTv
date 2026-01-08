import '/backend/utils/custom_loading_api.dart';
import '/controller/drawer/change_password/change_password_controller.dart';
import '../../../../utils/basic_screen_imports.dart';
import '../../../../widgets/inputs/password_input_widget.dart';

class ChangePasswordScreen extends StatelessWidget {
  ChangePasswordScreen({super.key});
  final controller = Get.put(ChangePasswordController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.primaryLightScaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: CustomColor.primaryLightScaffoldBackgroundColor,
        title: TitleHeading2Widget(text: Strings.changePassword),
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
      body: _bodyWidget(context),
    );
  }

  _bodyWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Dimensions.widthSize * 1.5),
      child: Column(
        mainAxisAlignment: mainStart,
        crossAxisAlignment: crossStart,
        children: [
          verticalSpace(Dimensions.heightSize * .5),
          _inputFormField(context),
          verticalSpace(Dimensions.heightSize * 2),
          _buttonWidget(context)
        ],
      ),
    );
  }

  _inputFormField(BuildContext context) {
    return Column(
      mainAxisAlignment: mainEnd,
      crossAxisAlignment: crossEnd,
      children: [
        PasswordInputWidget(
          controller: controller.oldPasswordController,
          hint: Strings.enterPassword,
          label: Strings.oldPassword,
        ),
        verticalSpace(Dimensions.heightSize),
        PasswordInputWidget(
          controller: controller.newPasswordController,
          hint: Strings.enterPassword,
          label: Strings.newPassword,
        ),
        verticalSpace(Dimensions.heightSize),
        PasswordInputWidget(
          controller: controller.confirmPasswordController,
          hint: Strings.enterPassword,
          label: Strings.confirmPassword,
        ),
        verticalSpace(Dimensions.heightSize * 2),
      ],
    );
  }

  _buttonWidget(BuildContext context) {
    return Obx(
      () => controller.isLoading
          ? const CustomLoadingAPI()
          : PrimaryButton(
              title: Strings.resetPassword,
              onPressed: () {
                controller.changePasswordProcess();
              }),
    );
  }
}
