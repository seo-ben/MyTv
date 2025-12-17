import 'package:get/get.dart';

import '../../../backend/model/drawer/highlight/highlight_model.dart';
import '../../../backend/services/video/video_services.dart';
import '../../../backend/utils/api_method.dart';

class HighlightScreenController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    getProfileInfoProcess();
  }

  /// >> set loading process & Profile Info Model
  final _isLoading = false.obs;
  late HighLightModel _highlightModel;

  /// >> get loading process & Profile Info Model
  bool get isLoading => _isLoading.value;

  HighLightModel get highlightModel => _highlightModel;

  ///* Get profile info api process
  Future<HighLightModel> getProfileInfoProcess() async {
    _isLoading.value = true;
    update();

    await VideoServices.getHighlightsGetApi().then((value) {
      _highlightModel = value!;

      _isLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });

    _isLoading.value = false;
    update();
    return _highlightModel;
  }
}
