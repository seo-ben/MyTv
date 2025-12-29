import 'dart:async';

import 'package:MyTelevision/language/language_controller.dart';

import '/backend/local_storage/local_storage.dart';
import '/backend/model/dashboard/home_info_model.dart' as home;
import '../../../backend/model/dashboard/my_subscription_info_model.dart'
    as subscription;
import '../../../backend/model/details/details_model.dart';
import '../../../backend/services/dashboard/dashboard_services.dart';
import '../../../backend/services/video/video_services.dart';
import 'package:MyTelevision/helpers/id_utils.dart';
import '../../../backend/utils/api_method.dart';
import '../../../utils/basic_screen_imports.dart';
import '../../../views/video_player_screen.dart';
import '../../../views/youtube_video_player_screen.dart';
import '../../../routes/routes.dart';

class DashboardController extends GetxController {
  final RxInt currentIndex = 0.obs;

  var appBarOpacity = 0.0.obs;
  final ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    // Initialiser les modèles avec des valeurs par défaut pour éviter les erreurs
    _homeInfoModel = home.HomeInfoModel(
      message: home.Message(success: []),
      data: home.Data(
        siteSection: '',
        categorySection: '',
        carousalData: [],
        adData: [],
        footballSectionData: [],
        sportsCategory: [],
      ),
    );

    _subscriptionInfoModel = subscription.MySubscriptionInfoModel(
      message: subscription.Message(success: []),
      data: [],
    );

    // Charger les informations du dashboard pour tous (contenu public)
    getHomeInfoProcess(
      newLanguage: Get.find<LanguageController>().selectedLanguage.value,
    );

    // Charger les données d'abonnement seulement si l'utilisateur est connecté
    if (LocalStorage.isLoggedIn()) {
      getSubscriptionInfoProcess(
        newLanguage: Get.find<LanguageController>().selectedLanguage.value,
      );
    } else {
      isPremium.value = false;
      _isSubscribeLoading.value = false;
    }

    scrollController.addListener(_onScroll);
    super.onInit();
  }

  void _onScroll() {
    double offset = scrollController.offset;
    appBarOpacity.value = (offset / 200).clamp(0.0, 1.0);
  }

  @override
  void onClose() {
    scrollController.removeListener(_onScroll);
    // scrollController.dispose();
    super.onClose();
  }

  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  /// >> set loading process & Profile Info Model

  late home.HomeInfoModel _homeInfoModel;

  /// >> get loading process & Profile Info Model
  home.HomeInfoModel get homeInfoModel => _homeInfoModel;

  ///* Get profile info api process
  Future<home.HomeInfoModel> getHomeInfoProcess({
    String newLanguage = "",
  }) async {
    _isLoading.value = true;
    update();

    await DashboardServices.getHomeInfoApi(newLanguage)
        .then((value) {
          if (value != null) {
            _homeInfoModel = value;
          }

          _isLoading.value = false;
          update();
        })
        .catchError((onError) {
          log.e(onError);
        });

    _isLoading.value = false;
    update();
    return _homeInfoModel;
  }

  /// >> set loading process & Profile Info Model
  final _isDetailsLoading = false.obs;
  late DetailsModel _watchListDetailsModel;

  /// >> get loading process & Profile Info Model
  bool get isDetailsLoading => _isDetailsLoading.value;

  DetailsModel get watchListDetailsModel => _watchListDetailsModel;

  ///* Get profile info api process
  Future<DetailsModel?> getDetailsProcess(String id) async {
    // Check if user is logged in
    if (!LocalStorage.isLoggedIn()) {
      Get.toNamed(Routes.signInScreen);
      return null;
    }

    _isDetailsLoading.value = true;
    update();

    await VideoServices.getFootballDetailsApi(id)
        .then((value) {
          if (value == null) {
            _isDetailsLoading.value = false;
            update();
            return;
          }
          _watchListDetailsModel = value;
          var data = _watchListDetailsModel.data;
          if (data.link.contains("youtube")) {
            debugPrint("🔴🟠🟢🔵🟣 ${data.link}");
            Get.to(
              YoutubeVideoPlayer(
                url: data.link,
                name: data.name,
                title: data.title,
                description: data.description,
                id: normalizeAndLogId(data.key, source: 'dashboard_controller'),
              ),
            );
          } else {
            debugPrint("🔴🟠🟢🔵🟣 ${data.link}");
            Get.to(
              VideoPlayerScreen(
                url: data.link,
                name: data.name,
                title: data.title,
                description: data.description,
                id: normalizeAndLogId(data.key, source: 'dashboard_controller'),
              ),
            );
          }
          _isDetailsLoading.value = false;
          update();
        })
        .catchError((onError) {
          log.e(onError);
          _isDetailsLoading.value = false;
          update();
        });

    return _isDetailsLoading.value ? null : _watchListDetailsModel;
  }

  RxBool isPremium = false.obs;

  final _isSubscribeLoading = false.obs;
  bool get isSubscribeLoading => _isSubscribeLoading.value;

  /// >> set loading process & Profile Info Model

  late subscription.MySubscriptionInfoModel _subscriptionInfoModel;

  /// >> get loading process & Profile Info Model
  subscription.MySubscriptionInfoModel get subscriptionInfoModel =>
      _subscriptionInfoModel;

  ///* Get profile info api process
  Future<subscription.MySubscriptionInfoModel> getSubscriptionInfoProcess({
    String newLanguage = "",
  }) async {
    _isSubscribeLoading.value = true;
    update();

    await DashboardServices.getSubscriptionInfoApi(newLanguage)
        .then((value) {
          if (value != null) {
            _subscriptionInfoModel = value;

            var data = _subscriptionInfoModel.data;
            if (data.isEmpty) {
              isPremium.value = false;
            } else {
              for (var item in data) {
                if (item.status == true) {
                  isPremium.value = true;
                  break;
                } else {
                  isPremium.value = false;
                }
              }
            }
          }
          _isSubscribeLoading.value = false;
          update();
        })
        .catchError((onError) {
          log.e(onError);
        });

    _isSubscribeLoading.value = false;
    update();
    return _subscriptionInfoModel;
  }
}
