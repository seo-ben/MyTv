import 'dart:io';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:MyTelevision/backend/services/api_endpoint.dart';
import 'package:MyTelevision/controller/profile/profile_controller.dart';
import 'package:MyTelevision/views/web_payment/web_payment_screen.dart';

import '/backend/utils/custom_loading_api.dart';
import '../../controller/auth/sign_in/sign_in_controller.dart';
import '../../custom_assets/assets.gen.dart';
import '../../language/language_drop_down.dart';
import '../../utils/basic_screen_imports.dart';
import '../../routes/routes.dart';
import '../../utils/drawer_utils.dart';
import '/backend/local_storage/local_storage.dart';

class CustomDrawer extends StatelessWidget {
  CustomDrawer({super.key});

  final controller = Get.put(SignInController());
  final profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        backgroundColor: Get.isDarkMode
            ? CustomColor.primaryBGDarkColor
            : CustomColor.bottomNavBoxColor,
        width: MediaQuery.of(context).size.width / 1.34,
        shape: Platform.isAndroid
            ? RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(Dimensions.radius * 2),
                ),
              )
            : RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(Dimensions.radius * 2),
                  bottomRight: Radius.circular(Dimensions.radius * 2),
                ),
              ),
        child: ListView(
          children: [
            _userImgWidget(context),
            _userTextWidget(context),
            _drawerWidget(context),
          ],
        ),
      ),
    );
  }

  _userImgWidget(BuildContext context) {
    bool isLoggedIn = LocalStorage.isLoggedIn();
    return Center(
      child: Container(
        margin: EdgeInsets.only(
          top: Dimensions.paddingSize,
          bottom: Dimensions.paddingSize,
        ),
        height: Dimensions.heightSize * 8.3,
        width: Dimensions.widthSize * 11.5,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.radius * 1.5),
          color: Colors.transparent,
          border: Border.all(color: CustomColor.primaryLightColor, width: 5),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(Dimensions.radius),
          child: isLoggedIn
              ? FadeInImage(
                  height: double.infinity,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  image: NetworkImage(profileController.userImage.value),
                  placeholder: AssetImage(Assets.bg.dashboardBgPng.path),
                  imageErrorBuilder: (context, error, stackTrace) {
                    return SvgPicture.asset(
                      Assets.icons.person,
                      height: double.infinity,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    );
                  },
                )
              : Container(
                  padding: EdgeInsets.all(Dimensions.paddingSize * 0.5),
                  child: SvgPicture.asset(
                    Assets.icons.person,
                    height: double.infinity,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    color: CustomColor.whiteColor,
                  ),
                ),
        ),
      ),
    );
  }

  _userTextWidget(BuildContext context) {
    bool isLoggedIn = LocalStorage.isLoggedIn();
    return Column(
      children: [
        TitleHeading3Widget(
          text: isLoggedIn
              ? "${profileController.profileInfoModel.data.userInfo.firstname} ${profileController.profileInfoModel.data.userInfo.lastname}"
              : "MyTV",
          fontSize: Dimensions.headingTextSize2,
        ),
        FittedBox(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Dimensions.marginSizeHorizontal * 0.5,
            ),
            child: TitleHeading4Widget(
              text: isLoggedIn
                  ? profileController.profileInfoModel.data.userInfo.email
                  : "Bienvenue sur MyTelevision",
              fontWeight: FontWeight.w700,
              color: CustomColor.primaryLightColor,
              fontSize: Dimensions.headingTextSize3,
            ),
          ),
        ),
        verticalSpace(Dimensions.heightSize * 2),
      ],
    );
  }

  Column _drawerWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: crossStart,
      mainAxisAlignment: mainCenter,
      children: [
        ...DrawerUtils.items
            .where((item) {
              if (LocalStorage.isLoggedIn()) return true;
              // Liste des éléments à masquer pour les invités
              List<String> hiddenForGuests = [
                Strings.myWatchList,
                Strings.recentViews,
                Strings.highlights,
                Strings.changePassword,
              ];
              return !hiddenForGuests.contains(item['title']);
            })
            .map((item) {
              return _drawerTileWidget(
                context,
                item['icon'],
                item['title'],
                onTap: () => Get.toNamed('${item['route']}'),
              );
            }),
        // Language selector commented out as requested
        // _drawerTileLanguageWidget(
        //   context,
        //   Icons.language,
        //   Strings.language,
        //   onTap: () {},
        // ),
        _drawerTileWidget(
          context,
          Icons.shield_outlined,
          "Confidentialité",
          onTap: () {
            Get.to(
              WebPaymentScreen(
                appBarName: "Politique de confidentialité",
                webUri: "${ApiEndpoint.mainDomain}/link/privacy-policy",
                subtitle: "",
              ),
            );
          },
        ),
        _drawerTileWidget(
          context,
          Icons.description_outlined,
          "CGU",
          onTap: () {
            Get.to(
              WebPaymentScreen(
                appBarName: "Conditions Générales d'Utilisation",
                webUri: "${ApiEndpoint.mainDomain}/link/terms-of-service",
                subtitle: "",
              ),
            );
          },
        ),

        _drawerTileWidget(
          context,
          LocalStorage.isLoggedIn() ? Icons.logout : Icons.login,
          LocalStorage.isLoggedIn() ? Strings.logOut : "Connexion",
          onTap: () {
            if (LocalStorage.isLoggedIn()) {
              _logOutDialogueWidget(context);
            } else {
              Get.toNamed(Routes.signInScreen);
            }
          },
        ),

        //todo check and remove
        // InkWell(
        //   onTap: () {
        //
        //   },
        //   child: Padding(
        //     padding: EdgeInsets.symmetric(
        //       horizontal: Dimensions.paddingSize * (!isTablet() ? 1 : 1.05),
        //       vertical: Dimensions.paddingSize * 0.2,
        //     ),
        //     child: Row(
        //       crossAxisAlignment: crossCenter,
        //       mainAxisAlignment: mainStart,
        //       children: [
        //         Icon(
        //           Icons.logout,
        //           size: Dimensions.heightSize * 2,
        //           color: CustomColor.whiteColor,
        //         ),
        //         horizontalSpace(Dimensions.widthSize),
        //         TitleHeading3Widget(
        //           text: Strings.subscriptionLogs,
        //           color: Get.isDarkMode
        //               ? CustomColor.primaryDarkTextColor
        //               : CustomColor.primaryLightTextColor,
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
      ],
    );
  }

  InkWell _drawerTileWidget(
    BuildContext context,
    IconData icon,
    title, {
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Dimensions.paddingSize * 1,
          vertical: Dimensions.paddingSize * 0.2,
        ),
        child: Row(
          crossAxisAlignment: crossCenter,
          mainAxisAlignment: mainStart,
          children: [
            Icon(
              icon,
              size: Dimensions.heightSize * 2,
              color: CustomColor.whiteColor,
            ),
            horizontalSpace(Dimensions.widthSize),
            Expanded(child: TitleHeading3Widget(text: title, maxLines: 2)),
          ],
        ),
      ),
    );
  }

  InkWell _drawerTileLanguageWidget(
    BuildContext context,
    IconData icon,
    title, {
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Dimensions.paddingSize * 1,
          // vertical: Dimensions.paddingSize * 0.1,
        ),
        child: Row(
          crossAxisAlignment: crossCenter,
          mainAxisAlignment: mainStart,
          children: [
            Icon(
              icon,
              size: Dimensions.heightSize * 2,
              color: CustomColor.whiteColor,
            ),
            horizontalSpace(Dimensions.widthSize),
            Expanded(child: TitleHeading3Widget(text: title, maxLines: 2)),
            ChangeLanguageWidget(isHome: true),
          ],
        ),
      ),
    );
  }

  _logOutDialogueWidget(BuildContext context) {
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
                margin: EdgeInsets.all(Dimensions.paddingSize * 0.7),
                padding: EdgeInsets.all(Dimensions.paddingSize * 0.1),
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
                    TitleHeading2Widget(text: Strings.signOut.tr),
                    verticalSpace(Dimensions.heightSize * 1),
                    TitleHeading4Widget(text: Strings.logMessage.tr),
                    verticalSpace(Dimensions.heightSize * 1),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Bouton Annuler (Icone Close)
                        InkWell(
                          onTap: () => Get.back(),
                          child: Container(
                            padding: EdgeInsets.all(
                              Dimensions.paddingSize * 0.4,
                            ),
                            decoration: const BoxDecoration(
                              color: CustomColor.blackColor,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.close,
                              color: CustomColor.whiteColor,
                              size: Dimensions.heightSize * 2.5,
                            ),
                          ),
                        ),
                        horizontalSpace(Dimensions.widthSize * 3),
                        // Bouton Déconnexion (Icone Logout)
                        Obx(
                          () => controller.isSignOutLoading
                              ? const CustomLoadingAPI()
                              : InkWell(
                                  onTap: () {
                                    controller.signOutProcess();
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(
                                      Dimensions.paddingSize * 0.4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: CustomColor.primaryLightColor,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.logout,
                                      color: CustomColor.whiteColor,
                                      size: Dimensions.heightSize * 2.5,
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
