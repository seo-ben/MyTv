import 'package:MyTelevision/language/language_controller.dart';

import '/backend/utils/custom_loading_api.dart';
import '/controller/auth/sign_up/sign_up_controller.dart';
import '/controller/basic_settings_controller.dart';
import '/widgets/text_labels/title_heading5_widget.dart';
import '../../../custom_assets/assets.gen.dart';
import '../../../routes/routes.dart';
import '../../../utils/basic_screen_imports.dart';
import '../../../widgets/commo/gradient_check_widget.dart';
import '../../../widgets/inputs/password_input_widget.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});
  final controller = Get.put(SignUpController());

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Premium Design: Full screen gradient with glassmorphism
    // Remove default AppBar for immersion
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: CustomStyle.premiumGradient,
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Dimensions.widthSize * 2,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Glassmorphism Container
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.widthSize * 2,
                      vertical: Dimensions.heightSize * 3,
                    ),
                    decoration: CustomStyle.glassBoxDecoration,
                    child: _bodyWidget(context),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _bodyWidget(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: mainCenter,
      crossAxisAlignment: crossStart,
      children: [
        Center(
          child: Image.asset(
            Assets.logo.logoPng.path,
            height: Dimensions.heightSize * 6,
          ),
        ),
        verticalSpace(Dimensions.heightSize * 3),

        // Welcome Text
        Center(
          child: Column(
            children: [
              TitleHeading1Widget(
                text: Strings.registerInformation,
                color: Colors.white,
                textAlign: TextAlign.center,
              ),
              verticalSpace(Dimensions.heightSize * 0.5),
              TitleHeading4Widget(
                text: Strings.pleaseInputYourDetailsAnd,
                color: Colors.white.withOpacity(0.7),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),

        verticalSpace(Dimensions.heightSize * 3),
        _inputFormWidget(context),
        verticalSpace(Dimensions.heightSize * 2),
        _buttonWidget(context),
      ],
    );
  }

  _inputFormWidget(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: PrimaryInputWidget(
                  controller: controller.firstNameController,
                  hint: Strings.enterName,
                  label: Strings.firstName,
                ),
              ),
              horizontalSpace(Dimensions.widthSize),
              Expanded(
                child: PrimaryInputWidget(
                  controller: controller.lastNameController,
                  hint: Strings.enterName,
                  label: Strings.lastName,
                ),
              ),
            ],
          ),
          verticalSpace(Dimensions.heightSize),
          PrimaryInputWidget(
            controller: controller.emailController,
            hint: Strings.enterEmailAddress,
            label: Strings.emailAddress,
          ),
          verticalSpace(Dimensions.heightSize),
          PasswordInputWidget(
            controller: controller.passwordController,
            hint: Strings.enterPassword,
            label: Strings.password,
          ),
          verticalSpace(Dimensions.heightSize),
          verticalSpace(Dimensions.heightSize),
          // Check if settings are loaded and agree policy is enabled
          (Get.find<BasicSettingsController>().isSettingsLoaded &&
                  Get.find<BasicSettingsController>()
                          .appSettingsModel
                          .data
                          .agreePolicy ==
                      true)
              ? Row(
                  mainAxisAlignment: mainStart,
                  children: [
                    GradientCheckWidget(isChecked: controller.isChecked),
                    horizontalSpace(10.w),
                    // Checkbox Text Color Adjustment for Dark Background
                    Flexible(
                      child: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          TitleHeading5Widget(
                            text: Strings.iHaveAgreed,
                            color: Colors.white.withOpacity(0.8),
                          ),
                          horizontalSpace(5.w),
                          InkWell(
                            onTap: () {
                              // Add link logic here if needed
                            },
                            child: Text(
                              Get.find<LanguageController>().getTranslation(
                                Strings.termsOfUse,
                              ),
                              style: CustomStyle.lightHeading5TextStyle
                                  .copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: CustomColor.primaryLightColor,
                                    decoration: TextDecoration.underline,
                                    decorationColor:
                                        CustomColor.primaryLightColor,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              : Container(),
        ],
      ),
    );
  }

  _buttonWidget(BuildContext context) {
    return Column(
      children: [
        Obx(
          () => controller.isLoading
              ? const CustomLoadingAPI()
              : SizedBox(
                  width: double.infinity,
                  child: PrimaryButton(
                    title: Strings.registerNow,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        controller.signUpProcess();
                      }
                    },
                  ),
                ),
        ),
        verticalSpace(Dimensions.heightSize * 2),
        Row(
          mainAxisAlignment: mainCenter,
          children: [
            TitleHeading5Widget(
              text: Strings.alreadyHaveAnAccount,
              color: Colors.white.withOpacity(0.8),
            ),
            horizontalSpace(Dimensions.widthSize * .5),
            InkWell(
              onTap: () {
                Get.toNamed(Routes.signInScreen);
              },
              child: TitleHeading5Widget(
                text: Strings.loginNow,
                color: CustomColor.primaryLightColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
