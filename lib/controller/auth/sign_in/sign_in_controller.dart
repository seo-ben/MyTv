import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:MyTelevision/backend/local_storage/local_storage.dart';
import 'package:MyTelevision/backend/model/auth/sign_in/sign_in_model.dart';

import '../../../backend/model/common/common_success_model.dart';
import '../../../backend/services/auth_services/auth_services.dart';
import '../../../backend/utils/api_method.dart';
import '../../../routes/routes.dart';

class SignInController extends GetxController {
  final emailAddressController = TextEditingController();
  final forgotEmailController = TextEditingController();
  final passwordController = TextEditingController();

  /// >> set loading process & Sign In Model
  final _isLoading = false.obs;
  late LogInModel _signInModel;

  /// >> get loading process & Sign In Model
  bool get isLoading => _isLoading.value;

  LogInModel get signInModel => _signInModel;

  ///* Sign in process
  Future<LogInModel> signInProcess() async {
    _isLoading.value = true;
    update();
    Map<String, dynamic> inputBody = {
      'credentials': emailAddressController.text,
      'password': passwordController.text,
    };

    await AuthApiServices.signInProcessApi(body: inputBody)
        .then((value) {
          if (value != null) {
            _signInModel = value;
            _saveDataLocalStorage();
          }
          _isLoading.value = false;
          update();
        })
        .catchError((onError) {
          log.e(onError);
        });
    _isLoading.value = false;
    update();
    return _signInModel;
  }

  _saveDataLocalStorage() {
    LocalStorage.saveTwoFaID(
      id: _signInModel.data.userInfo.twoFactorStatus == 0 ? false : true,
    );
    LocalStorage.saveKyc(
      id: _signInModel.data.userInfo.kycVerified == 1 ? true : false,
    );
    //
    // if (_signInModel.data.userInfo.twoFactorStatus == "1" &&
    //     _signInModel.data.userInfo.twoFactorVerified == true) {
    //   LocalStorage.saveToken(token: signInModel.data.token);
    //   LocalStorage.saveUserToken(token: signInModel.data.token);
    //   LocalStorage.saveEmail(email: signInModel.data.userInfo.email);
    //   LocalStorage.saveId(id: signInModel.data.userInfo.id);
    //   Get.toNamed(Routes.twoFaVerificationScreen);
    // }
    if (_signInModel.data.userInfo.emailVerified == 1) {
      _goToSavedUser(signInModel);
    } else if (_signInModel.data.userInfo.emailVerified == 0) {
      Get.toNamed(Routes.signUpOtpScreen);
      LocalStorage.saveToken(token: signInModel.data.token);
      LocalStorage.saveUserToken(token: signInModel.data.authorization.token);
      LocalStorage.saveId(id: signInModel.data.userInfo.id);
    }
  }

  void _goToSavedUser(LogInModel signInModel) {
    LocalStorage.saveToken(token: signInModel.data.token);
    LocalStorage.isLoginSuccess(isLoggedIn: true);
    debugPrint(
      "---------------------->>>>>>>> ${LocalStorage.isLoggedIn().toString()}",
    );
    LocalStorage.saveEmail(email: signInModel.data.userInfo.email);
    LocalStorage.saveId(id: signInModel.data.userInfo.id);
    update();

    // Handle redirect if arguments are passed (e.g. from Subscription/Donation page)
    var redirectRoute = Get.arguments;
    if (redirectRoute != null && redirectRoute is String) {
      Get.offAllNamed(Routes.bottomNavBar);
      // Delay slightly to ensure bottom nav is loaded before pushing the next screen
      Future.delayed(const Duration(milliseconds: 300), () {
        Get.toNamed(redirectRoute);
      });
    } else {
      Get.offAllNamed(Routes.bottomNavBar);
    }
  }

  /// >> set loading process & model
  final _isSignOutLoading = false.obs;
  late CommonSuccessModel _signOutModel;

  /// >> get loading process & model
  bool get isSignOutLoading => _isSignOutLoading.value;

  CommonSuccessModel get signOutModel => _signOutModel;

  ///* Sign out process
  Future<CommonSuccessModel> signOutProcess() async {
    _isSignOutLoading.value = true;
    update();

    await AuthApiServices.signOutProcessApi()
        .then((value) {
          if (value != null) {
            _signOutModel = value;
            LocalStorage.signOut();
            Get.offAllNamed(Routes.signInScreen);
          }
          _isSignOutLoading.value = false;
          update();
        })
        .catchError((onError) {
          log.e(onError);
        });

    _isSignOutLoading.value = false;
    update();
    return _signOutModel;
  }
}
