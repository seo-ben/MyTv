import 'package:MyTelevision/backend/local_storage/local_storage.dart';
import 'package:MyTelevision/routes/routes.dart' show Routes;
import 'package:carousel_slider/carousel_slider.dart';
import '/data/onboard_data_model.dart';
import '../../utils/basic_screen_imports.dart';
import '../basic_settings_controller.dart';

class OnboardController extends GetxController {
  RxInt currentIndex = 0.obs;
  final basicSettingsController = Get.find<BasicSettingsController>();

  @override
  void onInit() {
    super.onInit();
    onboardData();
  }

  List<Widget> itemList = [];

  final CarouselSliderController carouselController =
      CarouselSliderController(); // Added controller
  List<OnboardModel> onboardList = [];

  void next(BuildContext context) {
    if (currentIndex.value < itemList.length - 1) {
      carouselController.nextPage();
    } else {
      // Last slide, so go to Login
      LocalStorage.saveOnboardDoneOrNot(isOnBoardDone: true);
      Get.toNamed(Routes.signInScreen);
    }
  }

  void onboardData() {
    itemList.clear();
    onboardList.clear();

    // Safety check with Fallback: if settings not loaded, use defaults
    List<dynamic> data = [];
    if (basicSettingsController.isSettingsLoaded) {
      data = basicSettingsController.appSettingsModel.data.onboardScreens;
    }

    // Use default data if empty to ensure UI always works
    if (data.isEmpty) {
      // Fallback default item so loop runs at least once
      itemList.add(
        Container(
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(24.r),
          ),
        ),
      );
      onboardList.add(
        OnboardModel("Welcome", "Experience the best streaming service."),
      );
      return;
    }

    for (int i = 0; i < data.length; i++) {
      final imagePath = "${basicSettingsController.path.value}${data[i].image}";
      // Ensure image path is valid
      final ImageProvider imageProvider;
      final bool isUrlValid =
          (basicSettingsController.path.value.isNotEmpty &&
          data[i].image.isNotEmpty &&
          (imagePath.startsWith('http://') ||
              imagePath.startsWith('https://')));

      if (!isUrlValid) {
        // Fallback placeholder or asset
        imageProvider = const AssetImage('assets/logo/app_logo.png');
      } else {
        imageProvider = NetworkImage(imagePath);
      }

      itemList.add(
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24.r),
            image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
          ),
        ),
      );
      onboardList.add(OnboardModel(data[i].title, data[i].subTitle));
    }
  }
}
