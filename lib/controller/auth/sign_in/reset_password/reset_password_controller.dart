import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:MyTelevision/backend/local_storage/local_storage.dart';
import 'package:MyTelevision/views/congratulation/congratulation_screen.dart';

import '../../../../backend/model/common/common_success_model.dart';
import '../../../../backend/services/auth_services/auth_services.dart';
import '../../../../backend/utils/api_method.dart';
import '../../../../language/strings.dart';
import '../../../../routes/routes.dart';

class ResetPasswordController extends GetxController {
  final newPasswordController = TextEditingController();
  final oldPasswordController = TextEditingController();

  /// >> set loading process & Reset Password Model
  final _isLoading = false.obs;
  late CommonSuccessModel _resetPasswordModel;

  /// >> set loading process & Reset Password Model
  bool get isLoading => _isLoading.value;

  CommonSuccessModel get resetPasswordModel => _resetPasswordModel;

  ///* Reset password process
  Future<CommonSuccessModel> resetPasswordProcess() async {
    _isLoading.value = true;
    update();

    Map<String, dynamic> inputBody = {
      'token': LocalStorage.getToken(),
      'password': newPasswordController.text,
      'password_confirmation': oldPasswordController.text,
    };

    await AuthApiServices.resetPasswordApi(body: inputBody)
        .then((value) {
          _resetPasswordModel = value!;

          Get.to(
            const CongratulationScreen(
              title: Strings.congratulations,
              subTitle: Strings.youHaveSuccessFullyResetPassword,
              route: Routes.signInScreen,
            ),
          );

          _isLoading.value = false;
          update();
        })
        .catchError((onError) {
          log.e(onError);
        });

    _isLoading.value = false;
    update();
    return _resetPasswordModel;
  }
}
