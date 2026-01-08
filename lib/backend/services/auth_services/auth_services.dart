import '/backend/local_storage/local_storage.dart';
import '../../model/auth/sign_in/forget_password/forget_password_model.dart';
import '../../model/auth/sign_in/sign_in_model.dart';
import '../../model/auth/sign_up/sign_up_model.dart';
import '../../model/common/common_success_model.dart';
import '../../utils/api_method.dart';
import '../../utils/custom_snackbar.dart';
import '../api_endpoint.dart';

class AuthApiServices {
  ///* Sign in api services
  static Future<LogInModel?> signInProcessApi(
      {required Map<String, dynamic> body}) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: true).post(
        ApiEndpoint.loginURL,
        body,
        code: 200,
        showResult: true,
      );
      if (mapResponse != null) {
        LogInModel result = LogInModel.fromJson(mapResponse);
        // CustomSnackBar.success(result.message.success.first.toString());
        return result;
      }
    } catch (e) {
      log.e('🐞🐞🐞 err from Sign in api service ==> $e 🐞🐞🐞');
      CustomSnackBar.error('Something went Wrong! in LogInModel');
      return null;
    }
    return null;
  }

  ///* Forgot Password Process Api
  static Future<ForgotPasswordModel?> forgotPasswordProcessApi(
      {required Map<String, dynamic> body}) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: true).post(
        ApiEndpoint.forgotPasswordSendOtpURL,
        code: 200,
        showResult: true,
        body,
      );
      if (mapResponse != null) {
        ForgotPasswordModel result = ForgotPasswordModel.fromJson(mapResponse);
        CustomSnackBar.success(
          result.message.success.first.toString(),
        );
        return result;
      }
    } catch (e) {
      log.e('🐞🐞🐞 err from forgot password api service ==> $e 🐞🐞🐞');
      CustomSnackBar.error('Something went Wrong! in forgotPasswordModel');
      return null;
    }
    return null;
  }

  ///* Forgot password otp verify process api
  static Future<ForgotPasswordModel?> forgetPassVerifyOTPApi(
      {required Map<String, dynamic> body}) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: true).post(
        ApiEndpoint.forgotOtpVerifyURL,
        body,
        code: 200,
      );
      if (mapResponse != null) {
        ForgotPasswordModel result = ForgotPasswordModel.fromJson(mapResponse);
        return result;
      }
    } catch (e) {
      log.e(
          '🐞🐞🐞 err from Forgot password otp verify process api service ==> $e 🐞🐞🐞');
      CustomSnackBar.error('Something went Wrong! in ForgotPasswordModel');
      return null;
    }
    return null;
  }

  ///* Two fa otp verify process api
  static Future<CommonSuccessModel?> twoFaVerifyOTPApi(
      {required Map<String, dynamic> body}) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).post(
        ApiEndpoint.twoFaOtoVerifyURL,
        body,
        code: 200,
      );
      if (mapResponse != null) {
        CommonSuccessModel result = CommonSuccessModel.fromJson(mapResponse);
        return result;
      }
    } catch (e) {
      log.e(
          '🐞🐞🐞 err from Two fa otp verify process api service ==> $e 🐞🐞🐞');
      CustomSnackBar.error("Something went wrong in Two Fa Model");
      return null;
    }
    return null;
  }

  ///* Reset password process api
  static Future<CommonSuccessModel?> resetPasswordApi(
      {required Map<String, dynamic> body}) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: true).post(
        ApiEndpoint.resetPasswordURL,
        body,
        code: 200,
      );
      if (mapResponse != null) {
        CommonSuccessModel result = CommonSuccessModel.fromJson(mapResponse);

        return result;
      }
    } catch (e) {
      log.e('🐞🐞🐞 err from Reset password process api service ==> $e 🐞🐞🐞');
      CustomSnackBar.error(
          'Something went Wrong! in Reset password process api');
      return null;
    }
    return null;
  }

  ///* Change password process api
  static Future<CommonSuccessModel?> changePasswordApi(
      {required Map<String, dynamic> body}) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).post(
        ApiEndpoint.changePasswordURL,
        body,
        code: 200,
      );
      if (mapResponse != null) {
        CommonSuccessModel result = CommonSuccessModel.fromJson(mapResponse);
        CustomSnackBar.success(result.message.success.first.toString());

        return result;
      }
    } catch (e) {
      log.e(
          '🐞🐞🐞 err from Change password process api service ==> $e 🐞🐞🐞');
      CustomSnackBar.error(
          'Something went Wrong! in Change password process api');
      return null;
    }
    return null;
  }

  ///______________________________  SIGN UP API PROCESS _____________________________

  ///* Sign up process api
  static Future<RegisterModel?> signUpProcessApi(
      {required Map<String, dynamic> body}) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: true).post(
        ApiEndpoint.registerURL,
        body,
        code: 200,
      );
      if (mapResponse != null) {
        RegisterModel result = RegisterModel.fromJson(mapResponse);
        return result;
      }
    } catch (e) {
      log.e('🐞🐞🐞 err from Sign up api service ==> $e 🐞🐞🐞');
      CustomSnackBar.error('Something went Wrong! in RegisterModel');
      return null;
    }
    return null;
  }

  ///* Email otp verify process api
  static Future<CommonSuccessModel?> emailOtpVerifyApi(
      {required Map<String, dynamic> body}) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).post(
        ApiEndpoint.registerOtpVerifyURL,
        body,
        code: 200,
      );
      if (mapResponse != null) {
        CommonSuccessModel result = CommonSuccessModel.fromJson(mapResponse);

        return result;
      }
    } catch (e) {
      log.e(
          '🐞🐞🐞 err from Email otp verify process api service ==> $e 🐞🐞🐞');
      CustomSnackBar.error(
          'Something went Wrong! in Email otp verify process api');
      return null;
    }
    return null;
  }

  ///* Email resend otp process api
  static Future<CommonSuccessModel?> emailResendProcessApi(
      String userToken) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).get(
        "${ApiEndpoint.registerOtpResendURL}$userToken",
        code: 200,
      );
      if (mapResponse != null) {
        CommonSuccessModel result = CommonSuccessModel.fromJson(mapResponse);
        return result;
      }
    } catch (e) {
      log.e(
          '🐞🐞🐞 err from  Email resend otp process api service ==> $e 🐞🐞🐞');
      CustomSnackBar.error(
          'Something went Wrong! in Email resend otp process api');
      return null;
    }
    return null;
  }

  ///* Reset resend otp process api
  static Future<ForgotPasswordModel?> resetPasswordResendOtpProcessApi() async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: true).get(
        "${ApiEndpoint.resendOtpCodeURL}${LocalStorage.getToken()}",
        showResult: true,
        code: 200,
      );
      if (mapResponse != null) {
        ForgotPasswordModel result = ForgotPasswordModel.fromJson(mapResponse);
        return result;
      }
    } catch (e) {
      log.e(
          '🐞🐞🐞 err from  Email Reset otp process api service ==> $e 🐞🐞🐞');
      CustomSnackBar.error(
          'Something went Wrong! in Email Reset otp process api');
      return null;
    }
    return null;
  }

  ///  Sign out process api
  static Future<CommonSuccessModel?> signOutProcessApi() async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false)
          .post(ApiEndpoint.logOutURL, {}, code: 200);
      if (mapResponse != null) {
        CommonSuccessModel result = CommonSuccessModel.fromJson(mapResponse);

        return result;
      }
    } catch (e) {
      log.e('err from Sign out process api service ==> $e');
      CustomSnackBar.error("Something went wrong in Sign Out Model");
      return null;
    }
    return null;
  }

  ///* ChangeLanguage api services
  // static Future<CommonSuccessModel?> changeLanguageProcessApi(
  //     {required Map<String, dynamic> body}) async {
  //   Map<String, dynamic>? mapResponse;
  //   try {
  //     mapResponse = await ApiMethod(isBasic: false).post(
  //       ApiEndpoint.changeProfilePasswordURL,
  //       body,
  //     );
  //     if (mapResponse != null) {
  //       CommonSuccessModel result = CommonSuccessModel.fromJson(mapResponse);
  //       CustomSnackBar.success(result.message.success.first.toString());
  //       return result;
  //     }
  //   } catch (e) {
  //     log.e(
  //         ':ladybug::ladybug::ladybug: err from ChangeLanguage api service ==> $e :ladybug::ladybug::ladybug:');
  //     CustomSnackBar.error(Get.find<LanguageController>()
  //         .getTranslation(Strings.somethingWentWrong));
  //     return null;
  //   }
  //   return null;
  // }

  ///* Get KycInputFieldInfo api services
  // static Future<KycInputFieldInfoModel?>
  //     kycInputFieldInfoGetProcessApi() async {
  //   Map<String, dynamic>? mapResponse;
  //   try {
  //     mapResponse = await ApiMethod(isBasic: false).get(
  //       ApiEndpoint.kycInputFieldsUrl,
  //     );
  //     if (mapResponse != null) {
  //       KycInputFieldInfoModel result =
  //           KycInputFieldInfoModel.fromJson(mapResponse);
  //
  //       return result;
  //     }
  //   } catch (e) {
  //     log.e(
  //         ':ladybug::ladybug::ladybug: err from KycInputFieldInfo api service ==> $e :ladybug::ladybug::ladybug:');
  //     CustomSnackBar.error(Get.find<LanguageController>()
  //         .getTranslation(Strings.somethingWentWrong));
  //     return null;
  //   }
  //   return null;
  // }

  ///* Kyc submit process api
  static Future<CommonSuccessModel?> kycSubmitProcessApi({
    required Map<String, String> body,
    required List<String> pathList,
    required List<String> fieldList,
  }) async {
    // print(pathList);
    // print(fieldList);
    // print(body);
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).multipartMultiFile(
        ApiEndpoint.kycSubmitURL,
        body,
        code: 200,
        fieldList: fieldList,
        pathList: pathList,
      );
      if (mapResponse != null) {
        CommonSuccessModel result = CommonSuccessModel.fromJson(mapResponse);

        return result;
      }
    } catch (e) {
      log.e('🐞🐞🐞 err from Kyc submit process api service ==> $e 🐞🐞🐞');
      CustomSnackBar.error('Something went Wrong! in _kycSubmitApiProcess');
      return null;
    }
    return null;
  }
}
