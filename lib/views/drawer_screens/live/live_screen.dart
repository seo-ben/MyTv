import '/backend/services/api_endpoint.dart';
import '/backend/utils/custom_loading_api.dart';
import '/views/youtube_video_player_screen.dart';
import '../../../controller/drawer/live_screen/live_screen_controller.dart';
import '../../../utils/basic_screen_imports.dart';
import '../../video_player_screen.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../../../admob/admob_helper.dart';

class LiveScreen extends StatelessWidget {
  LiveScreen({super.key});

  final controller = Get.put(LiveScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TitleHeading2Widget(text: Strings.live),
        backgroundColor: CustomColor.primaryLightScaffoldBackgroundColor,
        automaticallyImplyLeading: true,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back, color: CustomColor.whiteColor),
        ),
      ),
      body: Obx(
        () => controller.isLoading
            ? const CustomLoadingAPI()
            : _bodyWidget(context),
      ),
    );
  }

  _bodyWidget(BuildContext context) {
    var data = controller.liveVideoModel.data.liveData;
    debugPrint("${data.length}");
    var imagePath = controller.liveVideoModel.data.liveImagePath;
    return data.isEmpty
        ? Center(child: TitleHeading2Widget(text: Strings.noDataFound))
        : SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              vertical: Dimensions.heightSize * 0.5,
              horizontal: Dimensions.widthSize,
            ),
            child: Column(
              crossAxisAlignment: crossStart,
              children: [
                GridView.builder(
                  itemCount: data.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.widthSize * 1.5,
                    vertical: Dimensions.heightSize,
                  ),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        if (data[index].link.contains("youtube")) {
                          debugPrint("🔴🟠🟢🔵🟣 ${data[index].link}");
                          Get.to(
                            YoutubeVideoPlayer(
                              url: data[index].link,
                              name: data[index].name,
                              title: data[index].title,
                              description: data[index].description,
                              id: data[index].id.toString(),
                            ),
                          );
                        } else {
                          debugPrint("🔴🟠🟢🔵🟣 ${data[index].link}");
                          Get.to(
                            VideoPlayerScreen(
                              url: data[index].link,
                              name: data[index].name,
                              title: data[index].title,
                              description: data[index].description,
                              id: data[index].id.toString(),
                            ),
                          );
                        }
                      },
                      child: Stack(
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                              right: Dimensions.widthSize * 0.5,
                            ),
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                  "${ApiEndpoint.mainDomain}/$imagePath/${data[index].image}",
                                ),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(
                                Dimensions.radius * 0.75,
                              ),
                            ),
                            child: Align(
                              alignment: Alignment.center,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: Dimensions.widthSize * 0.5,
                                  vertical: Dimensions.heightSize * 0.3,
                                ),
                                decoration: BoxDecoration(
                                  color: CustomColor.primaryLightColor
                                      .withValues(alpha: 0.5),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(Dimensions.radius),
                                  ),
                                ),
                                child: Icon(
                                  Icons.play_circle_outline,
                                  color: CustomColor.whiteColor,
                                  size: Dimensions.buttonHeight * .75,
                                ),
                              ),
                            ),
                          ),
                          Positioned.fill(
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(
                                  Dimensions.radius * 0.75,
                                ),
                                onTap: () {
                                  if (data[index].link.contains("youtube")) {
                                    debugPrint(
                                      "🔴🟠🟢🔵🟣 ${data[index].link}",
                                    );
                                    Get.to(
                                      YoutubeVideoPlayer(
                                        url: data[index].link,
                                        name: data[index].name,
                                        title: data[index].title,
                                        description: data[index].description,
                                        id: data[index].id.toString(),
                                      ),
                                    );
                                  } else {
                                    debugPrint(
                                      "🔴🟠🟢🔵🟣 ${data[index].link}",
                                    );
                                    Get.to(
                                      VideoPlayerScreen(
                                        url: data[index].link,
                                        name: data[index].name,
                                        title: data[index].title,
                                        description: data[index].description,
                                        id: data[index].id.toString(),
                                      ),
                                    );
                                  }
                                },
                                splashColor: CustomColor.primaryLightColor
                                    .withValues(alpha: 0.3),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: .8,
                    crossAxisSpacing: 15.w,
                    mainAxisSpacing: 15.h,
                  ),
                ),
                // showAdd(context),
              ],
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
        height: 50,
        child: AdWidget(
          ad: AdMobHelper.getBannerAd()..load(),
          key: UniqueKey(),
        ),
      ),
    );
  }
}
