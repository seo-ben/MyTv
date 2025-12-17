import '../../utils/basic_screen_imports.dart';

class SubscriptionCardWidget extends StatelessWidget {
  SubscriptionCardWidget({
    super.key,
    required this.title,
    required this.title2,
    required this.day,
    required this.month,
    required this.amount,
    required this.status,
  });

  final bgColor = Get.isDarkMode
      ? CustomColor.primaryDarkScaffoldBackgroundColor
      : CustomColor.primaryLightScaffoldBackgroundColor;

  final stateColor =
      Get.isDarkMode ? CustomColor.whiteColor : CustomColor.boxColor;

  final Color customColor =
      Get.isDarkMode ? CustomColor.whiteColor : CustomColor.whiteColor;
  final String title, title2, day, month, amount, status;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: CustomColor.buttonDeepColor,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: Dimensions.heightSize * .5),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: Dimensions.widthSize,
                vertical: Dimensions.heightSize * .2,
              ),
              margin: EdgeInsets.all(
                Dimensions.paddingSize * .25,
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    Dimensions.radius,
                  ),
                  color: CustomColor.whiteColor.withValues(alpha: .25)),
              child: Column(
                children: [
                  TitleHeading1Widget(
                    text: day,
                    fontWeight: FontWeight.w600,
                    color: customColor,
                    maxLines: 1,
                  ),
                  TitleHeading4Widget(
                    text: month,
                    fontSize: Dimensions.headingTextSize4,
                    fontWeight: FontWeight.w400,
                    color: customColor,
                  ),
                ],
              ),
            ),
            horizontalSpace(Dimensions.paddingSize * 0.625),
            Expanded(
              child: Column(
                crossAxisAlignment: crossStart,
                children: [
                  TitleHeading3Widget(
                    text: title,
                    fontSize: Dimensions.headingTextSize3,
                    color: customColor,
                    maxLines: 2,
                    textOverflow: TextOverflow.ellipsis,
                  ),
                  verticalSpace(Dimensions.heightSize * 0.33),
                  TitleHeading3Widget(
                    text: title2,
                    maxLines: 1,
                    color: customColor.withValues(alpha: .50),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                TitleHeading4Widget(
                  text: amount,
                  maxLines: 1,
                  color: customColor,
                ),
                TitleHeading3Widget(
                  text: status,
                  maxLines: 1,
                  color: CustomColor.primaryLightColor,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
