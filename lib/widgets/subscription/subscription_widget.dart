import '../../utils/basic_screen_imports.dart';

class SubscriptionWidget extends StatelessWidget {
  const SubscriptionWidget({
    super.key,
    required this.name,
    required this.price,
    required this.date,
  });
  final String name, price, date;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: CustomColor.boxColor,
        borderRadius: BorderRadius.circular(10.w),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TitleHeading2Widget(text: name),
              Row(
                children: [
                  TitleHeading2Widget(text: price),
                  SizedBox(width: 8.w),
                ],
              ),
            ],
          ),
          SizedBox(height: 16.h),
          TitleHeading4Widget(
            text: "Votre soutien expirera le $date",
            color: CustomColor.primaryLightColor,
          ),
        ],
      ),
    );
  }
}
