import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../backend/model/common/common_success_model.dart';
import '../../../backend/services/auth_services/auth_services.dart';
import '../../../backend/utils/api_method.dart';
import '../../../language/strings.dart';
import '../../../routes/routes.dart';
import '../../../views/congratulation/congratulation_screen.dart';

class ChangePasswordController extends GetxController {
  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    oldPasswordController.dispose();
    super.dispose();
  }

  void goToSignInScreen() {
    Get.to(
      () => const CongratulationScreen(
        route: Routes.bottomNavBar,
        subTitle: Strings.yourPasswordHas,
        title: Strings.congratulations,
      ),
    );
  }

  /// >> set loading process & ChangeLanguage Model
  final _isLoading = false.obs;
  late CommonSuccessModel _changeLanguageModel;

  /// >> get loading process & ChangeLanguage Model
  bool get isLoading => _isLoading.value;

  CommonSuccessModel get changeLanguageModel => _changeLanguageModel;

  ///* ChangeLanguage in process
  Future<CommonSuccessModel> changePasswordProcess() async {
    _isLoading.value = true;
    update();
    Map<String, dynamic> inputBody = {
      'current_password': oldPasswordController.text,
      'password': newPasswordController.text,
      'password_confirmation': confirmPasswordController.text,
    };
    await AuthApiServices.changePasswordApi(body: inputBody).then((value) {
      _changeLanguageModel = value!;
      goToSignInScreen();
      _isLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isLoading.value = false;
    update();
    return _changeLanguageModel;
  }
}
