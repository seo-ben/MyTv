import 'package:MyTelevision/backend/local_storage/local_storage.dart'
    show LocalStorage;
import 'package:MyTelevision/widgets/text_labels/title_heading5_widget.dart' show TitleHeading5Widget;
import 'package:flutter/services.dart';

import '/backend/local_storage/local_storage.dart';
import '/backend/utils/custom_loading_api.dart';
import '/controller/profile/profile_controller.dart';
import '/routes/routes.dart';
import '../../../utils/basic_screen_imports.dart';
import '../../../widgets/drop_down/custom_drop_down_widget.dart';
import '../../../widgets/profile_view/profile_view_widget.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    // Vérifier si l'utilisateur est connecté
    bool isLoggedIn = LocalStorage.isLoggedIn();

    if (!isLoggedIn) {
      // Si non connecté, afficher l'écran d'invitation à se connecter
      return _buildAuthPromptScreen(context);
    }

    // Si connecté, afficher le profil normal
    return Scaffold(
      body: Obx(
        () => controller.isLoading
            ? const CustomLoadingAPI()
            : _bodyWidget(context),
      ),
    );
  }

  // Écran d'invitation à se connecter pour les utilisateurs non authentifiés
  Widget _buildAuthPromptScreen(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.primaryLightScaffoldBackgroundColor,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimensions.widthSize * 2.5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Icône de profil améliorée avec cercle de fond
                Container(
                  width: 140.w,
                  height: 140.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        CustomColor.primaryLightColor.withValues(alpha: 0.3),
                        CustomColor.primaryLightColor.withValues(alpha: 0.1),
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: CustomColor.primaryLightColor.withValues(alpha: 0.2),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Icon(
                      Icons.person_outline_rounded,
                      size: 70.sp,
                      color: CustomColor.primaryLightColor,
                    ),
                  ),
                ),
                
                verticalSpace(Dimensions.heightSize * 3),
                
                // Titre principal
                TitleHeading3Widget(
                  text: "Bienvenue !",
                  textAlign: TextAlign.center,
                  color: CustomColor.whiteColor,
                ),
                                
                verticalSpace(Dimensions.heightSize * 4),
                
                // Bouton de connexion principal
                PrimaryButton(
                  title: Strings.loginNow,
                  onPressed: () {
                    Get.toNamed(Routes.signInScreen);
                  },
                ),
                
                verticalSpace(Dimensions.heightSize * 1.5),
                
                // Bouton d'inscription secondaire
                PrimaryButton(
                  title: Strings.registerNow,
                  onPressed: () {
                    Get.toNamed(Routes.signUpScreen);
                  },
                  buttonColor: CustomColor.whiteColor.withValues(alpha: 0.15),
                ),
                
                verticalSpace(Dimensions.heightSize * 2),
                
                // Texte d'information supplémentaire
                TitleHeading5Widget(
                  text: "Créez un compte pour sauvegarder vos préférences",
                  textAlign: TextAlign.center,
                  color: CustomColor.whiteColor.withValues(alpha: 0.5),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _bodyWidget(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: Dimensions.widthSize * 1.5),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: crossCenter,
            children: [
              verticalSpace(Dimensions.heightSize * 2),
              ProfileViewWidget(withButton: true),
              verticalSpace(Dimensions.heightSize * 2),
              _inputFormWidget(context),
              verticalSpace(Dimensions.heightSize * 3),
              _buttonWidget(context),
              verticalSpace(Dimensions.heightSize * 2),
            ],
          ),
        ),
      ),
    );
  }

  _inputFormWidget(BuildContext context) {
    return Shortcuts(
      shortcuts: const <ShortcutActivator, Intent>{
        SingleActivator(LogicalKeyboardKey.space): NextFocusIntent(),
      },
      child: FocusTraversalGroup(
        child: Form(
          onChanged: () {
            Form.of(primaryFocus!.context!).save();
          },
          child: Column(
            crossAxisAlignment: crossStart,
            children: [
              // Nom et prénom
              Row(
                children: [
                  Expanded(
                    child: PrimaryInputWidget(
                      controller: controller.firstNameController,
                      hint: Strings.enterName,
                      label: Strings.firstName,
                    ),
                  ),
                  horizontalSpace(Dimensions.widthSize * 1.5),
                  Expanded(
                    child: PrimaryInputWidget(
                      controller: controller.lastNameController,
                      hint: Strings.enterName,
                      label: Strings.lastName,
                    ),
                  ),
                ],
              ),
              
              verticalSpace(Dimensions.heightSize * 1.5),
              
              // Pays
              CustomDropDown(
                itemsList: controller.countryList,
                onChanged: (v) {
                  for (int i = 0; i < controller.countryList.length; i++) {
                    if (controller.selectCountry.value ==
                        controller.countryList[i]) {
                      controller.selectMobileCodeIndex.value = i;
                    }
                  }
                },
                selectMethod: controller.selectCountry,
                labelColor: CustomColor.whiteColor,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: CustomColor.whiteColor.withValues(alpha: .20),
                      width: 1.5,
                    ),
                  ),
                ),
              ),
              
              verticalSpace(Dimensions.heightSize * 1.5),
              
              // Téléphone
              PrimaryInputWidget(
                controller: controller.phoneController,
                hint: Strings.enterPhoneNumber,
                label: Strings.phone,
              ),
              
              verticalSpace(Dimensions.heightSize * 1.5),
              
              // Adresse et ville
              Row(
                children: [
                  Expanded(
                    child: PrimaryInputWidget(
                      controller: controller.addressController,
                      hint: Strings.writeHere,
                      label: Strings.address,
                    ),
                  ),
                  horizontalSpace(Dimensions.widthSize * 1.5),
                  Expanded(
                    child: PrimaryInputWidget(
                      controller: controller.cityController,
                      hint: Strings.writeHere,
                      label: Strings.city,
                    ),
                  ),
                ],
              ),
              
              verticalSpace(Dimensions.heightSize * 1.5),
              
              // État et code postal
              Row(
                children: [
                  Expanded(
                    child: PrimaryInputWidget(
                      controller: controller.stateController,
                      hint: Strings.writeHere,
                      label: Strings.state,
                    ),
                  ),
                  horizontalSpace(Dimensions.widthSize * 1.5),
                  Expanded(
                    child: PrimaryInputWidget(
                      controller: controller.zipCodeController,
                      hint: Strings.writeHere,
                      label: Strings.zipCode,
                      textInputAction: TextInputAction.done,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buttonWidget(BuildContext context) {
    return Obx(
      () => controller.isUpdateLoading
          ? const CustomLoadingAPI()
          : PrimaryButton(
              title: Strings.update,
              onPressed: () {
                controller.isImagePathSet.value
                    ? controller.profileUpdateWithImageProcess()
                    : controller.profileUpdateWithOutImageProcess();
              },
            ),
    );
  }
}