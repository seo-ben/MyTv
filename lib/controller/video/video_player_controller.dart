import 'package:get/get.dart';
import 'package:MyTelevision/backend/model/common/common_success_model.dart';
import 'package:MyTelevision/backend/services/video/video_services.dart';

import '../../backend/utils/api_method.dart';

class CustomVideoPlayerController extends GetxController {
  /// >> set loading process & Sign In Model
  final _isLoading = false.obs;
  late CommonSuccessModel _watchListAddModel;

  /// >> get loading process & Sign In Model
  bool get isLoading => _isLoading.value;

  CommonSuccessModel get watchListAddModel => _watchListAddModel;

  ///* Watchlist add process
  Future<CommonSuccessModel> watchListAddProcess(String id) async {
    _isLoading.value = true;
    update();
    Map<String, dynamic> inputBody = {};

    await VideoServices.watchlistAddApi(body: inputBody, id: id)
        .then((value) {
          _watchListAddModel = value!;

          _isLoading.value = false;
          update();
        })
        .catchError((onError) {
          log.e(onError);
        });
    _isLoading.value = false;
    update();
    return _watchListAddModel;
  }
}
