import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../backend/model/authorization/custom_advertisement_model.dart';
import '../backend/services/api_endpoint.dart';
import '../backend/utils/api_method.dart';
// ignore: depend_on_referenced_packages
import 'package:url_launcher/url_launcher.dart' as launcher;
import '../widgets/ads/custom_interstitial_ad_widget.dart';

class CustomAdController extends GetxController {
  RxList<CustomAd> bannerAds = <CustomAd>[].obs;
  RxList<CustomAd> interstitialAds = <CustomAd>[].obs;
  RxList<CustomAd> videoAds = <CustomAd>[].obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    print(
      "🚀 [CustomAdController] Controller Initialized! Calling getAdvertisements...",
    );
    getAdvertisements();
  }

  Future<void> getAdvertisements() async {
    isLoading.value = true;

    // String platform = Platform.isAndroid ? 'android' : 'ios';

    try {
      // Removing platform filter for debugging to ensure we get ANY ads
      String url = ApiEndpoint.getAdvertisements;
      // print("📢 [CustomAdController] Fetching Ads from: $url");

      // Use bearerHeaderInfo (isBasic: false) to include Authorization header for subscribers
      var response = await ApiMethod(isBasic: false).get(url, code: 200);
      // print("📢 [CustomAdController] Ads Response: $response");

      if (response != null && response['data'] != null) {
        var adModel = CustomAdvertisementModel.fromJson(response['data']);

        // SHOW ON SCREEN DEBUGGING
        // CustomSnackBar.success(
        //   "DEBUG: Fetched ${adModel.advertisements.length} ads from API",
        // );

        // print(
        //   "📢 [CustomAdController] Raw Ads Count: ${adModel.advertisements.length}",
        // );
        // for (var ad in adModel.advertisements) {
        //   print(
        //     "👉 Ad ID: ${ad.id}, Type: '${ad.type}', Platform: '${ad.platform}'",
        //   );
        // }

        bannerAds.assignAll(
          adModel.advertisements
              .where((ad) => ad.type.toLowerCase() == 'banner')
              .toList(),
        );

        print(
          "✅ [CustomAdController] Banner Ads (filtered): ${bannerAds.length}",
        );

        interstitialAds.assignAll(
          adModel.advertisements
              .where((ad) => ad.type.toLowerCase() == 'interstitial')
              .toList(),
        );
        print(
          "✅ [CustomAdController] Interstitial Ads (filtered): ${interstitialAds.length}",
        );

        videoAds.assignAll(
          adModel.advertisements
              .where((ad) => ad.type.toLowerCase() == 'video')
              .toList(),
        );
        print(
          "✅ [CustomAdController] Video Ads (filtered): ${videoAds.length}",
        );

        update();
      } else {
        print("⚠️ [CustomAdController] Ads Response was null or missing data");
      }
    } catch (e) {
      print("❌ [CustomAdController] Error fetching ads: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> recordAdView(int adId) async {
    // Temporarily disabled - backend endpoint returns 301 redirect
    // TODO: Verify backend endpoint exists at: POST /api/v1/advertisements/{id}/view
    return;

    /* try {
      await ApiMethod(isBasic: false).post(
        "${ApiEndpoint.recordAdView}$adId/view",
        <String, dynamic>{},
        code: 200,
      );
    } catch (e) {
      // Silently fail - tracking is optional
      debugPrint("⚠️ Ad view tracking failed (non-critical): $e");
    } */
  }

  Future<void> recordAdClick(int adId) async {
    // Temporarily disabled - backend endpoint returns 301 redirect
    // TODO: Verify backend endpoint exists at: POST /api/v1/advertisements/{id}/click
    return;

    /* try {
      await ApiMethod(isBasic: false).post(
        "${ApiEndpoint.recordAdClick}$adId/click",
        <String, dynamic>{},
        code: 200,
      );
    } catch (e) {
      // Silently fail - tracking is optional
      debugPrint("⚠️ Ad click tracking failed (non-critical): $e");
    } */
  }

  void onAdClicked(CustomAd ad) async {
    print("📢 [CustomAdController] Ad Clicked: ${ad.clickUrl}");
    if (ad.clickUrl != null &&
        await launcher.canLaunchUrl(Uri.parse(ad.clickUrl!))) {
      recordAdClick(ad.id);
      await launcher.launchUrl(
        Uri.parse(ad.clickUrl!),
        mode: launcher.LaunchMode.externalApplication,
      );
    }
  }

  // Method to show an Interstitial Ad
  void showInterstitialAd(BuildContext context) {
    if (interstitialAds.isNotEmpty) {
      // Pick a random ad from the list
      final randomIndex = interstitialAds.length > 1
          ? DateTime.now().millisecondsSinceEpoch % interstitialAds.length
          : 0;
      CustomAd ad = interstitialAds[randomIndex];

      Get.dialog(
        CustomInterstitialAdWidget(ad: ad),
        barrierDismissible:
            false, // Force user to interact with the Close button
        useSafeArea: false,
      );
    }
  }
}
