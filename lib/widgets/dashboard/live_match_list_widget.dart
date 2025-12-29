import '/utils/tablet_check.dart';
import '/utils/device_info.dart';
import '../../backend/model/dashboard/home_info_model.dart';
import '../../utils/basic_screen_imports.dart';
import '../../views/video_player_screen.dart';
import '../../views/youtube_video_player_screen.dart';
import 'package:MyTelevision/helpers/id_utils.dart';
import '../tv/focusable_widget.dart';

// ignore: must_be_immutable
class LiveMatchListWidget extends StatelessWidget {
  LiveMatchListWidget({
    super.key,
    required this.title,
    required this.sport,
    required this.imagePath,
  });
  final String title, imagePath;
  List<Sport> sport;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: crossStart,
      children: [
        _textWidget(context, title),
        verticalSpace(Dimensions.heightSize),
        SizedBox(
          height: isTablet(context)
              ? MediaQuery.sizeOf(context).height * 0.25
              : MediaQuery.sizeOf(context).height * 0.187,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: sport.length,
            itemBuilder: (context, index) {
              return FocusableWidget(
                autofocus: index == 0 && DeviceInfo.isTv,
                onPressed: () {
                  // Logic for all users (guests included)
                  // final controller = Get.find<DashboardController>();
                  // Note: Removed premium check logic for now as requested for guest access,
                  // or re-enable if premium content should still remain locked but visible.
                  // For now, allowing direct access as requested.

                  if (sport[index].status == true) {
                    // If status is true (e.g. premium), check if user is premium?
                    // User asked for "guest access", assuming public content.
                    // If mixed content, we might need isPremium check again.
                    // But for now, direct access:
                    _navigateToPlayer(sport[index]);
                  } else {
                    _navigateToPlayer(sport[index]);
                  }
                },
                focusColor: CustomColor.primaryLightColor,
                borderRadius: BorderRadius.circular(Dimensions.radius * 0.75),
                child: Container(
                  margin: EdgeInsets.only(right: Dimensions.widthSize * 0.5),
                  width: MediaQuery.sizeOf(context).width * 0.32,
                  // height: MediaQuery.sizeOf(context).height * 0.187,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("$imagePath/${sport[index].image}"),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(
                      Dimensions.radius * 0.75,
                    ),
                  ),
                  child: sport[index].status == true
                      ? Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            margin: EdgeInsets.all(Dimensions.paddingSize * .1),
                            padding: EdgeInsets.all(
                              Dimensions.paddingSize * .1,
                            ),
                            decoration: const BoxDecoration(
                              color: CustomColor.yellowColor,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.star,
                              size: DeviceInfo.isTv
                                  ? Dimensions.iconSizeSmall * 0.9
                                  : Dimensions.iconSizeSmall * 1.25,
                              color: CustomColor.whiteColor,
                            ),
                          ),
                        )
                      : Container(),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _textWidget(BuildContext context, String title) {
    debugPrint("🔍 title passed: '$title'");

    final words = title.trim().split(' ');

    if (words.length == 1) {
      return Text(
        words.first,
        style: CustomStyle.lightHeading4TextStyle.copyWith(
          fontWeight: FontWeight.w500,
          fontSize: DeviceInfo.isTv
              ? Dimensions.headingTextSize3 * 0.7
              : Dimensions.headingTextSize3,
        ),
      );
    }

    final firstWord = words.first;
    final remaining = words.sublist(1).join(' ');

    return Text.rich(
      TextSpan(
        text: "$firstWord ",
        style: CustomStyle.lightHeading4TextStyle.copyWith(
          fontWeight: FontWeight.w500,
          fontSize: DeviceInfo.isTv
              ? Dimensions.headingTextSize3 * 0.7
              : Dimensions.headingTextSize3,
        ),
        children: [
          TextSpan(
            text: remaining,
            style: CustomStyle.lightHeading4TextStyle.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: DeviceInfo.isTv
                  ? Dimensions.headingTextSize3 * 0.7
                  : Dimensions.headingTextSize3,
              color: CustomColor.primaryLightColor,
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToPlayer(Sport sportItem) {
    if (sportItem.link.contains("youtube")) {
      debugPrint("🔴🟠🟢🔵🟣 ${sportItem.link}");
      Get.to(
        YoutubeVideoPlayer(
          url: sportItem.link,
          name: sportItem.name,
          title: sportItem.title,
          description: sportItem.description,
          id: normalizeAndLogId(sportItem.id, source: 'live_match_list_widget'),
        ),
      );
    } else {
      debugPrint("🔴🟠🟢🔵🟣 ${sportItem.link}");
      Get.to(
        VideoPlayerScreen(
          url: sportItem.link,
          name: sportItem.name,
          title: sportItem.title,
          description: sportItem.description,
          id: normalizeAndLogId(sportItem.id, source: 'live_match_list_widget'),
        ),
      );
    }
  }
}
