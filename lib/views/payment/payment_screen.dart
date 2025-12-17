import '/backend/utils/custom_loading_api.dart';
import '/controller/payment/payment_controller.dart';
import '../../controller/subscription_page/subscription_page_controller.dart';
import '../../utils/basic_screen_imports.dart';
import '../../widgets/drop_down/custom_drop_down_widget.dart';
import '../../widgets/subscription/subscription_widget.dart';

class PaymentScreen extends StatelessWidget {
  PaymentScreen({super.key});
  final controller = Get.put(PaymentController());
  final subscriptionController = Get.put(SubscriptionPageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColor.primaryLightScaffoldBackgroundColor,
        automaticallyImplyLeading: true,
        title: TitleHeading2Widget(text: Strings.payment),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back, color: CustomColor.whiteColor),
        ),
      ),
      body: Obx(
        () =>
            controller.isLoading ||
                subscriptionController.isLoading ||
                subscriptionController.subscriptionModel == null
            ? const CustomLoadingAPI()
            : _bodyWidget(context),
      ),
    );
  }

  _bodyWidget(BuildContext context) {
    var data = subscriptionController
        .subscriptionModel!
        .data
        .subscribePageData[subscriptionController.currentIndex.value];
    return ListView(
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(horizontal: Dimensions.widthSize * 1.5),
      children: [
        verticalSpace(Dimensions.heightSize * 2),
        SubscriptionWidget(
          name: data.name,
          price: "${data.price} ${data.baseCurrency}",
          date: subscriptionController.calculateExpiryDate(data.duration),
        ),
        verticalSpace(Dimensions.heightSize),
        CustomDropDown(
          itemsList: controller.paymentList,
          onChanged: (v) {},
          selectMethod: controller.selectPayment,
          labelColor: CustomColor.whiteColor,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimensions.radius),
            border: Border.all(color: CustomColor.whiteColor),
          ),
        ),
        verticalSpace(Dimensions.heightSize),
        _buttonWidget(context),
      ],
    );
  }

  _buttonWidget(BuildContext context) {
    return Obx(
      () => controller.isSubmitLoading
          ? const CustomLoadingAPI()
          : SizedBox(
              height: Dimensions.heightSize * 3.5,
              child: PrimaryButton(
                title: Strings.continu,
                onPressed: () {
                  controller.paymentCheckoutProcess().then((onValue) {
                    if (controller.selectPayment.contains("paypal")) {
                      controller.paypalSubmitProcess();
                    } else if (controller.selectPayment.contains("tatum")) {
                      controller.tatumProcess();
                    } else if (controller.selectPayment.contains("Authorize")) {
                      controller.authorizeSubmitProcess();
                    } else {
                      controller.paymentAutomaticSubmitProcess();
                    }
                  });
                },
              ),
            ),
    );
  }
}
