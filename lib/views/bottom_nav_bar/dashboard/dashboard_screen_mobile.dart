import '/utils/device_info.dart';

import '/backend/services/api_endpoint.dart';
import '/backend/utils/custom_loading_api.dart';
import '/language/language_controller.dart';
import '../../../controller/drawer/subscription_log/subscription_log_controller.dart';
import '../../../controller/navbar/dashboard/dashboard_controller.dart';
import '../../../controller/video/video_player_controller.dart';
import '../../../controller/custom_ad_controller.dart';
import '../../../routes/routes.dart';
import '../../../utils/basic_screen_imports.dart';
import '../../../widgets/dashboard/carousel_slider_widget.dart';
import '../../../widgets/ads/unified_banner_ad_widget.dart';
import '../../../widgets/dashboard/live_footbal_list_widget.dart';
import '../../../widgets/dashboard/live_match_list_widget.dart';
import '../../../widgets/tv/focusable_widget.dart';
import '../../video_player_screen.dart';
import '../../youtube_video_player_screen.dart';
import 'package:MyTelevision/helpers/id_utils.dart';
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
            Get.find<CustomAdController>().getAdvertisements();
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
                              Icon(
                                Icons.play_arrow,
                                color: CustomColor.whiteColor,
                                size: DeviceInfo.isTv
                                    ? 28
                                    : null, // Increased from 18 to 28
                              ),
                              SizedBox(width: DeviceInfo.isTv ? 5.w : 5.w),
                              TitleHeading4Widget(
                                text: Strings.watchNow,
                                fontWeight: FontWeight.w500,
                                fontSize: DeviceInfo.isTv
                                    ? Dimensions.headingTextSize3
                                    : null, // Larger text on TV
                              ),
                            ],
                          ),
                          DeviceInfo.isTv
                              ? 30.w
                              : 20.w, // Increased padding for TV
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
                verticalSpace(
                  Dimensions.heightSize * (DeviceInfo.isTv ? 3 : 1),
                ),
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
                                ? (DeviceInfo.isTv ? 4.2.w : 6.0.w)
                                : (DeviceInfo.isTv ? 2.8.w : 4.0.w),
                            height: controller.currentIndex.value == index
                                ? (DeviceInfo.isTv ? 4.2.h : 6.0.h)
                                : (DeviceInfo.isTv ? 2.8.h : 4.0.h),
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
                Obx(
                  () => Get.find<CustomAdController>().bannerAds.isNotEmpty
                      ? Column(
                          children: [
                            showAdd(context),
                            verticalSpace(Dimensions.heightSize),
                          ],
                        )
                      : const SizedBox.shrink(),
                ),
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
                Obx(
                  () => Get.find<CustomAdController>().bannerAds.isNotEmpty
                      ? showAdd(context)
                      : const SizedBox.shrink(),
                ),
                _liveMatchWidget(context),
                verticalSpace(Dimensions.heightSize * 10),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: DeviceInfo.isTv
              ? 60.h
              : (35.h + MediaQuery.of(context).padding.bottom),
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: DeviceInfo.isTv ? 6.h : 10.h,
              horizontal: DeviceInfo.isTv ? 12.w : 19.w,
            ),
            decoration: BoxDecoration(
              color: CustomColor.buttonDeepColor,
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Row(
              children: [
                FocusableWidget(
                  onPressed: () {
                    Get.toNamed(Routes.liveScreen);
                  },
                  focusColor: CustomColor.primaryLightColor,
                  borderRadius: BorderRadius.circular(8.r),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.w,
                      vertical: 4.h,
                    ),
                    child: TitleHeading4Widget(text: Strings.liveSports),
                  ),
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
                FocusableWidget(
                  onPressed: () {
                    Get.toNamed(Routes.highlightScreen);
                  },
                  focusColor: CustomColor.primaryLightColor,
                  borderRadius: BorderRadius.circular(8.r),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.w,
                      vertical: 4.h,
                    ),
                    child: TitleHeading4Widget(text: Strings.highlights),
                  ),
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
              (index % 2 == 0 &&
                      index ~/ 2 < adData.length &&
                      adData[index ~/ 2].image.isNotEmpty)
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
                  : const SizedBox.shrink(),
            ],
          );
        },
      ),
    );
  }

  Widget _buttonWidget(
    BuildContext context,
    Widget widget,
    double padding,
    VoidCallback onTap,
  ) {
    return FocusableWidget(
      autofocus: DeviceInfo.isTv,
      onPressed: onTap,
      focusColor: CustomColor.primaryLightColor,
      borderRadius: BorderRadius.circular(8.r),
      child: Container(
        height: DeviceInfo.isTv
            ? 50.h
            : 40.h, // Increased from 32.h to 50.h for TV
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
      child: const UnifiedBannerAdWidget(isLarge: true),
    );
  }

  void _navigateToPlayer(Datum sportItem) {
    debugPrint(
      '🧭 dashboard._navigateToPlayer raw id=${sportItem.id} sports_id=${sportItem.sportsId} link=${sportItem.link} buttonName=${sportItem.buttonName}',
    );
    final normalizedId = normalizeAndLogId(
      sportItem.sportsId ?? sportItem.id,
      source: 'dashboard_screen_mobile',
    );
    debugPrint('🧭 dashboard._navigateToPlayer normalized id=$normalizedId');
    if (sportItem.link.contains("youtube")) {
      Get.to(
        YoutubeVideoPlayer(
          url: sportItem.link,
          name: sportItem.buttonName ?? "",
          title: "",
          description: "",
          id: normalizedId,
        ),
      );
    } else {
      Get.to(
        VideoPlayerScreen(
          url: sportItem.link,
          name: sportItem.buttonName ?? "",
          title: "",
          description: "",
          id: normalizedId,
        ),
      );
    }
  }
}
