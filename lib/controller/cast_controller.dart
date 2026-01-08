import 'package:get/get.dart';
import 'package:logger/logger.dart';

// Dummy implementation to avoid compilation errors while Cast is disabled
class CastController extends GetxController {
  final Logger _logger = Logger();
  
  final RxBool isConnected = false.obs;
  final RxBool isConnecting = false.obs;

  void onButtonCreated(dynamic controller) {
    _logger.i('⚠️ Cast functionality is disabled');
  }

  void onSessionStarted() {
    _logger.i('⚠️ Cast functionality is disabled');
  }

  void onSessionEnded() {
    _logger.i('⚠️ Cast functionality is disabled');
  }

  void onRequestFailed(String? error) {
    _logger.i('⚠️ Cast functionality is disabled');
  }

  Future<void> castMedia(
    String url, {
    String title = 'Video',
    String description = '',
  }) async {
    _logger.i('⚠️ Attempted to cast media (disabled): $url');
  }

  Future<void> play() async {}
  Future<void> pause() async {}
  Future<void> stop() async {}
}
