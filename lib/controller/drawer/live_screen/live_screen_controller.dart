import 'package:get/get.dart';

import '../../../backend/model/drawer/live_video/live_video_model.dart';
import '../../../backend/services/video/video_services.dart';
import '../../../backend/utils/api_method.dart';

class LiveScreenController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    getLiveVideosProcess();
  }

  /// >> set loading process & Profile Info Model
  final _isLoading = false.obs;
  late LiveVideoModel _liveVideoModel;

  /// >> get loading process & Profile Info Model
  bool get isLoading => _isLoading.value;

  LiveVideoModel get liveVideoModel => _liveVideoModel;

  ///* Get profile info api process
  Future<LiveVideoModel> getLiveVideosProcess() async {
    _isLoading.value = true;
    update();
    await VideoServices.getLiveVideoGetApi().then((value) {
      _liveVideoModel = value!;

      _isLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });

    _isLoading.value = false;
    update();
    return _liveVideoModel;
  }
}
