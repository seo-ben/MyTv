import '../../../language/language_controller.dart';
import '../../../utils/basic_screen_imports.dart';
import '../../model/drawer/recent_views/recent_views_model.dart';
import '/backend/model/drawer/highlight/highlight_model.dart';
import '../../model/common/common_success_model.dart';
import '../../model/details/category_details_model.dart';
import '../../model/details/details_model.dart';
import '../../model/drawer/live_video/live_video_model.dart';
import '../../model/drawer/subscription/subscription_model.dart';
import '../../model/drawer/watch_list/watch_list_model.dart';
import '../../utils/api_method.dart';
import '../../utils/custom_snackbar.dart';
import '../api_endpoint.dart';

class VideoServices {
  ///* Get Highlights info process api
  static Future<HighLightModel?> getHighlightsGetApi() async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(
        isBasic: false,
      ).get(ApiEndpoint.highlightVideosURL, code: 200, showResult: true);
      if (mapResponse != null) {
        HighLightModel result = HighLightModel.fromJson(mapResponse);

        return result;
      }
    } catch (e) {
      log.e(
        '🐞🐞🐞 err from  Get Highlights info process api service ==> $e 🐞🐞🐞',
      );
      CustomSnackBar.error('Something went Wrong');
      return null;
    }
    return null;
  }

  ///* Get Live Video info process api
  static Future<LiveVideoModel?> getLiveVideoGetApi() async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(
        isBasic: false,
      ).get(ApiEndpoint.liveVideosURL, code: 200, showResult: true);
      if (mapResponse != null) {
        LiveVideoModel result = LiveVideoModel.fromJson(mapResponse);

        return result;
      }
    } catch (e) {
      log.e(
        '🐞🐞🐞 err from  Get Live Video info process api service ==> $e 🐞🐞🐞',
      );
      CustomSnackBar.error('Something went Wrong');
      return null;
    }
    return null;
  }

  ///* Get Watch Video info process api
  static Future<WatchListModel?> getWatchListVideoApi() async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(
        isBasic: false,
      ).get(ApiEndpoint.watchListVideosURL, code: 200, showResult: true);
      if (mapResponse != null) {
        WatchListModel result = WatchListModel.fromJson(mapResponse);

        return result;
      }
    } catch (e) {
      log.e(
        '🐞🐞🐞 err from  Get Watch Video info process api service ==> $e 🐞🐞🐞',
      );
      CustomSnackBar.error('Something went Wrong');
      return null;
    }
    return null;
  }

  ///* Get Watch Video info process api
  static Future<CategoryDetailsModel?> getWatchListApi(String id) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).get(
        "${ApiEndpoint.watchListDetailsURL}/$id?lang=${Get.find<LanguageController>().selectedLanguage.value}",
        code: 200,
        showResult: true,
      );
      if (mapResponse != null) {
        CategoryDetailsModel result = CategoryDetailsModel.fromJson(
          mapResponse,
        );

        return result;
      }
    } catch (e) {
      log.e(
        '🐞🐞🐞 err from  Get Watch Video info process api service ==> $e 🐞🐞🐞',
      );
      CustomSnackBar.error('Something went Wrong');
      return null;
    }
    return null;
  }

  ///* Get Watch Video info process api
  static Future<DetailsModel?> getFootballDetailsApi(String id) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).get(
        "${ApiEndpoint.footballDetailsURL}/$id?lang=${Get.find<LanguageController>().selectedLanguage.value}",
        code: 200,
        showResult: true,
      );
      if (mapResponse != null) {
        DetailsModel result = DetailsModel.fromJson(mapResponse);

        return result;
      }
    } catch (e) {
      log.e(
        '🐞🐞🐞 err from  Get Watch Video info process api service ==> $e 🐞🐞🐞',
      );
      CustomSnackBar.error('Something went Wrong');
      return null;
    }
    return null;
  }

  ///* Get Watch Video info process api
  static Future<SubscriptionModel?> getSubscriptionDataApi() async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(
        isBasic: false,
      ).get(ApiEndpoint.subscriptionPageURL, code: 200, showResult: true);
      if (mapResponse != null) {
        SubscriptionModel result = SubscriptionModel.fromJson(mapResponse);

        return result;
      }
    } catch (e) {
      log.e(
        '🐞🐞🐞 err from  Get Watch Video info process api service ==> $e 🐞🐞🐞',
      );
      CustomSnackBar.error('Something went Wrong');
      return null;
    }
    return null;
  }

  ///* watch list add in api services
  static Future<CommonSuccessModel?> watchlistAddApi({
    Map<String, dynamic>? body,
    required String id,
  }) async {
    Map<String, dynamic>? mapResponse;

    try {
      final url =
          "${ApiEndpoint.watchListAddURL}$id?lang=${Get.find<LanguageController>().selectedLanguage.value}";
      // Log the final request URL and body for debugging id flow
      debugPrint('🔗 watchlistAddApi -> URL: $url');
      debugPrint('📦 watchlistAddApi -> body: $body');

      // If body is null, send an empty map so ApiMethod.post can jsonEncode safely.
      final bodyToSend = body ?? <String, dynamic>{};

      mapResponse = await ApiMethod(
        isBasic: false,
      ).post(url, bodyToSend, code: 200, showResult: true);
      if (mapResponse != null) {
        CommonSuccessModel result = CommonSuccessModel.fromJson(mapResponse);
        CustomSnackBar.success(result.message.success.first.toString());
        return result;
      }
    } catch (e) {
      log.e('🐞🐞🐞 err from Sign in api service ==> $e 🐞🐞🐞');
      CustomSnackBar.error('Something went Wrong! in Watch list add');
      return null;
    }
    return null;
  }

  ///* watch list delete in api services
  static Future<CommonSuccessModel?> watchListDeleteApi({
    required Map<String, dynamic> body,
    required String id,
  }) async {
    Map<String, dynamic>? mapResponse;

    try {
      mapResponse = await ApiMethod(isBasic: false).delete(
        "${ApiEndpoint.watchlistDeleteURL}/$id?lang=${Get.find<LanguageController>().selectedLanguage.value}",
        code: 200,
        showResult: true,
      );
      if (mapResponse != null) {
        CommonSuccessModel result = CommonSuccessModel.fromJson(mapResponse);

        return result;
      }
    } catch (e) {
      log.e('🐞🐞🐞 err from Sign in api service ==> $e 🐞🐞🐞');
      CustomSnackBar.error('Something went Wrong! in Watch list delete');
      return null;
    }
    return null;
  }

  ///* Get RecentViews api services
  static Future<RecentViewsModel?> recentViewsProcessApi() async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(
        isBasic: false,
      ).get(ApiEndpoint.recentViewsURL);
      if (mapResponse != null) {
        RecentViewsModel result = RecentViewsModel.fromJson(mapResponse);
        // CustomSnackBar.success(result.message.success.first.toString());
        return result;
      }
    } catch (e) {
      log.e(
        ':ladybug::ladybug::ladybug: err from RecentViews api service ==> $e :ladybug::ladybug::ladybug:',
      );
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }
}
