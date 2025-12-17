import 'package:MyTelevision/backend/utils/custom_loading_api.dart';

import 'package:video_player/video_player.dart';
// import 'package:MyTelevision/backend/utils/custom_loading_api.dart';

import '/utils/basic_screen_imports.dart';
import '/widgets/text_labels/title_heading5_widget.dart';
import '../controller/video/video_player_controller.dart';
import '../widgets/video/video_player_view.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../admob/admob_helper.dart';

class VideoPlayerScreen extends StatelessWidget {
  VideoPlayerScreen({
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TitleHeading2Widget(text: title),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: CustomColor.whiteColor),
          onPressed: () => Navigator.pop(context),
        ),
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
                child: VideoPlayerView(
                  url: url,
                  dataSourceType: DataSourceType.network,
                ),
              ),
              verticalSpace(Dimensions.heightSize),
              TitleHeading2Widget(
                text: title,
                fontSize: Dimensions.headingTextSize3,
                color: CustomColor.primaryLightColor,
              ),
              verticalSpace(Dimensions.heightSize),
              TitleHeading5Widget(
                text: description,
                fontSize: Dimensions.headingTextSize4,
              ),
              verticalSpace(Dimensions.heightSize * 2),
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
    return Padding(
      padding: EdgeInsets.only(
        left: Dimensions.paddingHorizontalSize * .6,
        right: Dimensions.paddingHorizontalSize * .6,
        top: Dimensions.paddingVerticalSize * .5,
      ),
      child: SizedBox(
        height: 250,
        child: AdWidget(
          ad: AdMobHelper.getLargeBannerAd()..load(),
          key: UniqueKey(),
        ),
      ),
    );
  }

  /// Modified Button Section with "Add to My List" and "Share Now" Buttons
  Widget _buttonSection(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        id == ""
            ? Container()
            : Expanded(
                child: Obx(
                  () => controller.isLoading
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
                            controller.watchListAddProcess(id);
                          },
                        ),
                ),
              ),
      ],
    );
  }
}
