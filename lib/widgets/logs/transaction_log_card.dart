// ignore_for_file: prefer_const_literals_to_create_immutables

import '../../utils/basic_screen_imports.dart';
import '../text_labels/title_heading5_widget.dart';

class TransactionCard extends StatelessWidget {
  const TransactionCard(
      {super.key,
      required this.date,
      required this.week,
      required this.paymentMethod,
      required this.trx,
      required this.amount,
      required this.isExpand,
      required this.onTap,
      required this.subscriptionId,
      required this.subscriptionType,
      required this.accountName,
      required this.accountNumber,
      required this.convertAmount,
      required this.exchangeRate,
      required this.feesAndCharges,
      required this.senderName,
      required this.recipientName});
  final String date, week, paymentMethod, trx, amount;
  final bool isExpand;
  final VoidCallback onTap;
  final String subscriptionId,
      subscriptionType,
      accountName,
      accountNumber,
      convertAmount,
      exchangeRate,
      feesAndCharges,
      senderName,
      recipientName;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isTablet = screenWidth > 500;

    final color =
        Get.isDarkMode ? CustomColor.whiteColor : CustomColor.blackColor;
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          ListTile(
            leading: Container(
              width: Dimensions.widthSize * 4,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius * 0.8),
                  color: CustomColor.blackColor),
              padding: EdgeInsets.symmetric(
                horizontal: isTablet ? 0 : Dimensions.marginSizeVertical * 0.2,
              ),
              child: Column(
                // mainAxisSize: mainMax,
                mainAxisAlignment: mainCenter,
                children: [
                  TitleHeading2Widget(
                    text: date,
                    color: color,
                    fontSize: isTablet
                        ? Dimensions.headingTextSize5
                        : Dimensions.headingTextSize2,
                  ),
                  TitleHeading5Widget(
                    text: week,
                    color: color,
                    fontSize: Dimensions.headingTextSize6,
                  ),
                ],
              ),
            ),
            title: Column(
              crossAxisAlignment: crossStart,
              mainAxisAlignment: mainSpaceBet,
              children: [
                TitleHeading4Widget(
                  text: paymentMethod,
                  fontSize: isTablet
                      ? Dimensions.headingTextSize5 * 0.95
                      : Dimensions.headingTextSize3,
                  fontWeight: isTablet ? FontWeight.normal : FontWeight.w600,
                  color: color,
                ),
                verticalSpace(Dimensions.heightSize * 0.25),
                TitleHeading5Widget(
                  text: trx,
                  color: color,
                  fontSize: isTablet
                      ? Dimensions.headingTextSize6 * 0.75
                      : Dimensions.headingTextSize5,
                ),
              ],
            ),
            trailing: TitleHeading4Widget(
              text: amount,
              fontSize: isTablet
                  ? Dimensions.headingTextSize5
                  : Dimensions.headingTextSize4,
              color: color,
            ),
          ),
          const Divider(
            color: CustomColor.whiteColor,
          ),
          Visibility(
              visible: isExpand,
              child: Container(
                padding: EdgeInsets.all(Dimensions.paddingSize * .5),
                decoration: BoxDecoration(
                  color: CustomColor.whiteColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      Dimensions.radius,
                    ),
                  ),
                ),
                child: Column(
                  children: [
                    _rowWidget(context, Strings.subscriptionID, subscriptionId),
                  ],
                ),
              ))
        ],
      ),
    );
  }

  _rowWidget(BuildContext context, String title, value) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isTablet = screenWidth > 500;
    final color =
        Get.isDarkMode ? CustomColor.blackColor : CustomColor.blackColor;
    return Visibility(
      visible: value.isNotEmpty,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TitleHeading5Widget(
            text: title,
            fontSize: isTablet
                ? Dimensions.headingTextSize6
                : Dimensions.headingTextSize5,
            fontWeight: isTablet ? FontWeight.w500 : FontWeight.bold,
            color: color,
          ),
          TitleHeading5Widget(
            text: value,
            fontSize: isTablet
                ? Dimensions.headingTextSize6
                : Dimensions.headingTextSize5,
            color: color,
          ),
        ],
      ).paddingOnly(
        bottom: Dimensions.heightSize * .5,
      ),
    );
  }
}
