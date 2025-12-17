import 'dart:convert';

import '/backend/utils/custom_loading_api.dart';
import '../../../controller/subscirption/subscription_controller.dart';
import '../../../utils/basic_screen_imports.dart';

class MySubscriptionScreen extends StatelessWidget {
  MySubscriptionScreen({super.key});

  final controller = Get.put(SubscriptionController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              CustomColor.primaryLightScaffoldBackgroundColor.withValues(alpha: 0.8),
              CustomColor.primaryLightScaffoldBackgroundColor.withValues(alpha: 0.6),
              CustomColor.primaryLightScaffoldBackgroundColor.withValues(alpha: 0.8),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    CustomColor.primaryLightScaffoldBackgroundColor
                        .withValues(alpha: 0.9),
                    CustomColor.primaryLightScaffoldBackgroundColor
                        .withValues(alpha: 0.7),
                  ],
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(Dimensions.radius * 2),
                  bottomRight: Radius.circular(Dimensions.radius * 2),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.5),
                    offset: const Offset(0, 4),
                    blurRadius: 12,
                  ),
                ],
              ),
              child: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                title: TitleHeading2Widget(
                  text: Strings.mySubscription,
                  color: CustomColor.whiteColor.withValues(alpha: 0.9),
                ),
                leading: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: CustomColor.whiteColor.withValues(alpha: 0.8),
                    size: Dimensions.iconSizeLarge,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Obx(() => controller.isLoading
                  ? const CustomLoadingAPI()
                  : controller.dashboardInfoModel.data == null
                      ? Center(
                          child: TitleHeading2Widget(text: Strings.noDataFound),
                        )
                      : _bodyWidget(context)),
            )
          ],
        ),
      ),
    );
  }

  _bodyWidget(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: Dimensions.widthSize * 1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: Dimensions.heightSize * 3),
            _darkSubscriptionCard(context),
          ],
        ),
      ),
    );
  }

  _darkSubscriptionCard(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Dimensions.radius * 2),
      ),
      elevation: 10,
      shadowColor: Colors.black45,
      color: Colors.black.withValues(alpha: 0.3),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.radius * 2),
          gradient: LinearGradient(
            colors: [
              CustomColor.primaryLightScaffoldBackgroundColor.withValues(alpha: 0.8),
              CustomColor.primaryLightScaffoldBackgroundColor.withValues(alpha: 0.5),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: const [
            BoxShadow(
              color: Colors.black45,
              blurRadius: 15,
              offset: Offset(4, 8),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(Dimensions.widthSize * 2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _darkCardHeader(context),
              verticalSpace(Dimensions.heightSize * 1.8),
              _subscriptionInfoWidget(context),
              verticalSpace(Dimensions.heightSize * 2),
              _benefitsList(context),
            ],
          ),
        ),
      ),
    );
  }

  _darkCardHeader(BuildContext context) {
    var data = controller.dashboardInfoModel.data?.subscriptionLog?.package;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TitleHeading2Widget(
          text: data!.name,
          color: CustomColor.whiteColor.withValues(alpha: 0.85),
        ),
        Container(
          padding: EdgeInsets.all(Dimensions.widthSize * 0.5),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.green.withValues(alpha: 0.2),
          ),
          child: Icon(
            data.status.toString() == "1" ? Icons.check_circle : Icons.close,
            color: data.status.toString() == "1"
                ? Colors.greenAccent
                : CustomColor.redColor,
            size: Dimensions.iconSizeDefault * 1.5,
            weight: 700,
          ),
        ),
      ],
    );
  }

  _benefitsList(BuildContext context) {
    Map<String, dynamic> data = jsonDecode(controller
        .dashboardInfoModel.data!.subscriptionLog!.package.defaultFeature);
    return Column(
      children: [
        _benefitItem(context, Icons.done, data["f1"] ?? '', Colors.greenAccent),
        _benefitItem(
            context, Icons.done, data["f2"] ?? '', Colors.orangeAccent),
        _benefitItem(context, Icons.done, data["f3"] ?? '', Colors.blueAccent),
      ],
    );
  }

  _benefitItem(BuildContext context, IconData icon, String title, Color color) {
    return title == ''
        ? Container()
        : Padding(
            padding:
                EdgeInsets.symmetric(vertical: Dimensions.heightSize * 0.8),
            child: Row(
              children: [
                Icon(icon,
                    color: color, size: Dimensions.iconSizeDefault * 1.2),
                horizontalSpace(Dimensions.widthSize * 0.8),
                TitleHeading4Widget(
                    text: title,
                    color: CustomColor.whiteColor.withValues(alpha: 0.8)),
              ],
            ),
          );
  }

  _subscriptionInfoWidget(BuildContext context) {
    var data = controller.dashboardInfoModel.data!.subscriptionLog;
    return Column(
      children: [
        _rowTextWidget(
            context,
            Strings.subscriptionStatus,
            data!.status.toString() == '0'
                ? Strings.expired
                : Strings.subscribed,
            Icons.check_circle,
            Colors.greenAccent),
        Divider(color: Colors.white.withValues(alpha: 0.4), thickness: 1),
        _rowTextWidget(context, Strings.subscriptionRid, data.transaction.trxId,
            Icons.receipt, Colors.orangeAccent),
        Divider(color: Colors.white.withValues(alpha: 0.4), thickness: 1),
        _rowTextWidget(context, Strings.startDate, data.expireDate,
            Icons.date_range, Colors.lightBlueAccent),
        Divider(color: Colors.white.withValues(alpha: 0.4), thickness: 1),
        _rowTextWidget(context, Strings.endDate, data.expireDate,
            Icons.date_range_outlined, Colors.lightBlueAccent),
        Divider(color: Colors.white.withValues(alpha: 0.4), thickness: 1),
        _rowTextWidget(context, Strings.amount, "${data.package.price} USD",
            Icons.attach_money, Colors.yellowAccent),
      ],
    );
  }

  _rowTextWidget(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
    Color iconColor,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: Dimensions.heightSize * 0.8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: iconColor,
                size: Dimensions.iconSizeDefault * 1.2,
              ),
              horizontalSpace(Dimensions.widthSize * 0.8),
              TitleHeading4Widget(
                text: title,
                fontSize: Dimensions.headingTextSize4 * .95,
                color: CustomColor.whiteColor.withValues(alpha: 0.9),
                textOverflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          TitleHeading4Widget(
            text: subtitle,
            fontSize: Dimensions.headingTextSize4 * .95,
            color: CustomColor.whiteColor.withValues(alpha: 0.9),
            textOverflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
