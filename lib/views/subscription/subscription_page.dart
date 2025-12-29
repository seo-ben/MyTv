import 'dart:convert';

import '/backend/utils/custom_loading_api.dart';
import '/controller/subscription_page/subscription_page_controller.dart';
import '/widgets/text_labels/title_heading5_widget.dart';
import '../../routes/routes.dart';
import '../../utils/basic_screen_imports.dart';
import '../../widgets/subscription/container_image_widget.dart';
import '/backend/local_storage/local_storage.dart';

class SubscriptionPage extends StatelessWidget {
  SubscriptionPage({super.key});
  final controller = Get.put(SubscriptionPageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColor.primaryLightScaffoldBackgroundColor,
        automaticallyImplyLeading: true,
        title: TitleHeading2Widget(text: Strings.subscription),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back, color: CustomColor.whiteColor),
        ),
      ),
      body: Obx(
        () => controller.isLoading || controller.subscriptionModel == null
            ? const CustomLoadingAPI()
            : _newBodyWidget(context),
      ),
    );
  }

  _newBodyWidget(context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: crossStart,
        children: [
          const ContainerImageWidget(),
          TitleHeading5Widget(
            text: Strings.allSubscriptionPlan,
            fontSize: Dimensions.headingTextSize4,
            padding: EdgeInsets.only(left: Dimensions.widthSize * 1.5),
          ),
          _subscriptionListWidget(context),
          verticalSpace(Dimensions.heightSize),
        ],
      ),
    );
  }

  _subscriptionListWidget(context) {
    var data = controller.subscriptionModel!.data.subscribePageData;
    return ListView.builder(
      itemCount: data.length,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: Dimensions.widthSize * 1.5),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        Map<String, dynamic> featureMap = jsonDecode(
          controller
              .subscriptionModel!
              .data
              .subscribePageData[index]
              .defaultFeature,
        );
        return Obx(
          () => GestureDetector(
            onTap: () {
              controller.currentIndex.value = index;
            },
            child: Container(
              margin: EdgeInsets.symmetric(
                vertical: Dimensions.heightSize * .5,
              ),
              padding: EdgeInsets.symmetric(
                vertical: Dimensions.heightSize * 1.5,
                horizontal: Dimensions.widthSize * 1.5,
              ),
              decoration: BoxDecoration(
                color: index % 3 == 0
                    ? const Color(0xFF0092FF).withValues(alpha: .1)
                    : index % 3 == 1
                    ? const Color(0xFF5269FF).withValues(alpha: .1)
                    : const Color(0xFFFF6200).withValues(alpha: .1),
                borderRadius: BorderRadius.circular(Dimensions.radius * 1.33),
              ),
              child: Column(
                crossAxisAlignment: crossStart,
                children: [
                  Row(
                    mainAxisAlignment: mainSpaceBet,
                    children: [
                      Column(
                        crossAxisAlignment: crossStart,
                        children: [
                          TitleHeading5Widget(text: Strings.price),
                          TitleHeading4Widget(
                            fontSize: Dimensions.headingTextSize3,
                            color: CustomColor.primaryLightColor,
                            text:
                                "${data[index].price} ${data[index].baseCurrency}",
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: crossStart,
                        children: [
                          TitleHeading5Widget(text: Strings.renewable),
                          TitleHeading4Widget(
                            fontSize: Dimensions.headingTextSize3,
                            text: data[index].duration
                                .replaceAll('months', 'Mois')
                                .replaceAll('month', 'Mois'),
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                    ],
                  ),
                  controller.currentIndex.value != index
                      ? Container()
                      : verticalSpace(Dimensions.heightSize),
                  controller.currentIndex.value != index
                      ? Container()
                      : Row(
                          mainAxisAlignment: mainSpaceBet,
                          children: [
                            Column(
                              crossAxisAlignment: crossStart,
                              children: [
                                _texRowWidget(context, featureMap['f1'] ?? ''),
                                _texRowWidget(context, featureMap['f2'] ?? ''),
                                _texRowWidget(context, featureMap['f3'] ?? ''),
                                _texRowWidget(context, featureMap['f4'] ?? ''),
                                _texRowWidget(context, featureMap['f5'] ?? ''),
                              ],
                            ),
                            GestureDetector(
                              onTap: () {
                                controller.currentIndex.value = index;
                                if (LocalStorage.isLoggedIn()) {
                                  Get.toNamed(Routes.paymentScreen);
                                } else {
                                  Get.toNamed(
                                    Routes.signInScreen,
                                    arguments: Routes.paymentScreen,
                                  );
                                }
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: Dimensions.widthSize * 1.5,
                                  vertical: Dimensions.heightSize * .75,
                                ),
                                decoration: BoxDecoration(
                                  color: CustomColor.primaryLightColor,
                                  borderRadius: BorderRadius.circular(
                                    Dimensions.radius * 2,
                                  ),
                                ),
                                child: TitleHeading5Widget(
                                  text: Strings.subscribeNow,
                                  fontSize: Dimensions.headingTextSize6,
                                ),
                              ),
                            ),
                          ],
                        ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  _texRowWidget(context, String title) {
    return title == ''
        ? Container()
        : Row(
            children: [
              Container(
                height: 5.h,
                width: 5.w,
                decoration: const BoxDecoration(
                  color: CustomColor.whiteColor,
                  shape: BoxShape.circle,
                ),
              ),
              horizontalSpace(Dimensions.widthSize * .5),
              TitleHeading5Widget(
                text: title,
                fontWeight: FontWeight.w400,
                fontSize: Dimensions.headingTextSize6,
              ),
            ],
          );
  }
}
