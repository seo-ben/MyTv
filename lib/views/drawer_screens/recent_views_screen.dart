import 'package:MyTelevision/controller/navbar/dashboard/dashboard_controller.dart';

import '../../controller/drawer/recent_views/recent_views_controller.dart';
import 'package:MyTelevision/helpers/id_utils.dart';
import '/backend/services/api_endpoint.dart';
import '/backend/utils/custom_loading_api.dart';
import '../../utils/basic_screen_imports.dart';

class RecentViewsScreen extends StatelessWidget {
  RecentViewsScreen({super.key});
  final controller = Get.put(RecentViewsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TitleHeading2Widget(text: Strings.recentViews),
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

  Widget _bodyWidget(BuildContext context) {
    var data = controller.recentViewsModel.data.data;
    var imagePath =
        "${ApiEndpoint.mainDomain}/${controller.recentViewsModel.data.categorySection}";
    var adImagePath =
        "${ApiEndpoint.mainDomain}/${Get.find<DashboardController>().homeInfoModel.data.siteSection}";
    return data.isEmpty
        ? Center(child: TitleHeading2Widget(text: Strings.noDataFound))
        : GridView.builder(
            itemCount: data.length,
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(
              horizontal: Dimensions.widthSize * 1.5,
              vertical: Dimensions.heightSize,
            ),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  if (data[index].slug.isNotEmpty) {
                    //
                    controller.getDetailsProcess(data[index].slug);
                  } else {
                    controller.getDetailsProcess(
                      normalizeAndLogId(
                        data[index].id,
                        source: 'recent_views_screen#getDetails',
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
                            "${data[index].slug.isEmpty ? imagePath : adImagePath}/${data[index].image}",
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
                          // .withValues(alpha:
                          decoration: BoxDecoration(
                            color: CustomColor.primaryLightColor.withValues(
                              alpha: 0.5,
                            ),
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
                            if (data[index].slug.isNotEmpty) {
                              //
                              controller.getDetailsProcess2(data[index].slug);
                            } else {
                              controller.getDetailsProcess(
                                normalizeAndLogId(
                                  data[index].id,
                                  source: 'recent_views_screen#onTap',
                                ),
                              );
                            }
                          },
                          splashColor: CustomColor.primaryLightColor.withValues(
                            alpha: 0.3,
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
          );
  }
}
