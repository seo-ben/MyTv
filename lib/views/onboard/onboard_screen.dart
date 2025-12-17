import 'package:carousel_slider/carousel_slider.dart';
import 'package:MyTelevision/backend/local_storage/local_storage.dart';
import 'package:MyTelevision/controller/onboard/onboard_controller.dart';

import '../../controller/basic_settings_controller.dart';
import '../../routes/routes.dart';
import '../../utils/basic_screen_imports.dart';
import '../../widgets/text_labels/title_heading5_widget.dart';

class OnboardScreen extends StatelessWidget {
  OnboardScreen({super.key});
  final controller = Get.put(OnboardController());
  final basicSettingsController = Get.find<BasicSettingsController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _bodyWidget(context));
  }

  _bodyWidget(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      // crossAxisAlignment: crossCenter,
      children: [
        verticalSpace(Dimensions.heightSize * 4),
        CarouselSlider(
          items: controller.itemList,
          carouselController: controller.carouselController, // Connect controller
          options: CarouselOptions(
            autoPlay: true, // Keep autoplay if desired, or set to false if user wants strict manual control
            enlargeCenterPage: true,
            enableInfiniteScroll: true,
            viewportFraction: 1,
            aspectRatio: 1,
            onPageChanged: (index, reason) {
              controller.currentIndex.value = index;
            },
          ),
        ),
        // Positioned(
        //   top: 55.h,
        //   child: Padding(
        //     padding: EdgeInsets.symmetric(
        //       horizontal: Dimensions.widthSize * 1.5,
        //     ),
        //     child: SizedBox(
        //       width: MediaQuery.sizeOf(context).width * .85,
        //       child: Row(
        //         mainAxisAlignment: mainSpaceBet,
        //         children: [
        //           Image.asset(Assets.logo.logoPng.path),
        //           ChangeLanguageWidget(),
        //         ],
        //       ),
        //     ),
        //   ),
        // ),
        Positioned(
          bottom: 60.h,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Dimensions.widthSize * 1.5,
            ),
            child: Column(
              children: [
                verticalSpace(Dimensions.heightSize),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: controller.itemList.asMap().entries.map((entry) {
                    final index = entry.key;
                    return Obx(
                      () => Container(
                        width: controller.currentIndex.value == index
                            ? Dimensions.widthSize * 1.6
                            : Dimensions.widthSize * .8,
                        height: 8.h,
                        margin: const EdgeInsets.symmetric(horizontal: 4.0),
                        decoration: BoxDecoration(
                          color: controller.currentIndex.value == index
                              ? Colors.white
                              : CustomColor.onboardBoxColor,
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                verticalSpace(Dimensions.heightSize),
                Obx(
                  () => TitleHeading1Widget(
                    textAlign: TextAlign.center,
                    fontSize: Dimensions.headingTextSize3,
                    text: controller
                        .onboardList[controller.currentIndex.value]
                        .title,
                  ),
                ),
                verticalSpace(Dimensions.heightSize),
                Obx(
                  () => SizedBox(
                    width: MediaQuery.sizeOf(context).width * .85,
                    child: TitleHeading4Widget(
                      textAlign: TextAlign.center,
                      fontSize: Dimensions.headingTextSize4,
                      text: controller
                          .onboardList[controller.currentIndex.value]
                          .subTitle,
                    ),
                  ),
                ),
                verticalSpace(Dimensions.heightSize * 2),
                _buttonWidget(context),
              ],
            ),
          ),
        ),
      ],
    );
  }

  _buttonWidget(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      padding: EdgeInsets.symmetric(horizontal: Dimensions.widthSize * 1.5),
      child: Column(
        children: [
          Obx(() {
            // Determine button text based on index
            final isLastPage = controller.currentIndex.value == controller.itemList.length - 1;
            return PrimaryButton(
              // "Login Now" only on last page, else "Next"
              title: isLastPage ? Strings.loginNow : Strings.next, 
              onPressed: () {
                controller.next(context);
              },
            );
          }),
          verticalSpace(Dimensions.heightSize * 1.5),
          Row(
            mainAxisAlignment: mainCenter,
            children: [
              TitleHeading5Widget(text: Strings.newToNFC),
              horizontalSpace(Dimensions.widthSize * .5),
              InkWell(
                onTap: () {
                  LocalStorage.saveOnboardDoneOrNot(isOnBoardDone: true);
                  Get.toNamed(Routes.signUpScreen);
                },
                child: TitleHeading5Widget(
                  text: Strings.registerNow,
                  color: CustomColor.primaryLightColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
