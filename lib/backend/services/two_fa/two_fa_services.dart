import 'package:get_storage/get_storage.dart';

import '../../model/common/common_success_model.dart';
import '../../model/drawer/two_fa/two_fa_model.dart';
import '../../utils/api_method.dart';
import '../../utils/custom_snackbar.dart';
import '../api_endpoint.dart';

class TwoFaApiServices {
  ///* Two fa get process api
  static Future<TwoFaInfoModel?> twoFaGetApiProcess() async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).get(
          "${ApiEndpoint.twoFaGetURL}?lang=${GetStorage().read('selectedLanguage')}",
          code: 200,
          showResult: true);
      if (mapResponse != null) {
        TwoFaInfoModel result = TwoFaInfoModel.fromJson(mapResponse);

        return result;
      }
    } catch (e) {
      log.e('🐞🐞🐞 err from Two fa get process api service ==> $e 🐞🐞🐞');
      CustomSnackBar.error("Something went wrong in Two Fa Model!");
      return null;
    }
    return null;
  }

  ///* Two fa submit process api
  static Future<CommonSuccessModel?> twoFaSubmitApiProcess(
      {required Map<String, dynamic> body}) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).post(
        ApiEndpoint.twoFaSubmitURL,
        body,
        code: 200,
      );
      if (mapResponse != null) {
        CommonSuccessModel result = CommonSuccessModel.fromJson(mapResponse);
        return result;
      }
    } catch (e) {
      log.e('🐞🐞🐞 err from Two fa submit process api service ==> $e 🐞🐞🐞');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }
}
