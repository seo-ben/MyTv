import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;

import '../../backend/model/authorization/custom_advertisement_model.dart';
import '../../backend/services/api_endpoint.dart';
import '../../controller/custom_ad_controller.dart';
import '../../utils/custom_color.dart';

class CustomVideoAdPlayer extends StatefulWidget {
  final CustomAd ad;
  final VoidCallback onAdFinished;

  const CustomVideoAdPlayer({
    Key? key,
    required this.ad,
    required this.onAdFinished,
  }) : super(key: key);

  @override
  State<CustomVideoAdPlayer> createState() => _CustomVideoAdPlayerState();
}

class _CustomVideoAdPlayerState extends State<CustomVideoAdPlayer> {
  final controller = Get.find<CustomAdController>();
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;
  late int _remainingTime;
  Timer? _timer;
  bool _canSkip = false;

  @override
  void initState() {
    super.initState();
    _remainingTime = widget.ad.displayDuration;
    controller.recordAdView(widget.ad.id);
    _initializePlayer();
  }

  Future<void> _initializePlayer() async {
    String videoUrl = widget.ad.videoUrl ?? "";
    if (!videoUrl.startsWith("http")) {
      videoUrl = "${ApiEndpoint.mainDomain}/storage/custom-ads/$videoUrl";
    }

    _videoPlayerController = VideoPlayerController.networkUrl(
      Uri.parse(videoUrl),
    );

    await _videoPlayerController.initialize();

    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoPlay: true,
      looping: false,
      showControls: false, // Hide default controls handling manually
      aspectRatio: _videoPlayerController.value.aspectRatio,
    );

    setState(() {});

    _videoPlayerController.addListener(() {
      if (_videoPlayerController.value.position >=
          _videoPlayerController.value.duration) {
        // Video finished
        widget.onAdFinished();
      }
    });

    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingTime > 0) {
        setState(() {
          _remainingTime--;
        });
      } else {
        setState(() {
          _canSkip = true;
        });
        _timer?.cancel();
      }
    });
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController?.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void _onAdClick() {
    controller.onAdClicked(widget.ad);
    // Pause video on click?
    _videoPlayerController.pause();
  }

  @override
  Widget build(BuildContext context) {
    if (_chewieController == null ||
        !_videoPlayerController.value.isInitialized) {
      return const Center(child: CircularProgressIndicator());
    }

    return Stack(
      children: [
        // Video Player
        Positioned.fill(
          child: GestureDetector(
            onTap: _onAdClick,
            child: Chewie(controller: _chewieController!),
          ),
        ),

        // Skip / Countdown Button
        Positioned(
          bottom: 20,
          right: 20,
          child: GestureDetector(
            onTap: _canSkip ? widget.onAdFinished : null,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.7),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: Colors.white.withOpacity(0.3)),
              ),
              child: Text(
                _canSkip ? "Skip Ad >" : "Skip in $_remainingTime",
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),

        // Learn More Button (if Click URL exists)
        if (widget.ad.clickUrl != null)
          Positioned(
            bottom: 20,
            left: 20,
            child: GestureDetector(
              onTap: _onAdClick,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: CustomColor.primaryLightColor.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: const Text(
                  "Learn More",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
