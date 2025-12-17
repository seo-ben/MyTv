import '../../backend/model/dashboard/home_info_model.dart';
import '../../utils/basic_screen_imports.dart';
import '/utils/tablet_check.dart';
import '../../views/video_player_screen.dart';
import '../../views/youtube_video_player_screen.dart';

// ignore: must_be_immutable
class LiveFootballListWidget extends StatelessWidget {
  LiveFootballListWidget({
    super.key,
    required this.title,
    required this.sport,
    required this.imagePath,
  });
  final String title, imagePath;
  List<FootballSectionDatum> sport;

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
              return InkWell(
                onTap: () {
                  _navigateToPlayer(sport[index]);
                },
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
          fontSize: Dimensions.headingTextSize3,
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
          fontSize: Dimensions.headingTextSize3,
        ),
        children: [
          TextSpan(
            text: remaining,
            style: CustomStyle.lightHeading4TextStyle.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: Dimensions.headingTextSize3,
              color: CustomColor.primaryLightColor,
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToPlayer(FootballSectionDatum sportItem) {
    if (sportItem.link.contains("youtube")) {
      debugPrint("🔴🟠🟢🔵🟣 ${sportItem.link}");
      Get.to(
        YoutubeVideoPlayer(
          url: sportItem.link,
          name: sportItem.name,
          title: sportItem.title,
          description: sportItem.title,
          id: sportItem.id.toString(),
        ),
      );
    } else {
      debugPrint("🔴🟠🟢🔵🟣 ${sportItem.link}");
      Get.to(
        VideoPlayerScreen(
          url: sportItem.link,
          name: sportItem.name,
          title: sportItem.title,
          description: sportItem.title,
          id: sportItem.id.toString(),
        ),
      );
    }
  }
}
