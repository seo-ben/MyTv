import '/backend/model/details/category_details_model.dart';

import '../../../backend/model/common/common_success_model.dart';
import '../../../backend/model/drawer/watch_list/watch_list_model.dart';
import '../../../backend/services/video/video_services.dart';
import 'package:MyTelevision/helpers/id_utils.dart';
import '../../../backend/utils/api_method.dart';
import '../../../utils/basic_screen_imports.dart';
import '../../../views/video_player_screen.dart';
import '../../../views/youtube_video_player_screen.dart';

class WatchListScreenController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    getProfileInfoProcess();
  }

  /// >> set loading process & Profile Info Model
  final _isLoading = false.obs;
  late WatchListModel _watchListModel;

  /// >> get loading process & Profile Info Model
  bool get isLoading => _isLoading.value;

  WatchListModel get watchListModel => _watchListModel;

  ///* Get profile info api process
  Future<WatchListModel> getProfileInfoProcess() async {
    _isLoading.value = true;
    update();
    await VideoServices.getWatchListVideoApi()
        .then((value) {
          _watchListModel = value!;

          _isLoading.value = false;
          update();
        })
        .catchError((onError) {
          log.e(onError);
        });

    _isLoading.value = false;
    update();
    return _watchListModel;
  }

  /// >> set loading process & Profile Info Model
  final _isDetailsLoading = false.obs;
  late CategoryDetailsModel _watchListDetailsModel;

  /// >> get loading process & Profile Info Model
  bool get isDetailsLoading => _isDetailsLoading.value;

  CategoryDetailsModel get watchListDetailsModel => _watchListDetailsModel;

  ///* Get profile info api process
  Future<CategoryDetailsModel> getDetailsProcess(String id) async {
    _isDetailsLoading.value = true;
    update();
    await VideoServices.getWatchListApi(id)
        .then((value) {
          _watchListDetailsModel = value!;
          var data = _watchListDetailsModel.data;
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
                  source: 'watch_list_screen_controller',
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
                  source: 'watch_list_screen_controller',
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

  /// >> set loading process & Sign In Model
  final _isDeleteLoading = false.obs;
  late CommonSuccessModel _watchListDeleteModel;

  /// >> get loading process & Sign In Model
  bool get isDeleteLoading => _isDeleteLoading.value;

  CommonSuccessModel get watchListDeleteModel => _watchListDeleteModel;

  ///* Watchlist add process
  Future<CommonSuccessModel> watchListDeleteProcess(String id) async {
    _isDeleteLoading.value = true;
    update();
    Map<String, dynamic> inputBody = {};

    await VideoServices.watchListDeleteApi(body: inputBody, id: id)
        .then((value) {
          _watchListDeleteModel = value!;
          getProfileInfoProcess();
          _isDeleteLoading.value = false;
          update();
        })
        .catchError((onError) {
          log.e(onError);
        });
    _isDeleteLoading.value = false;
    update();
    return _watchListDeleteModel;
  }
}
