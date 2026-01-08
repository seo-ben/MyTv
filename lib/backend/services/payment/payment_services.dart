import '../../model/common/common_success_model.dart';
import '../../model/payment/authorize_submit_method.dart';
import '../../model/payment/checkout_model.dart';
import '../../model/payment/payment_automatic_submit_model.dart';
import '../../model/payment/payment_info_model.dart';
import '../../model/payment/paypal_submit_model.dart';
import '../../model/payment/tatum_payment_gateway.dart';
import '../../utils/api_method.dart';
import '../../utils/custom_snackbar.dart';
import '../api_endpoint.dart';

class PaymentServices {
  ///* Get Watch Video info process api
  static Future<PaymentInfoModel?> getPaymentInfoApi() async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(
        isBasic: false,
      ).get(ApiEndpoint.paymentInfoURL, code: 200, showResult: true);
      if (mapResponse != null) {
        PaymentInfoModel result = PaymentInfoModel.fromJson(mapResponse);

        return result;
      }
    } catch (e) {
      log.e(
        '🐞🐞🐞 err from  Get Watch Video info process api service ==> $e 🐞🐞🐞',
      );
      CustomSnackBar.error('Something went Wrong');
      return null;
    }
    return null;
  }

  ///* automatic in api services
  static Future<PaymentSubmitAutomaticModel?> automaticPaymentSubmitApi({
    required Map<String, dynamic> body,
  }) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).post(
        ApiEndpoint.paymentAutomaticSubmitURL,
        body,
        code: 200,
        showResult: true,
      );
      if (mapResponse != null) {
        PaymentSubmitAutomaticModel result =
            PaymentSubmitAutomaticModel.fromJson(mapResponse);
        // CustomSnackBar.success(result.message.success.first.toString());
        return result;
      }
    } catch (e) {
      log.e('🐞🐞🐞 err from Sign in api service ==> $e 🐞🐞🐞');
      CustomSnackBar.error(
        'Something went Wrong! in PaymentSubmitAutomaticModel',
      );
      return null;
    }
    return null;
  }

  static Future<AuthorizeSubmitModel?> automaticAuthorizeSubmitApi({
    required Map<String, dynamic> body,
  }) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).post(
        ApiEndpoint.paymentAutomaticSubmitURL,
        body,
        code: 200,
        showResult: true,
      );
      if (mapResponse != null) {
        AuthorizeSubmitModel result = AuthorizeSubmitModel.fromJson(
          mapResponse,
        );
        // CustomSnackBar.success(result.message.success.first.toString());
        return result;
      }
    } catch (e) {
      log.e('🐞🐞🐞 err from Sign in api service ==> $e 🐞🐞🐞');
      CustomSnackBar.error('Something went Wrong! in AuthorizeSubmitModel');
      return null;
    }
    return null;
  }

  ///* automatic in api services
  static Future<PaypalSubmitModel?> paypalSubmitApi({
    required Map<String, dynamic> body,
  }) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).post(
        ApiEndpoint.paymentAutomaticSubmitURL,
        body,
        code: 200,
        showResult: true,
      );
      if (mapResponse != null) {
        PaypalSubmitModel result = PaypalSubmitModel.fromJson(mapResponse);
        // CustomSnackBar.success(result.message.success.first.toString());
        return result;
      }
    } catch (e) {
      log.e('🐞🐞🐞 err from Sign in api service ==> $e 🐞🐞🐞');
      CustomSnackBar.error('Something went Wrong! in PaypalSubmitModel');
      return null;
    }
    return null;
  }

  ///* automatic in api services
  static Future<CheckoutModel?> paymentCheckoutApi({
    required Map<String, dynamic> body,
  }) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(
        isBasic: false,
      ).post(ApiEndpoint.paymentCheckoutApi, body, code: 200, showResult: true);
      if (mapResponse != null) {
        CheckoutModel result = CheckoutModel.fromJson(mapResponse);
        // CustomSnackBar.success(result.message.success.first.toString());
        return result;
      }
    } catch (e) {
      log.e('🐞🐞🐞 err from Sign in api service ==> $e 🐞🐞🐞');
      CustomSnackBar.error('Something went Wrong! in CheckoutModel');
      return null;
    }
    return null;
  }

  static Future<TatumGatewayModel?> tatumInsertApi({
    required Map<String, dynamic> body,
  }) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).post(
        ApiEndpoint.paymentAutomaticSubmitURL,
        body,
        code: 200,
        duration: 15,
        showResult: true,
      );
      if (mapResponse != null) {
        TatumGatewayModel result = TatumGatewayModel.fromJson(mapResponse);
        // CustomSnackBar.success(result.message.success.first.toString());
        return result;
      }
    } catch (e) {
      log.e('🐞🐞🐞 err from tatum api service ==> $e 🐞🐞🐞');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }

  static Future<CommonSuccessModel?> authorizeConfirmApi({
    required Map<String, dynamic> body,
  }) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(
        isBasic: false,
      ).post(ApiEndpoint.authorizeConfirm, body, code: 200);
      if (mapResponse != null) {
        CommonSuccessModel result = CommonSuccessModel.fromJson(mapResponse);

        return result;
      }
    } catch (e) {
      log.e(
        ':ladybug::ladybug::ladybug: err from ServiceCheckout api service ==> $e :ladybug::ladybug::ladybug:',
      );
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }
}
