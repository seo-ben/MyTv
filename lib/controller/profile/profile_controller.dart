import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../backend/local_storage/local_storage.dart';
import '../../backend/model/common/common_success_model.dart';
import '../../backend/model/profile/profile_info_model.dart';
import '../../backend/services/api_endpoint.dart';
import '../../backend/services/profile/profile_api_services.dart';
import '../../backend/utils/api_method.dart';
import '../../routes/routes.dart';

class ProfileController extends GetxController {
  RxString userImagePath = ''.obs;
  RxString userEmailAddress = ''.obs;
  RxString userFullName = ''.obs;
  RxString userImage = ''.obs;

  RxString defaultImage = ''.obs;
  RxBool isImagePathSet = false.obs;
  File? image;
  ImagePicker picker = ImagePicker();

  List<String> countryList = [];
  List<String> mobileCode = [];

  @override
  onInit() {
    // Ne charger les données de profil que si l'utilisateur est connecté
    if (LocalStorage.isLoggedIn()) {
      getProfileInfoProcess();
    }
    super.onInit();
  }

  chooseImageFromGallery() async {
    var pickImage = await picker.pickImage(source: ImageSource.gallery);
    image = File(pickImage!.path);
    if (image!.path.isNotEmpty) {
      userImagePath.value = image!.path;
      isImagePathSet.value = true;
    }
  }

  chooseImageFromCamera() async {
    var pickImage = await picker.pickImage(source: ImageSource.camera);
    image = File(pickImage!.path);
    if (image!.path.isNotEmpty) {
      userImagePath.value = image!.path;
      isImagePathSet.value = true;
    }
  }

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final zipCodeController = TextEditingController();
  RxString selectCountry = "".obs;

  Rx<FocusNode> firstNameFocus = FocusNode().obs;
  Rx<FocusNode> lastNameFocus = FocusNode().obs;
  Rx<FocusNode> phoneFocus = FocusNode().obs;
  Rx<FocusNode> addressFocus = FocusNode().obs;
  Rx<FocusNode> cityFocus = FocusNode().obs;
  Rx<FocusNode> stateFocus = FocusNode().obs;
  Rx<FocusNode> zipFocus = FocusNode().obs;

  /// >> set loading process & Profile Info Model
  final _isLoading = false.obs;
  late ProfileInfoModel _profileInfoModel;

  /// >> get loading process & Profile Info Model
  bool get isLoading => _isLoading.value;

  ProfileInfoModel get profileInfoModel => _profileInfoModel;

  ///* Get profile info api process
  Future<ProfileInfoModel> getProfileInfoProcess() async {
    _isLoading.value = true;
    update();

    await ProfileApiServices.getProfileInfoProcessApi()
        .then((value) {
          _profileInfoModel = value!;
          _setData(_profileInfoModel);
          _isLoading.value = false;
          update();
        })
        .catchError((onError) {
          log.e(onError);
        });

    _isLoading.value = false;
    update();
    return _profileInfoModel;
  }

  RxInt selectMobileCodeIndex = 0.obs;

  void _setData(ProfileInfoModel profileModel) {
    countryList.clear();
    var data = profileModel.data;
    userFullName.value = '${data.userInfo.firstname} ${data.userInfo.lastname}';
    firstNameController.text = data.userInfo.firstname;
    lastNameController.text = data.userInfo.lastname;
    phoneController.text = data.userInfo.mobile;
    addressController.text = data.userInfo.address;
    cityController.text = data.userInfo.city;
    stateController.text = data.userInfo.state;
    zipCodeController.text = data.userInfo.postalCode;
    userEmailAddress.value = data.userInfo.email;
    selectCountry.value = selectCountry.value == ""
        ? data.countries.first.name
        : data.userInfo.country;

    for (var item in data.countries) {
      countryList.add(item.name);
      mobileCode.add(item.mobileCode);
    }

    LocalStorage.saveEmail(email: data.userInfo.email);
    LocalStorage.saveName(name: userFullName.value);
    LocalStorage.saveNumber(num: data.userInfo.mobile);
    if (data.userInfo.image != "") {
      userImage.value =
          '${ApiEndpoint.mainDomain}/${data.imagePaths.pathLocation}/${data.userInfo.image}';
    } else {
      userImage.value =
          '${ApiEndpoint.mainDomain}/${data.imagePaths.defaultImage}';
    }
    update();
  }

  /// >> set loading process & profile update model
  final _isUpdateLoading = false.obs;
  late CommonSuccessModel _profileUpdateModel;
  //
  /// >> get loading process & profile update model
  bool get isUpdateLoading => _isUpdateLoading.value;

  CommonSuccessModel get profileUpdateModel => _profileUpdateModel;

  Future<CommonSuccessModel> profileUpdateWithOutImageProcess() async {
    int index = 0;
    for (int i = 0; i < countryList.length; i++) {
      if (selectCountry.value == countryList[i]) {
        index = i;
      }
    }
    _isUpdateLoading.value = true;
    update();

    Map<String, dynamic> inputBody = {
      'firstname': firstNameController.text,
      'lastname': lastNameController.text,
      'mobile_code': mobileCode[index],
      'mobile': phoneController.text,
      'country': selectCountry.value,
      'city': cityController.text,
      'state': stateController.text,
      'address': addressController.text,
      'zip_code': zipCodeController.text,
    };

    await ProfileApiServices.updateProfileWithoutImageApi(body: inputBody)
        .then((value) {
          _profileUpdateModel = value!;
          getProfileInfoProcess();
          update();
        })
        .catchError((onError) {
          log.e(onError);
        });

    _isUpdateLoading.value = false;
    update();
    return _profileUpdateModel;
  }

  // Profile update process with image
  Future<CommonSuccessModel> profileUpdateWithImageProcess() async {
    int index = 0;
    for (int i = 0; i < countryList.length; i++) {
      if (selectCountry.value == countryList[i]) {
        index = i;
      }
    }
    _isUpdateLoading.value = true;
    update();

    Map<String, String> inputBody = {
      'firstname': firstNameController.text,
      'lastname': lastNameController.text,
      'mobile_code': mobileCode[index],
      'mobile': phoneController.text,
      'country': selectCountry.value,
      'city': cityController.text,
      'state': stateController.text,
      'address': addressController.text,
      'postal_code': zipCodeController.text,
    };

    await ProfileApiServices.updateProfileWithImageApi(
          body: inputBody,
          filepath: userImagePath.value,
        )
        .then((value) {
          _profileUpdateModel = value!;
          getProfileInfoProcess();
          update();
        })
        .catchError((onError) {
          log.e(onError);
        });

    _isUpdateLoading.value = false;
    update();
    return _profileUpdateModel;
  }

  /// >> set loading process & ProfileDelete Model
  final _isDeleteLoading = false.obs;
  late CommonSuccessModel _profileDeleteModel;

  /// >> get loading process & ProfileDelete Model
  bool get isDeleteLoading => _isDeleteLoading.value;

  CommonSuccessModel get profileDeleteModel => _profileDeleteModel;

  ///* ProfileDelete in process
  Future<CommonSuccessModel> profileDeleteProcess() async {
    _isDeleteLoading.value = true;
    update();
    Map<String, dynamic> inputBody = {};
    await ProfileApiServices.profileDeleteProcessApi(body: inputBody)
        .then((value) {
          _profileDeleteModel = value!;
          Get.offAllNamed(Routes.signInScreen);
          _isDeleteLoading.value = false;
          update();
        })
        .catchError((onError) {
          log.e(onError);
        });
    _isDeleteLoading.value = false;
    update();
    return _profileDeleteModel;
  }
}
