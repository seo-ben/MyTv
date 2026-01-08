import '/backend/local_storage/local_storage.dart';
import '/backend/utils/custom_loading_api.dart';
import '/controller/navbar/dashboard/dashboard_controller.dart';
import '/controller/profile/profile_controller.dart';
import '../../controller/navbar/navbar_controller.dart';
import '../../controller/subscirption/subscription_controller.dart';
import '../../custom_assets/assets.gen.dart';
import '../../routes/routes.dart';
import '../../utils/basic_screen_imports.dart';
import '../../widgets/bottom_nav_bar/bottom_item_widget.dart';
import '../../widgets/drawer/custom_drawer.dart';
import '../../widgets/others/custom_image_widget.dart';

class BottomNavBarScreen extends StatelessWidget {
  BottomNavBarScreen({super.key});
  final controller = Get.put(NavbarController());
  final profileController = Get.put(ProfileController());
  final subscriptionController = Get.put(SubscriptionController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => subscriptionController.isLoading
          ? const CustomLoadingAPI()
          : Scaffold(
              body: Obx(() => controller.body[controller.selectedIndex.value]),
              bottomNavigationBar: _bottomNavBarWidget(context),
              drawer: CustomDrawer(),
              extendBodyBehindAppBar: controller.selectedIndex.value == 0,
              extendBody: controller.selectedIndex.value == 0,
              appBar: controller.selectedIndex.value == 0
                  ? AppBar(
                      backgroundColor: CustomColor
                          .primaryLightScaffoldBackgroundColor
                          .withValues(
                            alpha: Get.find<DashboardController>()
                                .appBarOpacity
                                .value,
                          ),
                      iconTheme: const IconThemeData(
                        color: CustomColor.whiteColor,
                      ),
                      centerTitle: true,
                      title: CustomImageWidget(
                        path: Assets.logo.logoPng.path,
                        width: MediaQuery.sizeOf(context).width * 0.26,
                        height: 29.h,
                      ),
                      actions: [
                        (subscriptionController
                                        .dashboardInfoModel
                                        .data
                                        ?.subscriptionLog
                                        ?.status ??
                                    false) ==
                                true
                            ? Container()
                            : InkWell(
                                onTap: () {
                                  Get.toNamed(Routes.subscriptionScreen);
                                },
                                child:
                                    Icon(
                                      Icons.volunteer_activism,
                                      color: CustomColor.whiteColor,
                                      size: 28.h,
                                    ).paddingSymmetric(
                                      horizontal: Dimensions.widthSize,
                                    ),
                              ),
                      ],
                    )
                  : AppBar(
                      backgroundColor:
                          CustomColor.primaryLightScaffoldBackgroundColor,
                      automaticallyImplyLeading: true,
                      title: TitleHeading2Widget(
                        text:
                            controller.appTitle[controller.selectedIndex.value],
                      ),
                      leading: IconButton(
                        onPressed: () {
                          controller.selectedIndex.value = 0;
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                          color: CustomColor.whiteColor,
                        ),
                      ),
                      actions: [
                        if (controller.selectedIndex.value == 2 &&
                            LocalStorage.isLoggedIn())
                          Padding(
                            padding: const EdgeInsets.only(right: 5.0),
                            child: SizedBox(
                              width: MediaQuery.sizeOf(context).width * .40,
                              height: Dimensions.buttonHeight * .65,
                              child: PrimaryButton(
                                title: Strings.delete,
                                buttonColor: CustomColor.redColor,
                                onPressed: () {
                                  _deleteDialogWidget(context);
                                },
                              ),
                            ),
                          )
                        else
                          Container(),
                      ],
                    ),
            ),
    );
  }

  BottomAppBar _bottomNavBarWidget(BuildContext context) {
    return BottomAppBar(
      color: CustomColor.bottomNavBoxColor,
      height: 60.h,
      padding: EdgeInsets.zero,
      elevation: 10,
      notchMargin: 0,
      clipBehavior: Clip.antiAlias,
      shape: const AutomaticNotchedShape(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: CustomColor.bottomNavBoxColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          border: Border(
            top: BorderSide(
              color: CustomColor.whiteColor.withOpacity(0.05),
              width: 1,
            ),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            BottomItemWidget(
              icon: Assets.icons.home,
              label: Strings.home,
              index: 0,
            ),
            BottomItemWidget(
              icon: Assets.icons.notifications,
              label: Strings.notification,
              index: 1,
            ),
            BottomItemWidget(
              icon: Assets.icons.person,
              label: Strings.profile,
              index: 2,
            ),
          ],
        ),
      ),
    );
  }

  _deleteDialogWidget(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
          alignment: Alignment.center,
          insetPadding: EdgeInsets.all(Dimensions.paddingSize * 0.3),
          contentPadding: EdgeInsets.zero,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          content: Builder(
            builder: (context) {
              var width = MediaQuery.of(context).size.width;
              return Container(
                width: width * 0.84,
                margin: EdgeInsets.all(Dimensions.paddingSize * 0.5),
                padding: EdgeInsets.all(Dimensions.paddingSize * 0.9),
                decoration: BoxDecoration(
                  color: Get.isDarkMode
                      ? CustomColor.primaryBGDarkColor
                      : CustomColor.primaryLightScaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(Dimensions.radius * 1.4),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: crossCenter,
                  children: [
                    SizedBox(height: Dimensions.heightSize * 2),
                    TitleHeading2Widget(text: Strings.delete.tr),
                    verticalSpace(Dimensions.heightSize * 1),
                    TitleHeading4Widget(text: Strings.deleteLogMessage.tr),
                    verticalSpace(Dimensions.heightSize * 1),
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * .25,
                            child: PrimaryButton(
                              title: Strings.cancel.tr,
                              onPressed: () {
                                Get.back();
                              },
                              borderColor: CustomColor.blackColor,
                              buttonColor: CustomColor.blackColor,
                            ),
                          ),
                        ),
                        horizontalSpace(Dimensions.widthSize),
                        Expanded(
                          child: Obx(
                            () => profileController.isLoading
                                ? const CustomLoadingAPI()
                                : SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * .25,
                                    child: PrimaryButton(
                                      title: Strings.delete.tr,
                                      onPressed: () {
                                        profileController
                                            .profileDeleteProcess();
                                      },
                                      borderColor:
                                          CustomColor.primaryLightColor,
                                    ),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
