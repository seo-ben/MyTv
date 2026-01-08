import '/backend/utils/custom_loading_api.dart';
import '/widgets/text_labels/title_heading5_widget.dart';
import '../../../controller/auth/sign_in/sign_in_controller.dart';
import '../../../custom_assets/assets.gen.dart';
import '../../../routes/routes.dart';
import '../../../utils/basic_screen_imports.dart';
import '../../../utils/device_info.dart';
import '../../../widgets/tv/focusable_widget.dart';
import '../../../widgets/inputs/password_input_widget.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});

  final controller = Get.put(SignInController());
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
                  // Logo with animation effect (simple fade/scale if possible, here static for now)
                  // Use a glass container for the form
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
            height: Dimensions.heightSize * 6, // Make logo prominent
          ),
        ),
        verticalSpace(Dimensions.heightSize * 3),

        // Welcome Text
        Center(
          child: Column(
            children: [
              TitleHeading1Widget(
                text: Strings.loginInformation,
                color: Colors.white,
                textAlign: TextAlign.center,
              ),
              verticalSpace(Dimensions.heightSize * 0.5),
              TitleHeading4Widget(
                text: Strings.loginInfo,
                color: Colors.white.withOpacity(0.7),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),

        verticalSpace(Dimensions.heightSize * 3),
        _inputFormField(context),
        verticalSpace(Dimensions.heightSize * 2),
        _buttonWidget(context),
      ],
    );
  }

  _inputFormField(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          PrimaryInputWidget(
            controller: controller.emailAddressController,
            hint: Strings.enterEmailAddress,
            label: Strings.emailAddress,
            isValidator: true,
            // Ensure contrast on dark gradient
            // We rely on widget internal style but might need checks if it's strictly light-themed internally
          ),
          SizedBox(height: Dimensions.heightSize),
          PasswordInputWidget(
            controller: controller.passwordController,
            hint: Strings.enterPassword,
            label: Strings.password,
            textInputAction: TextInputAction.done,
          ),
          SizedBox(height: Dimensions.heightSize * .5),
          FocusableWidget(
            onPressed: () {
              Get.toNamed(Routes.forgotPasswordScreen);
            },
            borderRadius: BorderRadius.circular(Dimensions.radius * 0.5),
            child: Padding(
              padding: EdgeInsets.all(Dimensions.widthSize * 0.5),
              child: TitleHeading5Widget(
                text: Strings.forgetPassword,
                color: CustomColor.primaryLightColor, // Keep accent color
              ),
            ),
          ),
          SizedBox(height: Dimensions.heightSize * 2),
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
              : FocusableWidget(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      controller.signInProcess();
                    }
                  },
                  borderRadius: BorderRadius.circular(Dimensions.radius),
                  child: PrimaryButton(
                    title: Strings.loginNow,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        controller.signInProcess();
                      }
                    },
                  ),
                ),
        ),
        verticalSpace(Dimensions.heightSize * 1.5),

        // Added Guest Access button for Google Review and TV users
        FocusableWidget(
          onPressed: () {
            Get.offAllNamed(Routes.bottomNavBar);
          },
          borderRadius: BorderRadius.circular(Dimensions.radius),
          child: PrimaryButton(
            title: "Accueil",
            buttonColor: CustomColor.whiteColor.withOpacity(0.1),
            onPressed: () {
              Get.offAllNamed(Routes.bottomNavBar);
            },
          ),
        ),
        verticalSpace(Dimensions.heightSize * 2),
        Row(
          mainAxisAlignment: mainCenter,
          children: [
            TitleHeading5Widget(
              text: Strings.newToNFC,
              color: Colors.white.withOpacity(0.8),
            ),
            horizontalSpace(Dimensions.widthSize * .5),
            FocusableWidget(
              onPressed: () {
                Get.toNamed(Routes.signUpScreen);
              },
              borderRadius: BorderRadius.circular(Dimensions.radius * 0.5),
              child: Padding(
                padding: EdgeInsets.all(Dimensions.widthSize * 0.5),
                child: TitleHeading5Widget(
                  text: Strings.registerNow,
                  color: CustomColor.primaryLightColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
