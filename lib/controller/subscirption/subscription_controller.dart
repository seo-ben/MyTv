import 'package:get/get.dart';

import '../../backend/local_storage/local_storage.dart';
import '../../backend/model/dashboard/dashboard_model.dart';
import '../../backend/services/dashboard/dashboard_services.dart';
import '../../backend/utils/api_method.dart';

class SubscriptionController extends GetxController {
  @override
  void onInit() {
    // Charger les données seulement si l'utilisateur est connecté
    if (LocalStorage.isLoggedIn()) {
      getProfileInfoProcess();
    } else {
      // Pour les invités, initialiser un modèle vide
      _initializeEmptyModel();
    }
    super.onInit();
  }

  void _initializeEmptyModel() {
    _dashboardModel = DashboardModel(
      message: Message(success: []),
      data: Data(subscriptionLog: null),
    );
    _isLoading.value = false;
  }

  /// >> set loading process & Profile Info Model
  final _isLoading = false.obs;
  late DashboardModel _dashboardModel;

  /// >> get loading process & Profile Info Model
  bool get isLoading => _isLoading.value;

  DashboardModel get dashboardInfoModel => _dashboardModel;

  ///* Get profile info api process
  Future<DashboardModel> getProfileInfoProcess() async {
    _isLoading.value = true;
    update();

    await DashboardServices.getProfileInfoProcessApi()
        .then((value) {
          _dashboardModel = value!;
          _isLoading.value = false;
          update();
        })
        .catchError((onError) {
          log.e(onError);
        });

    _isLoading.value = false;
    update();
    return _dashboardModel;
  }
}
