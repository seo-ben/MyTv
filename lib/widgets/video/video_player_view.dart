import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

import '../../main.dart';
import '../../utils/basic_screen_imports.dart';
import '../../utils/device_info.dart';

class VideoPlayerView extends StatefulWidget {
  const VideoPlayerView({
    super.key,
    required this.url,
    required this.dataSourceType,
  });

  final String url;
  final DataSourceType dataSourceType;

  @override
  State<VideoPlayerView> createState() => _VideoPlayerViewState();
}

class _VideoPlayerViewState extends State<VideoPlayerView> {
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;
  final double _aspectRatio = 1.75;

  @override
  void initState() {
    super.initState();

    switch (widget.dataSourceType) {
      case DataSourceType.asset:
        _videoPlayerController = VideoPlayerController.asset(widget.url);
        break;
      case DataSourceType.network:
        _videoPlayerController = VideoPlayerController.networkUrl(
          Uri.parse(widget.url),
        );
        break;
      case DataSourceType.file:
        _videoPlayerController = VideoPlayerController.file(File(widget.url));
        break;
      case DataSourceType.contentUri:
        _videoPlayerController = VideoPlayerController.contentUri(
          Uri.parse(widget.url),
        );
        break;
    }

    _chewieController = ChewieController(
      allowedScreenSleep: false,
      allowFullScreen: true,
      zoomAndPan: true,
      autoInitialize: true,
      deviceOrientationsAfterFullScreen: [
        DeviceOrientation.landscapeRight,
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ],
      videoPlayerController: _videoPlayerController,
      aspectRatio: _aspectRatio,
      autoPlay: true,
      useRootNavigator: true,
      isLive: false,
    );

    _chewieController.addListener(() {
      if (_chewieController.isFullScreen) {
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.landscapeRight,
          DeviceOrientation.landscapeLeft,
        ]);
      } else {
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ]);
      }
    });
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12.r),
          child: AspectRatio(
            aspectRatio: _aspectRatio,
            child: KeyboardListener(
              autofocus: true,
              focusNode: FocusNode(debugLabel: "ssss", canRequestFocus: true),
              onKeyEvent: (onKey) {
                if (onKey is KeyDownEvent) {
                  if (onKey.logicalKey == LogicalKeyboardKey.exit) {
                    _chewieController.exitFullScreen();
                  } else if (onKey.logicalKey ==
                      LogicalKeyboardKey.audioVolumeMute) {
                    _chewieController.setVolume(0);
                  } else if (onKey.logicalKey ==
                      LogicalKeyboardKey.mediaPlayPause) {
                    if (_chewieController.isPlaying) {
                      _chewieController.pause();
                    } else {
                      _chewieController.play();
                    }
                  } else if (onKey.logicalKey == LogicalKeyboardKey.arrowLeft) {
                    final currentPosition =
                        _chewieController.videoPlayerController.value.position;
                    _chewieController.seekTo(
                      currentPosition - const Duration(seconds: 10),
                    );
                  } else if (onKey.logicalKey ==
                      LogicalKeyboardKey.arrowRight) {
                    final currentPosition =
                        _chewieController.videoPlayerController.value.position;
                    _chewieController.seekTo(
                      currentPosition + const Duration(seconds: 10),
                    );
                  } else if (onKey.logicalKey == LogicalKeyboardKey.arrowUp) {
                    double newVolume =
                        (_chewieController.videoPlayerController.value.volume +
                                0.1)
                            .clamp(0.0, 1.0);
                    _chewieController.setVolume(newVolume);
                  } else if (onKey.logicalKey == LogicalKeyboardKey.arrowDown) {
                    double newVolume =
                        (_chewieController.videoPlayerController.value.volume -
                                0.1)
                            .clamp(0.0, 1.0);
                    _chewieController.setVolume(newVolume);
                  }
                }
              },
              child: Chewie(controller: _chewieController),
            ),
          ),
        ),
        Visibility(
          visible: DeviceInfo.isTv,
          child: Positioned(
            bottom: 12,
            right: 5,
            child: FloatingActionButton(
              elevation: 0,
              backgroundColor: Colors.transparent,
              onPressed: () {
                _chewieController.enterFullScreen();
              },
              child: const Icon(Icons.fullscreen, color: Colors.white),
            ),
          ),
        ),
        Visibility(
          visible: DeviceInfo.isTv,
          child: Positioned(
            bottom: 12,
            left: 5,
            child: FloatingActionButton(
              elevation: 0,
              backgroundColor: Colors.transparent,
              onPressed: () {
                _chewieController.enterFullScreen();
              },
              child: const Icon(Icons.fullscreen, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
