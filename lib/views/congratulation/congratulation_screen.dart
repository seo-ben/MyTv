import '/custom_assets/assets.gen.dart';
import '/utils/basic_screen_imports.dart';
import '/widgets/others/custom_image_widget.dart';
import '../../widgets/text_labels/title_subtitle_widget.dart';

class CongratulationScreen extends StatelessWidget {
  const CongratulationScreen({
    super.key,
    required this.title,
    required this.subTitle,
    required this.route,
  });

  final String title, subTitle, route;
  final Color buttonColor = CustomColor.primaryLightColor;

  @override
  Widget build(BuildContext context) {
    Future<bool> willPop() {
      Get.offNamedUntil(route, (route) => false);
      return Future.value(true);
    }

    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: willPop,
      child: Scaffold(
        appBar: AppBar(),
        body: _bodyWidget(
          context,
        ),
      ),
    );
  }

  // body widget containing all widget elements
  _bodyWidget(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: crossCenter,
        children: [
          CustomImageWidget(
            path: Assets.bg.congratulations,
            height: MediaQuery.sizeOf(context).height * .35,
            width: MediaQuery.sizeOf(context).width * .75,
          ),
          verticalSpace(Dimensions.heightSize),
          _congratulationInfoWidget(
            context,
          ),
          verticalSpace(Dimensions.heightSize * 1.33),
          _buttonWidget(context),
        ],
      ),
    );
  }

  _buttonWidget(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: Dimensions.marginSizeHorizontal),
      child: PrimaryButton(
        title: Strings.okay,
        onPressed: () {
          Get.offNamedUntil(route, (route) => false);
        },
      ),
    );
  }

  _congratulationInfoWidget(
    BuildContext context,
  ) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: Dimensions.marginSizeHorizontal),
      child: Column(
        mainAxisAlignment: mainCenter,
        crossAxisAlignment: crossCenter,
        children: [
          TitleSubTitleWidget(
            crossAxisAlignment: crossCenter,
            title: title,
            subtitle: subTitle,
          ),
        ],
      ),
    );
  }
}
