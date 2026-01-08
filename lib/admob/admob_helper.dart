import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'unit_id_helper.dart';

class AdMobHelper {
  static void initialization() {
    MobileAds.instance.initialize();
  }

  /*
  SizedBox(
                height: 50,
                child: AdWidget(
                  ad: AdMobHelper.getBannerAd()..load(),
                  key: UniqueKey(),
                ),
              )
   */
  static BannerAd getBannerAd() {
    debugPrint(UnitIdHelper.bannerAdUnitId);
    BannerAd bAd = BannerAd(
      adUnitId: UnitIdHelper.bannerAdUnitId,
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_) {
          debugPrint('BannerAd has been initial}');
        },
        onAdFailedToLoad: (ad, error) {
          debugPrint('BannerAd has been crushed ${error.message}');
          ad.dispose();
        },
        onAdOpened: (Ad ad) {
          debugPrint('BannerAd has been opened}');
        },
      ),
    );
    bAd.load();
    return bAd;
  }

  static BannerAd getLargeBannerAd() {
    debugPrint(UnitIdHelper.bannerAdUnitId);
    BannerAd bAd = BannerAd(
      adUnitId: UnitIdHelper.bannerAdUnitId,
      size: AdSize.mediumRectangle,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_) {
          debugPrint('Large BannerAd has been initial}');
        },
        onAdFailedToLoad: (ad, error) {
          debugPrint('Large BannerAd has been crushed ${error.message}');
          ad.dispose();
        },
        onAdOpened: (Ad ad) {
          debugPrint('Large BannerAd has been opened}');
        },
      ),
    );
    bAd.load();
    return bAd;
  }

  /*
        await AdMobHelper.getInterstitialAdLoad();
   */
  static Future<void> getInterstitialAdLoad() {
    debugPrint(UnitIdHelper.interstitialAdUnitId);
    debugPrint('------------ InterstitialAd Load ----------');
    late InterstitialAd interstitialAd;
    return InterstitialAd.load(
      adUnitId: UnitIdHelper.interstitialAdUnitId,
      request: const AdRequest(httpTimeoutMillis: 5000),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          debugPrint('------------ InterstitialAd Started ----------');

          interstitialAd = ad;
          interstitialAd.show();

          debugPrint('------------ InterstitialAd Show ----------');

          interstitialAd.fullScreenContentCallback = FullScreenContentCallback(
            onAdFailedToShowFullScreenContent: ((ad, error) {
              ad.dispose();
              debugPrint(error.message);
            }),
            onAdDismissedFullScreenContent: (ad) {
              ad.dispose();
              interstitialAd.dispose();
            },
          );
        },
        onAdFailedToLoad: (error) {
          debugPrint('interstitial ad is not done $error');
        },
      ),
    );
  }
}
