
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:logger/logger.dart';
import 'package:get/get.dart';

class CastPermissionsHelper {
  static final Logger _logger = Logger();

  /// Check if cast permissions are granted
  static Future<bool> checkCastPermissions() async {
    if (!Platform.isAndroid) {
      _logger.i('✅ Not Android - no permissions needed');
      return true;
    }

    try {
      final deviceInfo = DeviceInfoPlugin();
      final androidInfo = await deviceInfo.androidInfo;
      final sdkInt = androidInfo.version.sdkInt;

      _logger.i('📱 Android SDK: $sdkInt');

      // Android 13+ (API 33+) requires NEARBY_WIFI_DEVICES
      if (sdkInt >= 33) {
        final nearbyDevicesStatus = await Permission.nearbyWifiDevices.status;
        _logger.i('🔍 NEARBY_WIFI_DEVICES status: $nearbyDevicesStatus');
        return nearbyDevicesStatus.isGranted;
      }
      // Android 12 (API 31-32) requires ACCESS_FINE_LOCATION
      else if (sdkInt >= 31) {
        final locationStatus = await Permission.location.status;
        _logger.i('📍 LOCATION status: $locationStatus');
        return locationStatus.isGranted;
      }
      // Android 11 and below (API 30 and below)
      else {
        final locationStatus = await Permission.location.status;
        _logger.i('📍 LOCATION status: $locationStatus');
        return locationStatus.isGranted;
      }
    } catch (e) {
      _logger.e('❌ Error checking permissions: $e');
      return false;
    }
  }

  /// Request cast permissions with user-friendly dialog
  static Future<bool> requestCastPermissions(BuildContext context) async {
    if (!Platform.isAndroid) {
      return true;
    }

    try {
      final deviceInfo = DeviceInfoPlugin();
      final androidInfo = await deviceInfo.androidInfo;
      final sdkInt = androidInfo.version.sdkInt;

      _logger.i('📱 Requesting permissions for Android SDK: $sdkInt');

      PermissionStatus status;

      // Android 13+ (API 33+)
      if (sdkInt >= 33) {
        // Show explanation dialog first
        final shouldRequest = await _showPermissionRationaleDialog(
          context,
          title: 'Permission requise',
          message:
              'Pour découvrir les appareils Chromecast sur votre réseau, '
              'nous avons besoin de la permission "Appareils à proximité".\n\n'
              'Cette permission permet uniquement de détecter les appareils de diffusion.',
        );

        if (!shouldRequest) {
          _logger.i('⚠️ User declined permission request');
          return false;
        }

        status = await Permission.nearbyWifiDevices.request();
        _logger.i('🔍 NEARBY_WIFI_DEVICES request result: $status');
      }
      // Android 12 (API 31-32)
      else if (sdkInt >= 31) {
        final shouldRequest = await _showPermissionRationaleDialog(
          context,
          title: 'Permission de localisation',
          message:
              'Pour découvrir les appareils Chromecast, Android nécessite '
              'la permission de localisation.\n\n'
              'Cette permission est uniquement utilisée pour détecter les appareils '
              'sur votre réseau Wi-Fi local.',
        );

        if (!shouldRequest) {
          return false;
        }

        status = await Permission.location.request();
        _logger.i('📍 LOCATION request result: $status');
      }
      // Android 11 and below
      else {
        final shouldRequest = await _showPermissionRationaleDialog(
          context,
          title: 'Permission de localisation',
          message:
              'Pour découvrir les appareils Chromecast, nous avons besoin '
              'de la permission de localisation.\n\n'
              'Cette permission est uniquement utilisée pour détecter les appareils '
              'sur votre réseau Wi-Fi.',
        );

        if (!shouldRequest) {
          return false;
        }

        status = await Permission.location.request();
        _logger.i('📍 LOCATION request result: $status');
      }

      // Handle permission result
      if (status.isGranted) {
        _logger.i('✅ Permission granted');
        return true;
      } else if (status.isPermanentlyDenied) {
        _logger.w('⚠️ Permission permanently denied');
        await _showOpenSettingsDialog(context);
        return false;
      } else {
        _logger.w('⚠️ Permission denied');
        Get.snackbar(
          'Permission refusée',
          'La permission est nécessaire pour découvrir les appareils Chromecast',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.orange.withOpacity(0.8),
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
        );
        return false;
      }
    } catch (e) {
      _logger.e('❌ Error requesting permissions: $e');
      return false;
    }
  }

  /// Show rationale dialog before requesting permission
  static Future<bool> _showPermissionRationaleDialog(
    BuildContext context, {
    required String title,
    required String message,
  }) async {
    final result = await Get.dialog<bool>(
      AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: const Text('Annuler'),
          ),
          ElevatedButton(
            onPressed: () => Get.back(result: true),
            child: const Text('Continuer'),
          ),
        ],
      ),
      barrierDismissible: false,
    );

    return result ?? false;
  }

  /// Show dialog to open app settings
  static Future<void> _showOpenSettingsDialog(BuildContext context) async {
    final shouldOpen = await Get.dialog<bool>(
      AlertDialog(
        title: const Text('Permission requise'),
        content: const Text(
          'La permission a été refusée de manière permanente. '
          'Veuillez l\'activer dans les paramètres de l\'application.',
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: const Text('Annuler'),
          ),
          ElevatedButton(
            onPressed: () => Get.back(result: true),
            child: const Text('Ouvrir les paramètres'),
          ),
        ],
      ),
      barrierDismissible: false,
    );

    if (shouldOpen == true) {
      await openAppSettings();
    }
  }

  /// Check and request permissions in one call
  static Future<bool> ensureCastPermissions(BuildContext context) async {
    final hasPermissions = await checkCastPermissions();
    if (hasPermissions) {
      return true;
    }
    return await requestCastPermissions(context);
  }
}
