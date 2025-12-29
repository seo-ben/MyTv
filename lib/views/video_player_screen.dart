import 'package:MyTelevision/backend/utils/custom_loading_api.dart';
import 'package:MyTelevision/utils/device_info.dart';
import 'package:video_player/video_player.dart';
import '/utils/basic_screen_imports.dart';
import '/widgets/text_labels/title_heading5_widget.dart';
import '../controller/video/video_player_controller.dart';
import '../widgets/video/video_player_view.dart';
import '../widgets/ads/unified_banner_ad_widget.dart';
import '../widgets/ads/custom_video_ad_player.dart';
import '../controller/custom_ad_controller.dart';
import '../backend/model/authorization/custom_advertisement_model.dart';
import 'package:wakelock_plus/wakelock_plus.dart';
import '../controller/cast_controller.dart';
import '../widgets/tv/focusable_widget.dart';

class VideoPlayerScreen extends StatefulWidget {
  final String url, name, title, description, id;

  const VideoPlayerScreen({
    super.key,
    required this.url,
    required this.name,
    required this.title,
    required this.description,
    required this.id,
  });

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  final controller = Get.put(CustomVideoPlayerController());
  final adController = Get.find<CustomAdController>();
  final castController = Get.put(CastController());

  bool _showAd = false;
  CustomAd? _currentVideoAd;

  @override
  void initState() {
    super.initState();
    _checkForVideoAd();
    WakelockPlus.enable(); // Activer le maintien de l'allumage de l'écran
    debugPrint('▶️ VideoPlayerScreen.initState id=${widget.id}');
    debugPrint(StackTrace.current.toString());
  }

  @override
  void dispose() {
    WakelockPlus.disable(); // Désactiver le maintien de l'allumage de l'écran
    super.dispose();
  }

  void _checkForVideoAd() {
    if (adController.videoAds.isNotEmpty) {
      // Pick a random video ad from the list
      final randomIndex = adController.videoAds.length > 1
          ? DateTime.now().millisecondsSinceEpoch % adController.videoAds.length
          : 0;
      _currentVideoAd = adController.videoAds[randomIndex];
      _showAd = true;
    }
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
        actions: [
          IconButton(
            icon: const Icon(Icons.cast, color: Colors.white),
            onPressed: () => castController.showDeviceSelectionDialog(
              context,
              url: widget.url,
              title: widget.title,
              description: widget.description,
            ),
          ),
          Obx(
            () => castController.isConnected.value
                ? IconButton(
                    icon: const Icon(
                      Icons.cast_connected,
                      color: CustomColor.primaryLightColor,
                    ),
                    onPressed: () {
                      // Initial Cast logic when connected, maybe show disconnect dialog or immediate cast
                      castController.castMedia(
                        widget.url,
                        title: widget.title,
                        description: widget.description,
                      );
                    },
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Dimensions.widthSize),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              verticalSpace(Dimensions.heightSize * 2),

              /// Video Player Section (or Pre-roll Ad)
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: _showAd && _currentVideoAd != null
                    ? AspectRatio(
                        aspectRatio: 16 / 9,
                        child: CustomVideoAdPlayer(
                          ad: _currentVideoAd!,
                          onAdFinished: () {
                            setState(() {
                              _showAd = false;
                            });
                          },
                        ),
                      )
                    : VideoPlayerView(
                        url: widget.url,
                        dataSourceType: DataSourceType.network,
                      ),
              ),
              verticalSpace(Dimensions.heightSize),
              TitleHeading2Widget(
                text: widget.title,
                fontSize: DeviceInfo.isTv ? 30.sp : Dimensions.headingTextSize3,
                color: CustomColor.primaryLightColor,
              ),
              verticalSpace(Dimensions.heightSize),
              TitleHeading5Widget(
                text: widget.description,
                fontSize: DeviceInfo.isTv ? 18.sp : Dimensions.headingTextSize4,
              ),
              verticalSpace(Dimensions.heightSize * 2),
              verticalSpace(Dimensions.heightSize * 2),
              verticalSpace(Dimensions.heightSize * 2),
              _buttonSection(context),
              verticalSpace(Dimensions.heightSize * 2),
              showAdd(context),
            ],
          ),
        ),
      ),
    );
  }

  Padding showAdd(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: Dimensions.paddingHorizontalSize * .6,
        right: Dimensions.paddingHorizontalSize * .6,
        top: Dimensions.paddingVerticalSize * .5,
      ),
      child: const UnifiedBannerAdWidget(isLarge: true),
    );
  }

  /// Modified Button Section with "Add to My List" and "Share Now" Buttons
  Widget _buttonSection(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Obx(
            () => controller.isLoading
                ? const CustomLoadingAPI()
                : FocusableWidget(
                    autofocus: DeviceInfo.isTv,
                    onPressed: () {
                      debugPrint(
                        '📣 UI: watchList button pressed with widget.id=${widget.id}',
                      );
                      controller.watchListAddProcess(widget.id);
                    },
                    focusColor: CustomColor.primaryLightColor,
                    borderRadius: BorderRadius.circular(8),
                    child: PrimaryButton(
                      title: Strings.addToMyList,
                      height: DeviceInfo.isTv ? 60.h : 50.h,
                      icon: Padding(
                        padding: const EdgeInsets.only(right: 5.0),
                        child: Icon(
                          Icons.star,
                          color: Colors.white,
                          size: DeviceInfo.isTv ? 24 : 20,
                        ),
                      ),
                      onPressed: () {
                        debugPrint(
                          '📣 UI: watchList button pressed with widget.id=${widget.id}',
                        );
                        controller.watchListAddProcess(widget.id);
                      },
                    ),
                  ),
          ),
        ),
      ],
    );
  }
}
