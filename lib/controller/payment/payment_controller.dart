import 'package:flutter/services.dart';
import 'package:MyTelevision/backend/model/payment/checkout_model.dart';
import 'package:MyTelevision/views/payment/authorize_payment_screen.dart';

import '../../backend/model/common/common_success_model.dart';
import '../../backend/model/payment/authorize_submit_method.dart';
import '../../routes/routes.dart';
import '../../views/congratulation/congratulation_screen.dart';
import '/controller/subscription_page/subscription_page_controller.dart';
import '../../backend/model/payment/payment_automatic_submit_model.dart';
import '../../backend/model/payment/payment_info_model.dart';
import '../../backend/model/payment/paypal_submit_model.dart';
import '../../backend/model/payment/tatum_payment_gateway.dart';
import '../../backend/services/payment/payment_services.dart';
import '../../backend/utils/api_method.dart';
import '../../utils/basic_screen_imports.dart';
import '../../backend/local_storage/local_storage.dart';
import '../../backend/utils/custom_snackbar.dart';
import '../../views/web_payment/web_payment_screen.dart';

class PaymentController extends GetxController {
  final cardNumberController = TextEditingController();
  final cardExpiryController = TextEditingController();
  final cardCVCController = TextEditingController();
  @override
  void onInit() {
    super.onInit();
    getPaymentInfoProcess();
  }

  List<String> paymentList = [];
  List<String> paymentAliasList = [];
  RxString selectPayment = ''.obs;

  /// >> set loading process & Profile Info Model
  final _isLoading = false.obs;
  PaymentInfoModel? _paymentInfoModel;

  /// >> get loading process & Profile Info Model
  bool get isLoading => _isLoading.value;

  PaymentInfoModel? get paymentInfoModel => _paymentInfoModel;

  ///* Get profile info api process
  Future<PaymentInfoModel?> getPaymentInfoProcess() async {
    _isLoading.value = true;
    paymentList.clear();
    paymentAliasList.clear();
    update();

    await PaymentServices.getPaymentInfoApi()
        .then((value) {
          _paymentInfoModel = value;
          if (_paymentInfoModel != null) {
            var data = _paymentInfoModel!.data.paymentGateways;
            for (var item in data) {
              for (var i in item.currencies) {
                paymentList.add(i.name);
                paymentAliasList.add(i.alias);
              }
            }
            if (paymentList.isNotEmpty) {
              selectPayment.value = paymentList.first;
            }
          } else {
            if (LocalStorage.isLoggedIn()) {
              LocalStorage.signOut();
              Get.offAllNamed(
                Routes.signInScreen,
                arguments: Routes.paymentScreen,
              );
              CustomSnackBar.error(
                "Session expirée. Veuillez vous reconnecter.",
              );
            }
          }
          _isLoading.value = false;
          update();
        })
        .catchError((onError) {
          log.e(onError);
          _isLoading.value = false;
          update();
        });

    _isLoading.value = false;
    update();
    return _paymentInfoModel;
  }

  final subscriptionController = Get.find<SubscriptionPageController>();

  /// >> set loading process & Profile Info Model
  final _isSubmitLoading = false.obs;
  late PaymentSubmitAutomaticModel _automaticPaymentSubmitModel;

  /// >> get loading process & Profile Info Model
  bool get isSubmitLoading => _isSubmitLoading.value;

  PaymentSubmitAutomaticModel get automaticPaymentSubmitModel =>
      _automaticPaymentSubmitModel;

  ///* Get profile info api process
  Future<PaymentSubmitAutomaticModel> paymentAutomaticSubmitProcess() async {
    _isSubmitLoading.value = true;
    var data = subscriptionController
        .subscriptionModel!
        .data
        .subscribePageData[subscriptionController.currentIndex.value];
    update();
    int index = -1;
    for (int i = 0; i < paymentList.length; i++) {
      if (selectPayment.value == paymentList[i]) {
        index = i;
      }
    }
    Map<String, dynamic> inputBody = {
      "currency": paymentAliasList[index],
      "amount": data.price,
      "package_id": data.id,
      "expire_date": checkoutModel.data.expireDate,
    };
    await PaymentServices.automaticPaymentSubmitApi(body: inputBody)
        .then((value) {
          _automaticPaymentSubmitModel = value!;
          var data = _automaticPaymentSubmitModel.data;
          Get.to(
            WebPaymentScreen(
              appBarName: selectPayment.value,
              webUri: data.redirectUrl,
              subtitle: Strings.congratulations,
            ),
          );
          _isSubmitLoading.value = false;
          update();
        })
        .catchError((onError) {
          log.e(onError);
        });

    _isSubmitLoading.value = false;
    update();
    return _automaticPaymentSubmitModel;
  }

  ///* Get payment info api process

  late PaypalSubmitModel _paypalSubmitModel;

  /// >> get loading process & Profile Info Model

  PaypalSubmitModel get paypalSubmitModel => _paypalSubmitModel;
  Future<PaypalSubmitModel> paypalSubmitProcess() async {
    _isSubmitLoading.value = true;
    var data = subscriptionController
        .subscriptionModel!
        .data
        .subscribePageData[subscriptionController.currentIndex.value];
    update();
    int index = -1;
    for (int i = 0; i < paymentList.length; i++) {
      if (selectPayment.value == paymentList[i]) {
        index = i;
      }
    }
    Map<String, dynamic> inputBody = {
      "currency": paymentAliasList[index],
      "amount": data.price,
      "package_id": data.id,
      "expire_date": checkoutModel.data.expireDate,
    };
    await PaymentServices.paypalSubmitApi(body: inputBody)
        .then((value) {
          _paypalSubmitModel = value!;
          var data = _paypalSubmitModel.data;
          Get.to(
            WebPaymentScreen(
              appBarName: selectPayment.value,
              webUri: data.redirectUrl,
              subtitle: Strings.congratulations,
            ),
          );
          _isSubmitLoading.value = false;
          update();
        })
        .catchError((onError) {
          log.e(onError);
        });

    _isSubmitLoading.value = false;
    update();
    return _paypalSubmitModel;
  }

  ///* Get payment info api process

  late CheckoutModel _checkoutModel;

  /// >> get loading process & Profile Info Model

  CheckoutModel get checkoutModel => _checkoutModel;
  Future<CheckoutModel> paymentCheckoutProcess() async {
    _isSubmitLoading.value = true;
    var data = subscriptionController
        .subscriptionModel!
        .data
        .subscribePageData[subscriptionController.currentIndex.value];
    update();

    Map<String, dynamic> inputBody = {
      "price": data.price,
      "package_id": data.id.toString(),
      "name": data.name,
      "duration": data.duration,
    };
    await PaymentServices.paymentCheckoutApi(body: inputBody)
        .then((value) {
          _checkoutModel = value!;

          _isSubmitLoading.value = false;
          update();
        })
        .catchError((onError) {
          log.e(onError);
        });

    _isSubmitLoading.value = false;
    update();
    return _checkoutModel;
  }

  List<TextEditingController> inputFieldControllers = [];
  final amountTextController = TextEditingController();

  RxList inputFields = [].obs;

  /// Tatum payment gateway
  late TatumGatewayModel _tatumGatewayModel;

  TatumGatewayModel get tatumGatewayModel => _tatumGatewayModel;

  // add money tatum
  Future<TatumGatewayModel> tatumProcess() async {
    inputFields.clear();
    inputFieldControllers.clear();
    _isSubmitLoading.value = true;
    update();

    Map<String, dynamic> inputBody = {};

    await PaymentServices.tatumInsertApi(body: inputBody)
        .then((value) {
          _tatumGatewayModel = value!;

          final data = _tatumGatewayModel.data.addressInfo.inputFields;

          for (int item = 0; item < data.length; item++) {
            // make the dynamic controller
            var textEditingController = TextEditingController();
            inputFieldControllers.add(textEditingController);

            if (data[item].type.contains('text')) {
              inputFields.add(
                Column(
                  children: [
                    PrimaryInputWidget(
                      controller: inputFieldControllers[item],
                      label: data[item].label,
                      // hint: data[item].label,
                      isValidator: data[item].required,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(
                          int.parse(data[item].validation.max.toString()),
                        ),
                      ],
                      hint: data[item].label,
                    ),
                    verticalSpace(Dimensions.heightSize),
                  ],
                ),
              );
            }
          }

          update();
        })
        .catchError((onError) {
          log.e(onError);
        });
    _isSubmitLoading.value = false;
    update();
    return _tatumGatewayModel;
  }

  // Authorize submit process.

  late AuthorizeSubmitModel _authorizeSubmitModel;
  AuthorizeSubmitModel get authorizeSubmitModel => _authorizeSubmitModel;

  Future<AuthorizeSubmitModel> authorizeSubmitProcess() async {
    _isSubmitLoading.value = true;
    var data = subscriptionController
        .subscriptionModel!
        .data
        .subscribePageData[subscriptionController.currentIndex.value];
    update();
    int index = -1;
    for (int i = 0; i < paymentList.length; i++) {
      if (selectPayment.value == paymentList[i]) {
        index = i;
      }
    }
    Map<String, dynamic> inputBody = {
      "currency": paymentAliasList[index],
      "amount": data.price,
      "package_id": data.id,
      "expire_date": checkoutModel.data.expireDate,
    };
    await PaymentServices.automaticAuthorizeSubmitApi(body: inputBody)
        .then((value) {
          _authorizeSubmitModel = value!;
          Get.to(() => AuthorizeGatewayScreen());
          _isSubmitLoading.value = false;
          update();
        })
        .catchError((onError) {
          log.e(onError);
        });

    _isSubmitLoading.value = false;
    update();
    return _authorizeSubmitModel;
  }

  final _isAuthorizeConfirmLoading = false.obs;
  bool get isAuthorizeConfirmLoading => _isAuthorizeConfirmLoading.value;
  late CommonSuccessModel _commonSuccessModel;
  CommonSuccessModel get commonSuccessModel => _commonSuccessModel;

  Future<CommonSuccessModel> authorizeConfirmProcess() async {
    _isAuthorizeConfirmLoading.value = true;
    update();
    Map<String, dynamic> inputBody = {
      'identifier': _authorizeSubmitModel.data != null
          ? _authorizeSubmitModel.data!.identifier
          : '',
      'card_number': cardNumberController.text,
      'date': cardExpiryController.text,
      'code': cardCVCController.text,
    };
    await PaymentServices.authorizeConfirmApi(body: inputBody)
        .then((value) {
          _commonSuccessModel = value!;
          Get.to(
            CongratulationScreen(
              route: Routes.bottomNavBar,
              subTitle: Strings.successfullyPackagePurchased,
              title: Strings.congratulations,
            ),
          );
          _isAuthorizeConfirmLoading.value = false;
          update();
        })
        .catchError((onError) {
          log.e(onError);
        });
    _isAuthorizeConfirmLoading.value = false;
    update();
    return _commonSuccessModel;
  }
}
