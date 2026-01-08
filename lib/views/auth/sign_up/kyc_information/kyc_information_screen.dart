import '/controller/auth/sign_up/kyc_information/kyc_controller.dart';
import '/widgets/others/custom_image_widget.dart';
import '/widgets/text_labels/title_heading5_widget.dart';
import '../../../../custom_assets/assets.gen.dart';
import '../../../../routes/routes.dart';
import '../../../../utils/basic_screen_imports.dart';
import '../../../../widgets/drop_down/custom_drop_down_widget.dart';
import '../../../../widgets/inputs/kyc_image_widget.dart';

class KycInformationScreen extends StatelessWidget {
  KycInformationScreen({super.key});
  final controller = Get.put(KycController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColor.primaryLightScaffoldBackgroundColor,
        title: TitleHeading2Widget(text: Strings.kycInformation),
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
        crossAxisAlignment: crossStart,
        children: [
          verticalSpace(Dimensions.heightSize * 3),
          Row(
            children: [
              TitleHeading1Widget(
                text: Strings.kycInformation,
              ),
              horizontalSpace(Dimensions.widthSize),
              _statusWidget(context),
            ],
          ),
          verticalSpace(Dimensions.heightSize),
          TitleHeading4Widget(
            text: Strings.pleaseSubmitYourKyc,
          ),
          verticalSpace(Dimensions.heightSize),
          CustomDropDown(
            itemsList: controller.kycList,
            selectMethod: "Choose One".obs,
            labelColor: CustomColor.whiteColor,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: CustomColor.whiteColor.withValues(alpha: 
                    .20,
                  ),
                ),
              ),
            ),
          ),
          verticalSpace(Dimensions.heightSize),
          _proofIdentity(context),
          verticalSpace(Dimensions.heightSize),
          _uploadImageWidget(context),
          verticalSpace(Dimensions.heightSize * 2),
          _buttonWidget(context)
        ],
      ),
    );
  }

  _statusWidget(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Dimensions.widthSize * .4,
        vertical: Dimensions.heightSize * .33,
      ),
      decoration: BoxDecoration(
          color: CustomColor.unverifiedBoxColor,
          borderRadius: BorderRadius.circular(5.r)),
      child: Row(
        children: [
          Icon(
            Icons.warning,
            color: CustomColor.unverifiedColor,
            size: 12.sp,
          ),
          horizontalSpace(Dimensions.widthSize * .5),
          TitleHeading5Widget(
            text: Strings.unverified,
            color: CustomColor.unverifiedColor,
            fontWeight: FontWeight.w500,
          ),
        ],
      ),
    );
  }

  _proofIdentity(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Dimensions.widthSize * 2,
        vertical: Dimensions.heightSize,
      ),
      decoration: BoxDecoration(
        color: CustomColor.buttonDeepColor,
        borderRadius: BorderRadius.all(
          Radius.circular(
            Dimensions.radius,
          ),
        ),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: Dimensions.radius * 2,
            backgroundColor: CustomColor.primaryLightScaffoldBackgroundColor,
            child: CustomImageWidget(
              path: Assets.icons.demography,
            ),
          ).paddingOnly(bottom: Dimensions.heightSize),
          horizontalSpace(Dimensions.widthSize),
          Column(
            crossAxisAlignment: crossStart,
            children: [
              TitleHeading4Widget(
                text: Strings.proofOfIdentify,
                fontWeight: FontWeight.w500,
                fontSize: Dimensions.headingTextSize3,
              ),
              SizedBox(
                width: MediaQuery.sizeOf(context).width * .665,
                child: TitleHeading4Widget(
                  text: Strings.proofOfIdentifyInfo,
                  fontWeight: FontWeight.w400,
                  maxLines: 3,
                  fontSize: Dimensions.headingTextSize6 * 1.1,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  _uploadImageWidget(BuildContext context) {
    return Row(
      mainAxisAlignment: mainSpaceBet,
      children: [
        const Expanded(
          child: UpdateKycImageWidget(
            labelName: 'Front Part',
            fieldName: 'Front Part',
          ),
        ),
        SizedBox(
          width: Dimensions.widthSize,
        ),
        const Expanded(
          child: UpdateKycImageWidget(
            labelName: 'Back Part',
            fieldName: 'Back Part',
          ),
        ),
      ],
    );
  }

  _buttonWidget(BuildContext context) {
    return Column(
      children: [
        PrimaryButton(
            title: Strings.submit,
            onPressed: () {
              Get.offAllNamed(Routes.bottomNavBar);
            }),
        verticalSpace(
          Dimensions.heightSize * 2,
        ),
        TitleHeading4Widget(text: Strings.skipNow)
      ],
    );
  }
}
