import 'dart:async';

import '../../backend/services/api_endpoint.dart';
import '../../backend/utils/api_method.dart';
import '../../utils/basic_screen_imports.dart';
import '../backend/model/basic_settings/admob_model.dart';
import '../backend/model/basic_settings/basic_settings_model.dart';
import '../backend/services/basic_settings/basic_settings_services.dart';
import 'package:MyTelevision/custom_assets/assets.gen.dart';

class BasicSettingsController extends GetxController
    with BasicSettingsApiServices {
  RxString splashImage = ''.obs;
  RxString onboardImage = ''.obs;
  RxString onBoardTitle = ''.obs;
  RxString onBoardSubTitle = ''.obs;
  RxString appBasicLogoWhite = ''.obs;
  RxString appBasicLogoDark = ''.obs;
  RxString privacyPolicy = ''.obs;
  RxString contactUs = ''.obs;
  RxString aboutUs = ''.obs;
  RxString path = ''.obs;
  RxBool isVisible = false.obs;
  @override
  void onInit() {
    adMobModelProcess();
    getBasicSettingsApiProcess().then((value) {
      isVisible.value = true;
      // Navigation is now handled by dynamic initialRoute in main.dart
    });
    super.onInit();
  }

  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;
  // Made nullable to avoid LateInitializationError
  BasicSettingsInfoModel? _appSettingsModel;

  // Safe accessor - returns null (should handle in UI) or throws user-friendly error
  BasicSettingsInfoModel get appSettingsModel {
    return _appSettingsModel!;
  }

  // Helper to check if model is loaded
  bool get isSettingsLoaded => _appSettingsModel != null;

  Future<BasicSettingsInfoModel?> getBasicSettingsApiProcess() async {
    _isLoading.value = true;
    update();
    try {
      final value = await getBasicSettingProcessApi();
      if (value != null) {
        _appSettingsModel = value;
        saveInfo();
      }
    } catch (onError) {
      log.e(onError);
      // Ensure we don't crash if network fails, but _appSettingsModel remains null
    }
    _isLoading.value = false;
    update();
    return _appSettingsModel;
  }

  void saveInfo() {
    if (_appSettingsModel == null) return;

    /// >>> get splash & onboard data
    var imageSplash = _appSettingsModel!.data.splashScreen.image;
    var imagePath = _appSettingsModel!.data.appImagePaths.pathLocation;
    splashImage.value = "${ApiEndpoint.mainDomain}/$imagePath/$imageSplash";

    path.value =
        "${ApiEndpoint.mainDomain}/${_appSettingsModel!.data.appImagePaths.pathLocation}/";

    final basicSettings = _appSettingsModel!.data.basicSettings;

    if (basicSettings.siteLogo == '') {
       appBasicLogoWhite.value = Assets.logo.logoPng.path;
 
       appBasicLogoDark.value = appBasicLogoWhite.value;
     } else {
       appBasicLogoWhite.value = Assets.logo.logoPng.path;
       appBasicLogoDark.value = Assets.logo.logoPng.path;
     }

    Strings.appName = basicSettings.siteName;
  }

  /// ------------------------------------- >>
  final _isAdmobLoading = false.obs;
  bool get isAdmobLoading => _isAdmobLoading.value;

  late AdMobModel _adMobModel;
  AdMobModel get adMobModel => _adMobModel;

  AdmobConfig? admobConfig;

  ///* Get AdMobModel in process
  Future<AdMobModel> adMobModelProcess() async {
    _isAdmobLoading.value = true;
    update();
    await adMobModelProcessApi()
        .then((value) {
          _adMobModel = value!;
          admobConfig = _adMobModel.data.admobConfig;
          _isAdmobLoading.value = false;
          update();
        })
        .catchError((onError) {
          log.e(onError);
        });
    _isAdmobLoading.value = false;
    update();
    return _adMobModel;
  }
}
