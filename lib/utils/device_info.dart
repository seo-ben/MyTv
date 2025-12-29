import 'package:device_info_plus/device_info_plus.dart';

class DeviceInfo {
  static bool isTv = false;
}

Future<void> checkAndSetIsAndroidTV() async {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  AndroidDeviceInfo androidInfo;
  try {
    androidInfo = await deviceInfo.androidInfo;
    DeviceInfo.isTv = androidInfo.systemFeatures.contains(
      'android.software.leanback',
    );
  } catch (e) {
    DeviceInfo.isTv = false;
  }
}
