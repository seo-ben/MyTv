import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../backend/model/authorization/custom_advertisement_model.dart';
import '../../backend/services/api_endpoint.dart';
import '../../controller/custom_ad_controller.dart';
import '../../utils/custom_color.dart';

class CustomInterstitialAdWidget extends StatefulWidget {
  final CustomAd ad;

  const CustomInterstitialAdWidget({super.key, required this.ad});

  @override
  State<CustomInterstitialAdWidget> createState() =>
      _CustomInterstitialAdWidgetState();
}

class _CustomInterstitialAdWidgetState
    extends State<CustomInterstitialAdWidget> {
  final controller = Get.find<CustomAdController>();
  late Timer _timer;
  late int _remainingTime;
  bool _canClose = false;

  @override
  void initState() {
    super.initState();
    _remainingTime = widget.ad.displayDuration;
    controller.recordAdView(widget.ad.id); // Record view when displayed

    if (_remainingTime > 0) {
      _startTimer();
    } else {
      _canClose = true;
    }
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingTime > 0) {
        setState(() {
          _remainingTime--;
        });
      } else {
        setState(() {
          _canClose = true;
        });
        _timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    if (_remainingTime > 0) _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Ad Content (Image)
          Positioned.fill(
            child: GestureDetector(
              onTap: () => controller.onAdClicked(widget.ad),
              child: Builder(
                builder: (context) {
                  String imageUrl = widget.ad.imageUrl ?? "";
                  if (!imageUrl.startsWith("http")) {
                    imageUrl =
                        "${ApiEndpoint.mainDomain}/storage/custom-ads/$imageUrl";
                  }
                  return Image.network(
                    imageUrl,
                    fit: BoxFit.contain,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return const Center(child: CircularProgressIndicator());
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return const Center(
                        child: Icon(Icons.error, color: Colors.white),
                      );
                    },
                  );
                },
              ),
            ),
          ),

          // Close Button / Timer
          Positioned(
            top: 40,
            right: 20,
            child: GestureDetector(
              onTap: _canClose ? () => Get.back() : null,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white.withOpacity(0.3)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (!_canClose)
                      Text(
                        "$_remainingTime s",
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    else
                      const Icon(
                        Iconsax.close_circle,
                        color: Colors.white,
                        size: 24,
                      ),
                  ],
                ),
              ),
            ),
          ),

          // "Ad" Label (Optional, for compliance/clarity)
          Positioned(
            top: 40,
            left: 20,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: CustomColor.primaryLightColor,
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Text(
                "Ad",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
