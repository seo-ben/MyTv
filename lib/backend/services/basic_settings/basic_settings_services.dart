import '../../model/basic_settings/admob_model.dart';
import '../../model/basic_settings/basic_settings_model.dart';
import '../../utils/api_method.dart';
import '../../utils/custom_snackbar.dart';
import '../api_endpoint.dart';

mixin BasicSettingsApiServices {
  ///* Basic settings get api process
  Future<BasicSettingsInfoModel?> getBasicSettingProcessApi() async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: true).get(
        ApiEndpoint.basicSettingsURL,
        code: 200,
        showResult: true,
        duration: 300,
      );
      if (mapResponse != null) {
        BasicSettingsInfoModel result =
            BasicSettingsInfoModel.fromJson(mapResponse);
        return result;
      }
    } catch (e) {
      log.e(
          '🐞🐞🐞 err from Basic settings get process api service ==> $e 🐞🐞🐞');
      CustomSnackBar.error('Something went Wrong! in BasicSettingsInfoModel');
      return null;
    }
    return null;
  }



  ///* Get AdMobModel api services
  Future<AdMobModel?> adMobModelProcessApi() async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: true).get(
        ApiEndpoint.admobURL,
      );
      if (mapResponse != null) {
        AdMobModel result = AdMobModel.fromJson(mapResponse);
        // CustomSnackBar.success(result.message.success.first.toString());
        return result;
      }
    } catch (e) {
      log.e(':ladybug::ladybug::ladybug: err from AdMobModel api service ==> $e :ladybug::ladybug::ladybug:');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }


}
