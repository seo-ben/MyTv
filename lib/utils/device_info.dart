import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';

class DeviceInfo {
  static bool isTv = false;
}

Future<void> checkAndSetDeviceType() async {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  try {
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      DeviceInfo.isTv = androidInfo.systemFeatures.contains(
        'android.software.leanback',
      );
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      // Check for Apple TV identifiers
      DeviceInfo.isTv = iosInfo.model.toLowerCase().contains('apple tv') ||
          iosInfo.model.toLowerCase().contains('tvos') ||
          iosInfo.utsname.machine.toLowerCase().contains('appletv');
    }
  } catch (e) {
    DeviceInfo.isTv = false;
  }
}
