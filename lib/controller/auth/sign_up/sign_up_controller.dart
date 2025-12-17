import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../backend/local_storage/local_storage.dart';
import '../../../backend/model/auth/sign_up/sign_up_model.dart';
import '../../../backend/services/auth_services/auth_services.dart';
import '../../../backend/utils/api_method.dart';
import '../../../routes/routes.dart';
import '../../basic_settings_controller.dart';

class SignUpController extends GetxController {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  RxBool isChecked = false.obs;

  /// >> set loading process & Sign Up Model
  final _isLoading = false.obs;
  late RegisterModel _signUpModel;

  /// >> get loading process & Sign Up Model
  bool get isLoading => _isLoading.value;

  RegisterModel get signUpModel => _signUpModel;

  ///* Sign Up Process Api
  Future<RegisterModel> signUpProcess() async {
    _isLoading.value = true;
    update();

    Map<String, dynamic> inputBody = {
      'firstname': firstNameController.text,
      'lastname': lastNameController.text,
      'email': emailController.text,
      'password': passwordController.text.trim(),
      'agree':
          (Get.find<BasicSettingsController>().isSettingsLoaded &&
              Get.find<BasicSettingsController>()
                      .appSettingsModel
                      .data
                      .agreePolicy ==
                  true)
          ? (isChecked.value ? 'on' : "off")
          : "on",
    };
    await AuthApiServices.signUpProcessApi(body: inputBody)
        .then((value) {
          _signUpModel = value!;
          _goToSavedUser(signUpModel);
          _isLoading.value = false;
          update();
        })
        .catchError((onError) {
          log.e(onError);
        });

    _isLoading.value = false;
    update();
    return _signUpModel;
  }

  void _goToSavedUser(RegisterModel signUpModel) {
    LocalStorage.saveToken(token: signUpModel.data.token);
    LocalStorage.saveUserToken(token: signUpModel.data.authorization.token);
    // LocalStorage.saveIsSmsVerify(
    // value: signUpModel.data.userInfo.smsVerified == 0 ? false : true);

    if (signUpModel.data.userInfo.emailVerified.toString() == "0") {
      Get.toNamed(Routes.signUpOtpScreen);
    } else {
      LocalStorage.isLoginSuccess(isLoggedIn: true);
      LocalStorage.saveId(id: signUpModel.data.userInfo.id);
      Get.offNamedUntil(Routes.bottomNavBar, (route) => false);
    }
  }
}
