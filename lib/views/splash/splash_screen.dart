import '../../controller/basic_settings_controller.dart';
import '../../utils/basic_screen_imports.dart';
import 'package:MyTelevision/backend/local_storage/local_storage.dart';
import 'package:MyTelevision/routes/routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final controller = Get.find<BasicSettingsController>();
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // List of local splash screen images
  final List<String> _splashImages = [
    'assets/splash_screen/Devices-bro.png',
    'assets/splash_screen/Email campaign-bro.png',
    'assets/splash_screen/college admission-bro.png',
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onNext() {
    if (_currentPage < _splashImages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // Last page -> Go to Login
      // Also mark onboarding as done if we want to treat this as onboarding
      LocalStorage.saveOnboardDoneOrNot(isOnBoardDone: true);
      Get.offNamed(Routes.signInScreen);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.primaryLightScaffoldBackgroundColor,
      body: Stack(
        children: [
          // PageView for scrolling images
          PageView.builder(
            controller: _pageController,
            itemCount: _splashImages.length,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              return Center(
                child: Padding(
                  padding: EdgeInsets.all(Dimensions.widthSize * 2),
                  child: Image.asset(
                    _splashImages[index],
                    fit: BoxFit.contain,
                    width: MediaQuery.sizeOf(context).width * 0.9,
                    height: MediaQuery.sizeOf(context).height * 0.6,
                  ),
                ),
              );
            },
          ),

          // Next Button Positioned at Bottom
          Positioned(
            bottom: Dimensions.heightSize * 3,
            left: Dimensions.widthSize * 2,
            right: Dimensions.widthSize * 2,
            child: PrimaryButton(
              title: _currentPage == _splashImages.length - 1
                  ? Strings.loginNow
                  : Strings.next,
              onPressed: _onNext,
            ),
          ),

          // Optional: Page Indicators (Dots)
          Positioned(
            bottom: Dimensions.heightSize * 9,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _splashImages.length,
                (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  height: 10,
                  width: _currentPage == index ? 20 : 10,
                  decoration: BoxDecoration(
                    color: _currentPage == index
                        ? CustomColor.primaryLightColor
                        : Colors.grey.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


  // _bodyWidget(BuildContext context) {
  //   return Column(
  //     mainAxisAlignment: mainSpaceBet,
  //     children: [
  //       SizedBox(
  //         height: Dimensions.heightSize * 3,
  //       ),
  //       Center(
  //         child: Image.asset(
  //           Assets.logo.appLogoPng.path,
  //           height: Dimensions.heightSize * 5.43,
  //           width: MediaQuery.sizeOf(context).width * 0.63,
  //         ),
  //       ),
  //       Column(
  //         mainAxisAlignment: mainEnd,
  //         children: [
  //           TitleHeading2Widget(
  //             text: Strings.liveStream,
  //             color: CustomColor.whiteColor,
  //           ),
  //           TitleHeading4Widget(text: Strings.wePutFun),
  //           verticalSpace(Dimensions.heightSize * 3)
  //         ],
  //       )
  //     ],
  //   );
//}
