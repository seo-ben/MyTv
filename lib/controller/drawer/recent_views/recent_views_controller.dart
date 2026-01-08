import '../../../backend/model/details/details_model.dart';
import '../../../backend/model/drawer/recent_views/recent_views_model.dart'
    as rv;
import '/backend/model/details/category_details_model.dart' as cdm;

import '../../../backend/services/video/video_services.dart';
import 'package:MyTelevision/helpers/id_utils.dart';
import '../../../backend/utils/api_method.dart';
import '../../../utils/basic_screen_imports.dart';
import '../../../views/video_player_screen.dart';
import '../../../views/youtube_video_player_screen.dart';

class RecentViewsController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    recentViewsProcess();
  }

  /// ------------------------------------- >>
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  late rv.RecentViewsModel _recentViewsModel;
  rv.RecentViewsModel get recentViewsModel => _recentViewsModel;

  ///* Get RecentViews in process
  Future<rv.RecentViewsModel> recentViewsProcess() async {
    _isLoading.value = true;
    update();
    await VideoServices.recentViewsProcessApi()
        .then((value) {
          _recentViewsModel = value!;
          _isLoading.value = false;
          update();
        })
        .catchError((onError) {
          log.e(onError);
        });
    _isLoading.value = false;
    update();
    return _recentViewsModel;
  }

  /// >> set loading process & Profile Info Model
  final _isDetailsLoading = false.obs;
  late cdm.CategoryDetailsModel _watchListDetailsModel;

  /// >> get loading process & Profile Info Model
  bool get isDetailsLoading => _isDetailsLoading.value;
  cdm.CategoryDetailsModel get watchListDetailsModel => _watchListDetailsModel;

  ///* Get profile info api process
  Future<cdm.CategoryDetailsModel> getDetailsProcess(String id) async {
    _isDetailsLoading.value = true;
    update();
    await VideoServices.getWatchListApi(id)
        .then((value) {
          _watchListDetailsModel = value!;
          cdm.Data data = _watchListDetailsModel.data;
          if (data.link.contains("youtube")) {
            debugPrint("🔴🟠🟢🔵🟣 ${data.link}");
            Get.to(
              YoutubeVideoPlayer(
                url: data.link,
                name: data.name,
                title: data.title,
                description: data.description,
                id: normalizeAndLogId(
                  data.id,
                  source: 'recent_views_controller',
                ),
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
                id: normalizeAndLogId(
                  data.id,
                  source: 'recent_views_controller',
                ),
              ),
            );
          }
          _isDetailsLoading.value = false;
          update();
        })
        .catchError((onError) {
          log.e(onError);
        });

    _isDetailsLoading.value = false;
    update();
    return _watchListDetailsModel;
  }

  /// >> set loading process & Profile Info Model
  late DetailsModel _watchListDetailsModel2;
  DetailsModel get watchListDetailsModel2 => _watchListDetailsModel2;

  ///* Get profile info api process
  Future<DetailsModel> getDetailsProcess2(String id) async {
    _isDetailsLoading.value = true;
    update();
    await VideoServices.getFootballDetailsApi(id)
        .then((value) {
          _watchListDetailsModel2 = value!;
          var data = _watchListDetailsModel2.data;
          if (data.link.contains("youtube")) {
            debugPrint("🔴🟠🟢🔵🟣 ${data.link}");
            Get.to(
              YoutubeVideoPlayer(
                url: data.link,
                name: data.name,
                title: data.title,
                description: data.description,
                id: normalizeAndLogId(
                  data.toJson()['id'],
                  source: 'recent_views_controller',
                ),
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
                id: normalizeAndLogId(
                  data.key,
                  source: 'recent_views_controller',
                ),
              ),
            );
          }
          _isDetailsLoading.value = false;
          update();
        })
        .catchError((onError) {
          log.e(onError);
        });

    _isDetailsLoading.value = false;
    update();
    return _watchListDetailsModel2;
  }
}
