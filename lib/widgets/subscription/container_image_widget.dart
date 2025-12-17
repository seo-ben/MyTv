import '../../custom_assets/assets.gen.dart';
import '../../utils/basic_screen_imports.dart';
import '../others/custom_image_widget.dart';

class ContainerImageWidget extends StatelessWidget {
  const ContainerImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        CircleAvatar(
          radius: Dimensions.radius * 18,
          backgroundColor: CustomColor.containerColor.withValues(alpha: .4),
          child: CircleAvatar(
            radius: Dimensions.radius * 15.25,
            backgroundColor: CustomColor.primaryLightScaffoldBackgroundColor,
            child: CircleAvatar(
              radius: Dimensions.radius * 12.5,
              backgroundColor: CustomColor.containerColor,
              child: CircleAvatar(
                radius: Dimensions.radius * 10.25,
                backgroundColor:
                    CustomColor.primaryLightScaffoldBackgroundColor,
                child: CircleAvatar(
                  radius: Dimensions.radius * 8,
                  backgroundColor: CustomColor.containerColor,
                ),
              ),
            ),
          ),
        ),
        CustomImageWidget(
          path: Assets.bg.container.path,
          height: MediaQuery.sizeOf(context).height * .5,
          width: MediaQuery.sizeOf(context).width * .85,
        ),
        Column(
          children: [
            TitleHeading1Widget(
              text: Strings.buyPlan,
              fontWeight: FontWeight.w500,
              fontSize: Dimensions.headingTextSize2,
            ),
            SizedBox(
              width: Dimensions.widthSize * 15,
              child: TitleHeading4Widget(
                text: Strings.chooseASubscriptionPlan,
                fontSize: Dimensions.headingTextSize6,
                fontWeight: FontWeight.w400,
                textAlign: TextAlign.center,
              ),
            )
          ],
        )
      ],
    );
  }
}
