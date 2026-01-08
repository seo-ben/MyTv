import '/backend/services/api_endpoint.dart';
import '/backend/utils/custom_loading_api.dart';
import '../../controller/drawer/watch_list/watch_list_screen_controller.dart';
import 'package:MyTelevision/helpers/id_utils.dart';
import '../../utils/basic_screen_imports.dart';
import '../../../widgets/ads/unified_banner_ad_widget.dart';

class WatchListScreen extends StatelessWidget {
  WatchListScreen({super.key});
  final controller = Get.put(WatchListScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TitleHeading2Widget(text: Strings.watchList),
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
    var data = controller.watchListModel.data.data;
    var imagePath =
        "${ApiEndpoint.mainDomain}/${controller.watchListModel.data.categorySection}";
    return Column(
      children: [
        Expanded(
          child: data.isEmpty
              ? Center(child: TitleHeading2Widget(text: Strings.noDataFound))
              : GridView.builder(
                  itemCount: data.length,
                  shrinkWrap: true,
                  // physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.widthSize * 1.5,
                    vertical: Dimensions.heightSize,
                  ),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        controller.getDetailsProcess(
                          normalizeAndLogId(
                            data[index].id,
                            source: 'watch_list_screen',
                          ),
                        );
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
                                  "$imagePath/${data[index].image}",
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
                                  controller.getDetailsProcess(
                                    normalizeAndLogId(
                                      data[index].id,
                                      source: 'watch_list_screen',
                                    ),
                                  );
                                },
                                splashColor: CustomColor.primaryLightColor
                                    .withValues(alpha: 0.3),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 150.h,
                            left: 45.w,
                            child: InkWell(
                              onTap: () {
                                controller.watchListDeleteProcess(
                                  normalizeAndLogId(
                                    data[index].id,
                                    source: 'watch_list_screen',
                                  ),
                                );
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: Dimensions.widthSize,
                                  vertical: Dimensions.heightSize * .5,
                                ),
                                decoration: BoxDecoration(
                                  color: CustomColor.redColor,
                                  borderRadius: BorderRadius.circular(
                                    Dimensions.radius,
                                  ),
                                ),
                                child: TitleHeading4Widget(
                                  text: Strings.delete,
                                  color: CustomColor.whiteColor,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Change crossAxisCount for more space
                    childAspectRatio: .8, // Adjust ratio for a balanced layout
                    crossAxisSpacing: 15.w,
                    mainAxisSpacing: 15.h,
                  ),
                ),
        ),
        showAdd(context),
      ],
    );
  }

  Padding showAdd(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: Dimensions.paddingHorizontalSize * .6,
        right: Dimensions.paddingHorizontalSize * .6,
        top: Dimensions.paddingVerticalSize * .5,
      ),
      child: const UnifiedBannerAdWidget(),
    );
  }
}
