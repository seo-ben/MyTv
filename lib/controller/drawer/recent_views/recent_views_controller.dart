import '../../../backend/model/details/details_model.dart';
import '../../../backend/model/drawer/recent_views/recent_views_model.dart';
import '/backend/model/details/category_details_model.dart';

import '../../../backend/services/video/video_services.dart';
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


  late RecentViewsModel _recentViewsModel;
  RecentViewsModel get recentViewsModel => _recentViewsModel;


  ///* Get RecentViews in process
  Future<RecentViewsModel> recentViewsProcess() async {
    _isLoading.value = true;
    update();
    await VideoServices.recentViewsProcessApi().then((value) {
      _recentViewsModel = value!;
      _isLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isLoading.value = false;
    update();
    return _recentViewsModel;
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
    await VideoServices.getWatchListApi(id).then((value) {
      _watchListDetailsModel = value!;
      var data = _watchListDetailsModel.data;
      if (data.link.contains("youtube")) {
        debugPrint("🔴🟠🟢🔵🟣 ${data.link}");
        Get.to(YoutubeVideoPlayer(
          url: data.link,
          name: data.name,
          title: data.title,
          description: data.description,
          id: data.id.toString(),
        ));
      } else {
        debugPrint("🔴🟠🟢🔵🟣 ${data.link}");
        Get.to(
          VideoPlayerScreen(
              url: data.link,
              name: data.name,
              title: data.title,
              description: data.description,
              id: data.id.toString()),
        );
      }
      _isDetailsLoading.value = false;
      update();
    }).catchError((onError) {
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
    await VideoServices.getFootballDetailsApi(id).then((value) {
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
            id: "",
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
            id: "",
          ),
        );
      }
      _isDetailsLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });

    _isDetailsLoading.value = false;
    update();
    return _watchListDetailsModel2;
  }

}
