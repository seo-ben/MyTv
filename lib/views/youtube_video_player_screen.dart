import 'package:flutter/services.dart';

import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '/backend/utils/custom_loading_api.dart';
import '/utils/basic_screen_imports.dart';
import '/widgets/text_labels/title_heading5_widget.dart';
import '../controller/video/video_player_controller.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

class YoutubeVideoPlayer extends StatefulWidget {
  YoutubeVideoPlayer({
    super.key,
    required this.url,
    required this.name,
    required this.title,
    required this.description,
    required this.id,
  });

  final String url, name, title, description, id;
  final controller = Get.put(CustomVideoPlayerController());

  @override
  State<YoutubeVideoPlayer> createState() => _YoutubeVideoPlayerState();
}

class _YoutubeVideoPlayerState extends State<YoutubeVideoPlayer> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.url.split('=').last, // Example video ID
      flags: const YoutubePlayerFlags(autoPlay: true, mute: false),
    );
    WakelockPlus.enable(); // Activer le maintien de l'allumage de l'écran
    debugPrint(
      '▶️ YoutubeVideoPlayer.initState id=${widget.id} url=${widget.url}',
    );
    debugPrint(StackTrace.current.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TitleHeading2Widget(text: widget.title),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: CustomColor.whiteColor),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [IconButton(icon: const Icon(Icons.search), onPressed: () {})],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Dimensions.widthSize),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              verticalSpace(Dimensions.heightSize * 2),

              /// Video Player Section
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: KeyboardListener(
                  autofocus: true,
                  focusNode: FocusNode(
                    debugLabel: "ssss",
                    canRequestFocus: true,
                  ),
                  onKeyEvent: (onKey) {
                    if (onKey is KeyDownEvent) {
                      if (onKey.logicalKey == LogicalKeyboardKey.exit) {
                        _controller.value = YoutubePlayerValue(
                          isFullScreen: false,
                        );
                      }
                      if (onKey.logicalKey ==
                          LogicalKeyboardKey.audioVolumeMute) {
                        _controller.setVolume(0);
                      } else if (onKey.logicalKey ==
                          LogicalKeyboardKey.mediaPlayPause) {
                        if (_controller.flags.autoPlay) {
                          _controller.pause();
                        } else {
                          _controller.play();
                        }
                      } else if (onKey.logicalKey ==
                          LogicalKeyboardKey.arrowLeft) {
                        final currentPosition = _controller.value.position;
                        _controller.seekTo(
                          currentPosition - const Duration(seconds: 10),
                        );
                      } else if (onKey.logicalKey ==
                          LogicalKeyboardKey.arrowUp) {
                        double newVolume = (_controller.value.volume + 0.1)
                            .clamp(0.0, 1.0);
                        _controller.setVolume(int.parse(newVolume.toString()));
                      }
                    }
                  },
                  child: YoutubePlayerBuilder(
                    player: YoutubePlayer(
                      controller: _controller,
                      showVideoProgressIndicator: true,
                      progressIndicatorColor: Colors.red,
                    ),
                    builder: (context, player) {
                      return player;
                    },
                  ),
                ),
              ),
              verticalSpace(Dimensions.heightSize),
              TitleHeading2Widget(
                text: widget.title,
                fontSize: Dimensions.headingTextSize3,
                color: CustomColor.primaryLightColor,
              ),
              verticalSpace(Dimensions.heightSize),
              TitleHeading2Widget(
                text: widget.name,
                fontSize: Dimensions.headingTextSize3,
                color: CustomColor.primaryLightColor,
              ),
              verticalSpace(Dimensions.heightSize),
              TitleHeading5Widget(
                text: widget.description,
                fontSize: Dimensions.headingTextSize4,
              ),
              verticalSpace(Dimensions.heightSize * 2),
              verticalSpace(Dimensions.heightSize * 2),
              _buttonSection(context),
              verticalSpace(Dimensions.heightSize * 2),
              // showAdd(context),
            ],
          ),
        ),
      ),
    );
  }

  Padding showAdd(BuildContext context) {
    return const Padding(padding: EdgeInsets.zero, child: SizedBox.shrink());
  }

  /// Modified Button Section with "Add to My List" and "Share Now" Buttons
  Widget _buttonSection(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        widget.id == ""
            ? Container()
            : Expanded(
                child: Obx(
                  () => widget.controller.isLoading
                      ? const CustomLoadingAPI()
                      : PrimaryButton(
                          title: Strings.addToMyList,
                          icon: const Padding(
                            padding: EdgeInsets.only(right: 5.0),
                            child: Icon(
                              Icons.star,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                          onPressed: () {
                            widget.controller.watchListAddProcess(widget.id);
                          },
                        ),
                ),
              ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    WakelockPlus.disable(); // Désactiver le maintien de l'allumage de l'écran
    super.dispose();
  }
}
