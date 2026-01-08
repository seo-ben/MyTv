import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:MyTelevision/backend/local_storage/local_storage.dart';

import '../../../../backend/model/auth/sign_in/forget_password/forget_password_model.dart';
import '../../../../backend/services/auth_services/auth_services.dart';
import '../../../../backend/utils/api_method.dart';
import '../../../../routes/routes.dart';

class ForgetPasswordController extends GetxController {
  final emailController = TextEditingController();
  final otpController = TextEditingController();

  RxInt secondsRemaining = 59.obs;
  RxInt minuteRemaining = 00.obs;
  RxBool enableResend = false.obs;
  Timer? timer;

  @override
  void onInit() {
    timerInit();
    super.onInit();
  }

  timerInit() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (minuteRemaining.value != 0) {
        secondsRemaining.value--;
        if (secondsRemaining.value == 0) {
          secondsRemaining.value = 59;
          minuteRemaining.value = 0;
        }
      } else if (minuteRemaining.value == 0 && secondsRemaining.value != 0) {
        secondsRemaining.value--;
      } else {
        enableResend.value = true;
      }
    });
  }

  resendCode() {
    secondsRemaining.value = 59;
    minuteRemaining = 00.obs;
    enableResend.value = false;
    resendOtpProcess();
  }

  /// >> set loading process & Otp Verification Model
  final _isLoading = false.obs;
  late ForgotPasswordModel _otpVerificationModel;

  /// >> get loading process & Otp Verification Model
  bool get isLoading => _isLoading.value;

  ForgotPasswordModel get otpVerificationModel => _otpVerificationModel;

  ///* Otp verify process
  Future<ForgotPasswordModel> otpVerifyProcess() async {
    _isLoading.value = true;
    update();

    Map<String, dynamic> inputBody = {
      'code': otpController.text,
      'token': LocalStorage.getToken(),
    };
    await AuthApiServices.forgetPassVerifyOTPApi(body: inputBody)
        .then((value) {
          _otpVerificationModel = value!;
          Get.toNamed(Routes.resetPasswordScreen);
          _isLoading.value = false;
          update();
        })
        .catchError((onError) {
          log.e(onError);
        });

    _isLoading.value = false;
    update();
    return _otpVerificationModel;
  }

  /// >> set loading process & Forgot Password Model
  final _isForgotPasswordLoading = false.obs;
  late ForgotPasswordModel _forgotPasswordModel;

  /// >> get loading process & Forgot Password Model
  bool get isForgotPasswordLoading => _isForgotPasswordLoading.value;

  ForgotPasswordModel get forgotPasswordModel => _forgotPasswordModel;

  ///* Forgot Password Api Process
  Future<ForgotPasswordModel> forgotPasswordProcess() async {
    _isForgotPasswordLoading.value = true;
    update();

    Map<String, dynamic> inputBody = {'credentials': emailController.text};
    await AuthApiServices.forgotPasswordProcessApi(body: inputBody)
        .then((value) {
          _forgotPasswordModel = value!;
          LocalStorage.saveToken(token: _forgotPasswordModel.data.token);
          Get.toNamed(Routes.forgetPasswordOtpScreen);
          // Get.toNamed(Routes.resetPasswordScreen);
          _isForgotPasswordLoading.value = false;
          update();
        })
        .catchError((onError) {
          log.e(onError);
        });

    _isForgotPasswordLoading.value = false;
    update();
    return _forgotPasswordModel;
  }

  /// >> set loading process & Forgot Password Model
  final _isResendOtpLoading = false.obs;
  late ForgotPasswordModel _otpResendModel;

  /// >> get loading process & Forgot Password Model
  bool get isOtpResendLoading => _isResendOtpLoading.value;

  ForgotPasswordModel get otpModel => _otpResendModel;

  ///* Resend otp process
  Future<ForgotPasswordModel> resendOtpProcess() async {
    _isResendOtpLoading.value = true;
    update();
    await AuthApiServices.resetPasswordResendOtpProcessApi()
        .then((value) {
          _otpResendModel = value!;
          debugPrint("1");
          _isResendOtpLoading.value = false;
          update();
        })
        .catchError((onError) {
          debugPrint("2");
          log.e(onError);
        });
    debugPrint("3");

    _isResendOtpLoading.value = false;

    return _otpResendModel;
  }
}
