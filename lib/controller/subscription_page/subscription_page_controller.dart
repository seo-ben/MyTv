import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../backend/model/drawer/subscription/subscription_model.dart';
import '../../backend/services/video/video_services.dart';
import '../../backend/utils/api_method.dart';

class SubscriptionPageController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    getSubscriptionProcess();
  }

  RxInt currentIndex = 0.obs;

  /// >> set loading process & Profile Info Model
  final _isLoading = false.obs;
  SubscriptionModel? _subscriptionModel;

  /// >> get loading process & Profile Info Model
  bool get isLoading => _isLoading.value;

  SubscriptionModel? get subscriptionModel => _subscriptionModel;

  ///* Get profile info api process
  Future<SubscriptionModel?> getSubscriptionProcess() async {
    _isLoading.value = true;
    update();
    await VideoServices.getSubscriptionDataApi()
        .then((value) {
          _subscriptionModel = value;

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
    return _subscriptionModel;
  }

  String calculateExpiryDate(String duration) {
    DateTime now = DateTime.now();
    DateTime expiryDate;

    if (duration.contains("day")) {
      expiryDate = now.add(const Duration(days: 1));
    } else if (duration.contains("week")) {
      expiryDate = now.add(const Duration(days: 7));
    } else if (duration.contains("month")) {
      expiryDate = now.add(const Duration(days: 30));
    } else {
      expiryDate = now; // Default to current date if no match
    }

    // Formatting the date to display in a readable format, e.g., 17th Oct, 2024

    String formattedDate = DateFormat('d MMM yyyy').format(expiryDate);
    return formattedDate;
  }
}
