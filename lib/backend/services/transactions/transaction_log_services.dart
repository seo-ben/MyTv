import '../../../utils/basic_screen_imports.dart';
import '../../model/drawer/transaction/transaction_log_model.dart';
import '../../utils/api_method.dart';
import '../../utils/custom_snackbar.dart';
import '../api_endpoint.dart';

mixin TransactionApiServices {
  ///* Get Transaction api services
  Future<TransactionModel?> transactionGetApi() async {
    Map<String, dynamic>? mapResponse;
    try {
      debugPrint("data get");
      mapResponse = await ApiMethod(isBasic: false).get(
        ApiEndpoint.transactionUrl,
        showResult: true,
      );
      if (mapResponse != null) {
        TransactionModel result = TransactionModel.fromJson(mapResponse);

        return result;
      }
    } catch (e) {
      log.e('🐞🐞🐞 err from Transaction api service ==> $e 🐞🐞🐞');
      CustomSnackBar.error("Something went wrong in Transaction Model");
      return null;
    }
    return null;
  }

  // Future<TatumPaymentInfoModel?> tatumInfoGetAPI(String trx) async {
  //   Map<String, dynamic>? mapResponse;
  //   try {
  //     mapResponse = await ApiMethod(isBasic: false).get(
  //       "${ApiEndpoint.tatumInfoUrl}$trx",
  //       showResult: true,
  //     );
  //     if (mapResponse != null) {
  //       TatumPaymentInfoModel result =
  //       TatumPaymentInfoModel.fromJson(mapResponse);
  //       CustomSnackBar.success(result.message.success.first.toString());
  //       return result;
  //     }
  //   } catch (e) {
  //     log.e('🐞🐞🐞 err from Transaction api service ==> $e 🐞🐞🐞');
  //     CustomSnackBar.error(Get.find<LanguageController>()
  //         .getTranslation(Strings.somethingWentWrong));
  //     return null;
  //   }
  //   return null;
  // }
  //
  // ///* AddMoneyTatumSubmit api services
  // Future<CommonSuccessModel?> addMoneyTatumSubmitProcessApi(
  //     {required Map<String, String> body, required String url}) async {
  //   Map<String, dynamic>? mapResponse;
  //   try {
  //     mapResponse = await ApiMethod(isBasic: false).post(url, body);
  //     if (mapResponse != null) {
  //       CommonSuccessModel result = CommonSuccessModel.fromJson(mapResponse);
  //       return result;
  //     }
  //   } catch (e) {
  //     log.e(
  //         ':ladybug::ladybug::ladybug: err from AddMoneyManualSubmit api service ==> $e :ladybug::ladybug::ladybug:');
  //     CustomSnackBar.error(Get.find<LanguageController>()
  //         .getTranslation(Strings.somethingWentWrong));
  //     return null;
  //   }
  //   return null;
  // }
}
