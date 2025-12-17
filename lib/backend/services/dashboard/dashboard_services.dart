import '../../model/dashboard/dashboard_model.dart';
import '../../model/dashboard/home_info_model.dart';
import '../../model/dashboard/my_subscription_info_model.dart';
import '../../utils/api_method.dart';
import '../../utils/custom_snackbar.dart';
import '../api_endpoint.dart';

class DashboardServices {
  ///* Get profile info process api
  static Future<DashboardModel?> getProfileInfoProcessApi() async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false)
          .get(ApiEndpoint.dashboardURL, code: 200, showResult: true);
      if (mapResponse != null) {
        DashboardModel result = DashboardModel.fromJson(mapResponse);

        return result;
      }
    } catch (e) {
      log.e(
          '🐞🐞🐞 err from  Get profile info process api service ==> $e 🐞🐞🐞');
      CustomSnackBar.error('Something went Wrong');
      return null;
    }
    return null;
  }

  ///* Get home info process api
  static Future<HomeInfoModel?> getHomeInfoApi(String newLanguage) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false)
          .get("${ApiEndpoint.homeURL}?lang=$newLanguage", code: 200, showResult: true);
      if (mapResponse != null) {
        HomeInfoModel result = HomeInfoModel.fromJson(mapResponse);

        return result;
      }
    } catch (e) {
      log.e('🐞🐞🐞 err from  Get home info process api service ==> $e 🐞🐞🐞');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }

  ///* Get subscription info process api
  static Future<MySubscriptionInfoModel?> getSubscriptionInfoApi(String newLanguage) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false)
          .get("${ApiEndpoint.subscriptionURL}?lang=$newLanguage", code: 200, showResult: true);
      if (mapResponse != null) {
        MySubscriptionInfoModel result =
            MySubscriptionInfoModel.fromJson(mapResponse);

        return result;
      }
    } catch (e) {
      log.e(
          '🐞🐞🐞 err from  Get subscription info process api service ==> $e 🐞🐞🐞');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }
}
