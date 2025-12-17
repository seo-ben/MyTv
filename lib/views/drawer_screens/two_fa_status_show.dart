import '/backend/utils/custom_loading_api.dart';
import '/utils/basic_screen_imports.dart';
import '../../controller/drawer/two_fa_status_show/two_fa_status_controller.dart';

class TwoFAScreen extends StatelessWidget {
  TwoFAScreen({super.key});

  final controller = Get.put(TwoFaVerificationScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TitleHeading2Widget(
          text: Strings.twoFaVerification,
        ),
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
      body: Obx(() => controller.isLoading
          ? const CustomLoadingAPI()
          : _bodyWidget(context)),
    );
  }

  _bodyWidget(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(
        horizontal: Dimensions.widthSize * 1.5,
      ),
      shrinkWrap: true,
      children: [
        SizedBox(
          height: Dimensions.paddingSize,
        ),
        _qrImageWidget(context),
        verticalSpace(Dimensions.heightSize),
        // _qrCodeWidget(context),
        SizedBox(
          height: Dimensions.paddingSize * 2,
        ),
        _buttonWidget(context),
      ],
    );
  }

  _buttonWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: Dimensions.paddingSize,
        right: Dimensions.paddingSize,
      ),
      child: Obx(
        () => controller.isSubmitLoading || controller.isLoading
            ? const CustomLoadingAPI()
            : PrimaryButton(
                title: controller.status.value == 0
                    ? Strings.enable
                    : Strings.disable,
                onPressed: () {
                  controller
                      .twoFaSubmitApiProcess()
                      .then((value) => controller.twoFaGetApiProcess());
                }),
      ),
    );
  }

  _qrImageWidget(BuildContext context) {
    return Image.network(
      controller.twoFaInfoModel.data.message,
      scale: 1.25,
    );
  }
}
