import 'package:get/get.dart';
import 'package:flutter/foundation.dart';
import 'package:MyTelevision/backend/model/common/common_success_model.dart';
import 'package:MyTelevision/backend/services/video/video_services.dart';

import '../../backend/utils/api_method.dart';
import '../../backend/utils/custom_snackbar.dart';

class CustomVideoPlayerController extends GetxController {
  /// >> set loading process & Sign In Model
  final _isLoading = false.obs;
  CommonSuccessModel _watchListAddModel = CommonSuccessModel(
    message: Message(success: []),
  );

  /// >> get loading process & Sign In Model
  bool get isLoading => _isLoading.value;

  CommonSuccessModel get watchListAddModel => _watchListAddModel;

  ///* Watchlist add process
  Future<CommonSuccessModel> watchListAddProcess(String id) async {
    // Guard: ensure id is present
    if (id.trim().isEmpty) {
      debugPrint('⛔ watchListAddProcess blocked: empty id received');
      return _watchListAddModel;
    }

    _isLoading.value = true;
    update();
    // Build request body with expected backend parameter
    Map<String, dynamic> inputBody = {};
    // backend expects numeric sports_id; try to parse, fallback to string
    final parsedId = int.tryParse(id);
    // Send sports_id as an array (many backends expect an array of ids)
    inputBody['sports_id'] = parsedId != null ? [parsedId] : [id];
    // Also include common alternative keys the backend might accept
    inputBody['id'] = parsedId ?? id;
    inputBody['video_id'] = parsedId ?? id;
    inputBody['watchlist_id'] = parsedId ?? id;

    // Prefer numeric id in URL if possible
    final idForUrl = parsedId != null ? parsedId.toString() : id;

    debugPrint(
      '🔍 Controller: parsedId=$parsedId, idForUrl=$idForUrl, inputBody=$inputBody',
    );
    log.i(
      '📌 watchListAddProcess - sending body: $inputBody and id in url: $idForUrl',
    );

    // If parsedId is numeric, prefer calling the API with the id in the URL
    // and no body (backend expects the sport id in the path). Otherwise
    // fallback to sending the constructed body.
    final bool useUrlOnly = parsedId != null;

    await VideoServices.watchlistAddApi(
          body: useUrlOnly ? null : inputBody,
          id: idForUrl,
        )
        .then((value) {
          if (value != null) {
            _watchListAddModel = value;
          } else {
            _watchListAddModel = CommonSuccessModel(
              message: Message(success: ['Something went wrong']),
            );
          }

          _isLoading.value = false;
          update();
        })
        .catchError((onError) {
          log.e(onError);
          _watchListAddModel = CommonSuccessModel(
            message: Message(success: ['Something went wrong']),
          );
          _isLoading.value = false;
          update();
        });

    _isLoading.value = false;
    update();
    return _watchListAddModel;
  }
}
