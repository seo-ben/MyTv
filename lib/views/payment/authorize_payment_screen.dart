import 'package:flutter/services.dart';
import '../../../../backend/utils/custom_loading_api.dart';
import '../../../../controller/payment/payment_controller.dart';
import '../../utils/basic_screen_imports.dart';

class AuthorizeGatewayScreen extends StatelessWidget {
  AuthorizeGatewayScreen({super.key});

  final controller = Get.put(PaymentController());
  final passwordKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColor.primaryLightScaffoldBackgroundColor,
        automaticallyImplyLeading: true,
        title: TitleHeading2Widget(text: Strings.debitCardPayment),
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

  ListView _bodyWidget(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(
        horizontal: Dimensions.marginSizeHorizontal * 0.9,
      ),
      physics: const BouncingScrollPhysics(),
      children: [_inputWidget(context), _buttonWidget(context)],
    );
  }

  Form _inputWidget(BuildContext context) {
    return Form(
      key: passwordKey,
      child: Column(
        children: [
          // verticalSpace(Dimensions.heightSize ),
          PrimaryInputWidget(
            controller: controller.cardNumberController,
            hint: Strings.cardNumber,
            label: "0000 0000 0000 0000",

            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              CardNumberFormatter(),
            ],
          ),
          // verticalSpace(Dimensions.heightSize),
          PrimaryInputWidget(
            controller: controller.cardExpiryController,
            hint: Strings.expiryDate,
            label: "YY/MM",
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              ExpiryDateFormatter(),
            ],
          ),
          // verticalSpace(Dimensions.heightSize),
          PrimaryInputWidget(
            controller: controller.cardCVCController,
            hint: Strings.cvv,

            label: "123",
            keyboardType: TextInputType.number,
          ),
        ],
      ),
    );
  }

  Container _buttonWidget(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: Dimensions.marginSizeVertical),
      child: Obx(
        () => controller.isAuthorizeConfirmLoading
            ? const CustomLoadingAPI()
            : PrimaryButton(
                onPressed: () {
                  if (passwordKey.currentState!.validate()) {
                    controller.authorizeConfirmProcess();
                  }
                },
                borderColor: CustomColor.blackColor,
                buttonColor: CustomColor.primaryBGDarkColor,
                title: Strings.confirm,
              ),
      ),
    );
  }
}

class ExpiryDateFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String text = newValue.text.replaceAll(RegExp(r'\D'), '');
    if (text.length > 2) {
      text = "${text.substring(0, 2)}/${text.substring(2)}";
    }
    return TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}

class CardNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final digitsOnly = newValue.text.replaceAll(RegExp(r'\D'), '');
    final formatted = digitsOnly.replaceAllMapped(
      RegExp(r".{1,4}"),
      (match) => "${match.group(0)} ",
    );
    return TextEditingValue(
      text: formatted.trim(),
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}
