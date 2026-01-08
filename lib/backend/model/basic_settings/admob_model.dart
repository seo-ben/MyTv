class AdMobModel {
  final Data data;

  AdMobModel({
    required this.data,
  });

  factory AdMobModel.fromJson(Map<String, dynamic> json) => AdMobModel(
    data: Data.fromJson(json["data"]),
  );
}

class Data {
  final AdmobConfig? admobConfig;

  Data({
    required this.admobConfig,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        admobConfig: json["admob_config"] != null
            ? AdmobConfig.fromJson(json["admob_config"])
            : null,
      );
}

class AdmobConfig {
  final String androidBannerAdunitId;
  final String iosBannerAdunitId;
  final String androidInterstitialAdunitId;
  final String iosInterstitialAdunitId;
  final String androidAppId;
  final String iosAppId;

  AdmobConfig({
    required this.androidBannerAdunitId,
    required this.iosBannerAdunitId,
    required this.androidInterstitialAdunitId,
    required this.iosInterstitialAdunitId,
    required this.androidAppId,
    required this.iosAppId,
  });

  factory AdmobConfig.fromJson(Map<String, dynamic> json) => AdmobConfig(
    androidBannerAdunitId: json["android_banner_adunit_id"],
    iosBannerAdunitId: json["ios_banner_adunit_id"],
    androidInterstitialAdunitId: json["android_interstitial_adunit_id"],
    iosInterstitialAdunitId: json["ios_interstitial_adunit_id"],
    androidAppId: json["android_app_id"],
    iosAppId: json["ios_app_id"],
  );
}