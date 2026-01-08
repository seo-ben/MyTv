import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../backend/local_storage/local_storage.dart';
import '../../../../backend/model/common/common_success_model.dart';
import '../../../../backend/services/auth_services/auth_services.dart';
import '../../../../backend/utils/api_method.dart';
import '../../../../routes/routes.dart';

class SignUpOtpController extends GetxController {
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
    enableResend.value = false;
    resendOtpProcess();
  }

  final _isLoading = false.obs;

  bool get isLoading => _isLoading.value;

  late CommonSuccessModel _emailOtpSubmitModel;

  CommonSuccessModel get emailOtpSubmitModel => _emailOtpSubmitModel;

  Future<CommonSuccessModel> emailOtpSubmitProcess() async {
    _isLoading.value = true;
    update();

    Map<String, dynamic> inputBody = {
      'code': otpController.text,
      'token': LocalStorage.getUserToken(),
    };
    await AuthApiServices.emailOtpVerifyApi(body: inputBody).then((value) {
      _emailOtpSubmitModel = value!;

      if (LocalStorage.getTwoFaID()) {
        Get.toNamed(Routes.twoFaVerificationScreen);
      } else {
        Get.offAllNamed(Routes.bottomNavBar);
      }
      _isLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });

    _isLoading.value = false;
    update();
    return _emailOtpSubmitModel;
  }

  final _resendLoading = false.obs;

  bool get resendLoading => _resendLoading.value;

  Future<CommonSuccessModel> resendOtpProcess() async {
    _resendLoading.value = true;
    otpController.clear();
    update();

    await AuthApiServices.emailResendProcessApi(LocalStorage.getToken()!)
        .then((value) {
      _emailOtpSubmitModel = value!;

      _resendLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });

    _resendLoading.value = false;
    update();
    return _emailOtpSubmitModel;
  }
}
