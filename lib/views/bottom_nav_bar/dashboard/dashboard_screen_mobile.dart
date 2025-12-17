import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../../admob/admob_helper.dart';
import '/backend/services/api_endpoint.dart';
import '/backend/utils/custom_loading_api.dart';
import '/language/language_controller.dart';
import '../../../controller/drawer/subscription_log/subscription_log_controller.dart';
import '../../../controller/navbar/dashboard/dashboard_controller.dart';
import '../../../controller/video/video_player_controller.dart';
import '../../../routes/routes.dart';
import '../../../utils/basic_screen_imports.dart';
import '../../../widgets/dashboard/carousel_slider_widget.dart';
import '../../../widgets/dashboard/live_footbal_list_widget.dart';
import '../../../widgets/dashboard/live_match_list_widget.dart';
import '../../video_player_screen.dart';
import '../../youtube_video_player_screen.dart';
import '../../../backend/model/dashboard/home_info_model.dart';

class DashboardScreenMobile extends StatelessWidget {
  DashboardScreenMobile({super.key});
  final controller = Get.put(DashboardController());
  final videoController = Get.put(CustomVideoPlayerController());
  final subscriptionLogController = Get.put(SubscriptionLogController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: CustomColor.primaryLightScaffoldBackgroundColor,
      body: Obx(
        () =>
            controller.isLoading ||
                controller.isSubscribeLoading ||
                subscriptionLogController.isLoading
            ? const CustomLoadingAPI()
            : _bodyWidget(context),
      ),
    );
  }

  Stack _bodyWidget(BuildContext context) {
    var imagePath =
        "${ApiEndpoint.mainDomain}/${controller.homeInfoModel.data.siteSection}";
    var data = controller.homeInfoModel.data.footballSectionData;
    var data1 = controller.homeInfoModel.data.carousalData;
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        RefreshIndicator(
          color: CustomColor.primaryLightColor,
          onRefresh: () async {
            controller.getHomeInfoProcess();
          },
          child: SingleChildScrollView(
            controller: controller.scrollController,
            child: Column(
              mainAxisAlignment: mainStart,
              crossAxisAlignment: crossStart,
              children: [
                CarouselSliderWidget(),
                verticalSpace(Dimensions.heightSize),
                Column(
                  crossAxisAlignment: crossCenter,
                  children: [
                    Row(
                      mainAxisAlignment: mainCenter,
                      children: [
                        _buttonWidget(
                          context,
                          Row(
                            mainAxisAlignment: mainCenter,
                            crossAxisAlignment: crossCenter,
                            children: [
                              const Icon(
                                Icons.play_arrow,
                                color: CustomColor.whiteColor,
                              ),
                              SizedBox(width: 5.w),
                              TitleHeading4Widget(
                                text: Strings.watchNow,
                                fontWeight: FontWeight.w500,
                              ),
                            ],
                          ),
                          20.w,
                          () {
                            // Direct navigation for Watch Now button (Guest Access)
                            _navigateToPlayer(
                              data1[controller.currentIndex.value],
                            );
                          },
                        ),
                        horizontalSpace(8.w),
                        // _buttonWidget(
                        //   context,
                        //   Icon(
                        //     Icons.share,
                        //     color: CustomColor.whiteColor,
                        //     size: 20.h,
                        //   ),
                        //   10.w,
                        //   () {
                        //     SharePlus.instance.share(
                        //       ShareParams(
                        //         text: data1[controller.currentIndex.value].link,
                        //       ),
                        //     );
                        //   },
                        // ),
                      ],
                    ),
                  ],
                ),
                verticalSpace(Dimensions.heightSize),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: controller.homeInfoModel.data.carousalData
                      .asMap()
                      .entries
                      .map((entry) {
                        final index = entry.key;
                        return Obx(
                          () => Container(
                            width: controller.currentIndex.value == index
                                ? 6.0.w
                                : 4.0.w,
                            height: controller.currentIndex.value == index
                                ? 6.0.h
                                : 4.0.h,
                            margin: const EdgeInsets.symmetric(horizontal: 4.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: controller.currentIndex.value == index
                                  ? Colors.white
                                  : CustomColor.boxColor,
                            ),
                          ),
                        );
                      })
                      .toList(),
                ),
                // showAdd(context),
                verticalSpace(Dimensions.heightSize),
                Padding(
                  padding: EdgeInsets.only(left: Dimensions.widthSize * 1.5),
                  child: LiveFootballListWidget(
                    title: Get.find<LanguageController>().getTranslation(
                      Strings.popularInFootball,
                    ),
                    sport: data,
                    imagePath: imagePath,
                  ),
                ),
                // showAdd(context),
                _liveMatchWidget(context),
                // showAdd(context),
                verticalSpace(Dimensions.heightSize * 8),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 80.h,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 19.w),
            decoration: BoxDecoration(
              color: CustomColor.buttonDeepColor,
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Get.toNamed(Routes.liveScreen);
                  },
                  child: TitleHeading4Widget(text: Strings.liveSports),
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: Dimensions.widthSize,
                  ),
                  height: 16.h,
                  decoration: BoxDecoration(
                    border: Border.all(color: CustomColor.boxColor),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(Routes.highlightScreen);
                  },
                  child: TitleHeading4Widget(text: Strings.highlights),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  SizedBox _liveMatchWidget(BuildContext context) {
    var data = controller.homeInfoModel.data.sportsCategory;
    var imagePath =
        "${ApiEndpoint.mainDomain}/${controller.homeInfoModel.data.categorySection}";

    var adImagePath =
        "${ApiEndpoint.mainDomain}/${controller.homeInfoModel.data.siteSection}";
    var adData = controller.homeInfoModel.data.adData;

    return SizedBox(
      child: ListView.builder(
        itemCount: data.length,
        shrinkWrap: true,
        padding: EdgeInsets.only(
          left: Dimensions.widthSize * 1.5,
          top: Dimensions.heightSize * 1,
        ),
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Column(
            children: [
              LiveMatchListWidget(
                title: data[index].title,
                sport: data[index].sports,
                imagePath: imagePath,
              ).paddingOnly(bottom: Dimensions.heightSize),
              (index % 2 == 0 && index ~/ 2 < adData.length)
                  ? Container(
                      height: Dimensions.heightSize * 5,
                      margin: EdgeInsets.only(
                        bottom: Dimensions.heightSize,
                        right: Dimensions.widthSize * 1.5,
                      ),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                            "$adImagePath/${adData[index ~/ 2].image}",
                          ),
                          fit: BoxFit.contain,
                        ),
                        borderRadius: BorderRadius.circular(Dimensions.radius),
                      ),
                    )
                  : Container(),
            ],
          );
        },
      ),
    );
  }

  InkWell _buttonWidget(
    BuildContext context,
    Widget widget,
    double padding,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 40.h,
        padding: EdgeInsets.symmetric(horizontal: padding),
        decoration: BoxDecoration(
          color: CustomColor.buttonDeepColor,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: widget,
      ),
    );
  }

  Padding showAdd(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: Dimensions.paddingHorizontalSize * .6,
        right: Dimensions.paddingHorizontalSize * .6,
        top: Dimensions.paddingVerticalSize * .5,
      ),
      child: SizedBox(
        height: 50,
        child: AdWidget(
          ad: AdMobHelper.getBannerAd()..load(),
          key: UniqueKey(),
        ),
      ),
    );
  }

  void _navigateToPlayer(Datum sportItem) {
    if (sportItem.link.contains("youtube")) {
      Get.to(
        YoutubeVideoPlayer(
          url: sportItem.link,
          name: sportItem.buttonName ?? "",
          title: "",
          description: "",
          id: sportItem.id.toString(),
        ),
      );
    } else {
      Get.to(
        VideoPlayerScreen(
          url: sportItem.link,
          name: sportItem.buttonName ?? "",
          title: "",
          description: "",
          id: sportItem.id.toString(),
        ),
      );
    }
  }
}
