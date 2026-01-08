import 'dart:io';

import '../controller/basic_settings_controller.dart';
import '../utils/basic_screen_imports.dart';


final admob =   Get.find<BasicSettingsController>().admobConfig;
// class UnitIdHelper {
//   static String get bannerAdUnitId {
//     if (Platform.isAndroid) {
//       // return 'ca-app-pub-6466204473604332/1929079868';
//       return 'ca-app-pub-6466204473604332/3956477408';
//     } else if (Platform.isIOS) {
//       // return 'ca-app-pub-6466204473604332/7105384921';
//       return 'ca-app-pub-6466204473604332/9617536615';
//     }
//     else {
//       throw UnsupportedError('Unsupported platform');
//     }
//   }
//
//
//   static String get interstitialAdUnitId {
//     if (Platform.isAndroid) {
//       return 'ca-app-pub-6466204473604332/1929079868';
//     } else if (Platform.isIOS) {
//       return 'ca-app-pub-6466204473604332/7105384921';
//     }
//     else {
//       throw UnsupportedError('Unsupported platform');
//     }
//   }
// }

class UnitIdHelper {
  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return admob?.androidBannerAdunitId ?? '';
    } else if (Platform.isIOS) {
      return admob?.iosBannerAdunitId ?? '';
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return admob?.androidInterstitialAdunitId ?? "";
    } else if (Platform.isIOS) {
      return admob?.iosInterstitialAdunitId ?? "";
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }
}


/*
    <key>GADApplicationIdentifier</key>
    <string>ca-app-pub-6466204473604332~9584912874</string>


 */