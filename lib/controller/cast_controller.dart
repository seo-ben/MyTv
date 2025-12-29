import 'dart:async';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chrome_cast/flutter_chrome_cast.dart';
import '../helpers/cast_permissions_helper.dart';

class CastController extends GetxController {
  final Logger _logger = Logger();
  final _sessionManager = GoogleCastSessionManager.instance;
  final _remoteMediaClient = GoogleCastRemoteMediaClient.instance;
  final RxBool isConnected = false.obs;
  final RxBool isConnecting = false.obs;

  final _discoveryManager = GoogleCastDiscoveryManager.instance;
  final RxList<GoogleCastDevice> devices = <GoogleCastDevice>[].obs;
  GoogleCastDevice? _connectedDevice;

  @override
  void onInit() {
    super.onInit();
    _initSessionManager();
    _startDiscovery();
  }

  @override
  void onClose() {
    _discoveryManager.stopDiscovery();
    super.onClose();
  }

  void _initSessionManager() {
    _sessionManager.currentSessionStream.listen((session) {
      isConnected.value = session != null;
      isConnecting.value = false;

      if (isConnected.value) {
        _logger.i(
          '✅ Cast Connected to: ${_connectedDevice?.friendlyName ?? "Unknown Device"}',
        );
      } else {
        _logger.i('❌ Cast Disconnected');
        _connectedDevice = null;
      }
    });
  }

  void _startDiscovery() {
    _logger.i('🔍 Starting Cast discovery...');

    try {
      _discoveryManager.startDiscovery();
      _logger.i('✅ Discovery started successfully');
    } catch (e) {
      _logger.e('❌ Failed to start discovery: $e');
    }

    _discoveryManager.devicesStream.listen(
      (deviceList) {
        _logger.i('📡 Discovery update - Devices found: ${deviceList.length}');

        if (deviceList.isNotEmpty) {
          for (var device in deviceList) {
            _logger.i(
              '  📺 Device: ${device.friendlyName} - ${device.modelName ?? "Unknown model"}',
            );
          }
        }

        devices.assignAll(deviceList);
      },
      onError: (error) {
        _logger.e('❌ Discovery stream error: $error');
      },
    );
  }

  void connectToDevice(
    GoogleCastDevice device, {
    String? url,
    String? title,
    String? description,
  }) async {
    if (isConnecting.value) {
      _logger.w('⚠️ Connection already in progress');
      return;
    }

    try {
      isConnecting.value = true;
      _connectedDevice = device;

      _logger.i('🔌 Connecting to device: ${device.friendlyName}');
      _logger.i('   Device model: ${device.modelName ?? "Unknown"}');

      Get.snackbar(
        'Connexion en cours',
        'Connexion à ${device.friendlyName}...',
        duration: const Duration(seconds: 5),
        showProgressIndicator: true,
        snackPosition: SnackPosition.BOTTOM,
      );

      // Create a completer to handle async connection
      final completer = Completer<bool>();

      // Listen for session changes
      final subscription = _sessionManager.currentSessionStream.listen((
        session,
      ) {
        if (session != null && !completer.isCompleted) {
          _logger.i('✅ Session established!');
          completer.complete(true);
        }
      });

      // Start the session
      _logger.i('📡 Starting session with device...');
      await _sessionManager.startSessionWithDevice(device);

      // Wait for connection with timeout (increased to 15 seconds)
      final connected = await completer.future.timeout(
        const Duration(seconds: 15),
        onTimeout: () {
          _logger.e('⏱️ Connection timeout after 15 seconds');
          return false;
        },
      );

      // Cancel subscription
      await subscription.cancel();

      if (!connected) {
        throw Exception(
          'Impossible de se connecter au Chromecast.\n'
          'Vérifiez que:\n'
          '• Le Chromecast est allumé\n'
          '• Vous êtes sur le même réseau Wi-Fi\n'
          '• Aucun autre appareil n\'utilise le Chromecast',
        );
      }

      _logger.i('✅ Successfully connected to ${device.friendlyName}');

      Get.snackbar(
        'Connecté',
        'Connecté à ${device.friendlyName}',
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.green.withOpacity(0.8),
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );

      // Auto-cast media if URL provided
      if (url != null && url.isNotEmpty) {
        _logger.i('🎬 Auto-casting media after connection');
        await Future.delayed(const Duration(milliseconds: 2000));
        await castMedia(
          url,
          title: title ?? 'Video',
          description: description ?? '',
        );
      }
    } catch (e) {
      _logger.e('❌ Error connecting to device: $e');
      _connectedDevice = null;

      String errorMessage = 'Impossible de se connecter';

      if (e.toString().contains('timeout') ||
          e.toString().contains('Timeout')) {
        errorMessage =
            'Délai de connexion dépassé.\n'
            'Vérifiez que le Chromecast est disponible.';
      } else if (e.toString().contains('Impossible de se connecter')) {
        errorMessage = e.toString().replaceAll('Exception: ', '');
      } else {
        errorMessage = 'Erreur: ${e.toString().replaceAll('Exception: ', '')}';
      }

      Get.snackbar(
        'Connexion échouée',
        errorMessage,
        duration: const Duration(seconds: 5),
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isConnecting.value = false;
    }
  }

  Future<void> disconnect() async {
    try {
      _logger.i('🔌 Disconnecting from Cast device...');
      await _sessionManager.endSessionAndStopCasting();
      _logger.i('✅ Disconnected successfully');
    } catch (e) {
      _logger.e('❌ Error disconnecting: $e');
    }
  }

  void showDeviceSelectionDialog(
    BuildContext context, {
    String? url,
    String? title,
    String? description,
  }) {
    final RxBool isSearching = true.obs;

    // Force refresh devices
    try {
      _discoveryManager.stopDiscovery();
      Future.delayed(const Duration(milliseconds: 300), () {
        _discoveryManager.startDiscovery();
      });
    } catch (e) {
      _logger.e('Error refreshing discovery: $e');
    }

    // Stop searching after timeout
    Future.delayed(const Duration(seconds: 10), () {
      isSearching.value = false;
    });

    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          padding: const EdgeInsets.all(20),
          constraints: const BoxConstraints(maxWidth: 400, maxHeight: 500),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  const Icon(Icons.cast, size: 28),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text(
                      'Appareils disponibles',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Get.back(),
                  ),
                ],
              ),
              const Divider(height: 24),
              Flexible(
                child: Obx(() {
                  if (devices.isNotEmpty) {
                    return ListView.separated(
                      shrinkWrap: true,
                      itemCount: devices.length,
                      separatorBuilder: (context, index) => const Divider(),
                      itemBuilder: (context, index) {
                        final device = devices[index];
                        return ListTile(
                          leading: const Icon(Icons.tv, size: 32),
                          title: Text(
                            device.friendlyName,
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                          subtitle: Text(device.modelName ?? 'Chromecast'),
                          trailing: const Icon(
                            Icons.arrow_forward_ios,
                            size: 16,
                          ),
                          onTap: () {
                            Get.back();
                            connectToDevice(
                              device,
                              url: url,
                              title: title,
                              description: description,
                            );
                          },
                        );
                      },
                    );
                  } else if (isSearching.value) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(32.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CircularProgressIndicator(),
                            SizedBox(height: 20),
                            Text(
                              'Recherche d\'appareils...',
                              style: TextStyle(fontSize: 16),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Assurez-vous que votre appareil est allumé',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.search_off,
                              size: 48,
                              color: Colors.grey,
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              'Aucun appareil trouvé',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Vérifiez que votre Chromecast est:\n• Allumé\n• Sur le même réseau Wi-Fi',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.grey),
                            ),
                            const SizedBox(height: 16),
                            ElevatedButton.icon(
                              onPressed: () {
                                isSearching.value = true;
                                _discoveryManager.stopDiscovery();
                                Future.delayed(
                                  const Duration(milliseconds: 300),
                                  () {
                                    _discoveryManager.startDiscovery();
                                  },
                                );
                                Future.delayed(const Duration(seconds: 10), () {
                                  isSearching.value = false;
                                });
                              },
                              icon: const Icon(Icons.refresh),
                              label: const Text('Réessayer'),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                }),
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: true,
    );
  }

  Future<void> castMedia(
    String url, {
    String title = 'Video',
    String description = '',
  }) async {
    if (!isConnected.value) {
      _logger.w('⚠️ Attempted to cast while not connected');
      Get.snackbar(
        'Non connecté',
        'Veuillez vous connecter à un appareil Cast.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    try {
      _logger.i('🎬 Attempting to cast media: $url');

      await _remoteMediaClient.loadMedia(
        GoogleCastMediaInformation(
          contentId: url,
          contentUrl: Uri.parse(url),
          contentType: 'application/x-mpegurl',
          streamType: CastMediaStreamType.buffered,
          metadata: GoogleCastGenericMediaMetadata(
            title: title,
            subtitle: description,
          ),
        ),
        autoPlay: true,
      );

      _logger.i('✅ Media cast command sent successfully');

      Get.snackbar(
        'Lecture en cours',
        title,
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.blue.withOpacity(0.8),
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      _logger.e('❌ Error casting media: $e');

      Get.snackbar(
        'Erreur de lecture',
        'Impossible de lire la vidéo: ${e.toString()}',
        duration: const Duration(seconds: 3),
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  // Control playback
  Future<void> play() async {
    try {
      await _remoteMediaClient.play();
      _logger.i('▶️ Playing');
    } catch (e) {
      _logger.e('Error playing: $e');
    }
  }

  Future<void> pause() async {
    try {
      await _remoteMediaClient.pause();
      _logger.i('⏸️ Paused');
    } catch (e) {
      _logger.e('Error pausing: $e');
    }
  }

  Future<void> stop() async {
    try {
      await _remoteMediaClient.stop();
      _logger.i('⏹️ Stopped');
    } catch (e) {
      _logger.e('Error stopping: $e');
    }
  }
}
