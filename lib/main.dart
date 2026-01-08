// ignore_for_file: deprecated_member_use
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '/controller/basic_settings_controller.dart';
import '/routes/routes.dart';
import '/utils/system_maintenance_controller.dart';
import 'admob/admob_helper.dart';
import 'language/language_controller.dart';
import 'utils/theme.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'package:MyTelevision/utils/device_info.dart';
import '/controller/custom_ad_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();

  await checkAndSetDeviceType();

  if (DeviceInfo.isTv) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  } else {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }
  AdMobHelper.initialization();

  // CRITIQUE: Initialiser GetStorage AVANT tout
  await GetStorage.init();

  runApp(const MyApp());
}

// Widget de splash screen avec logo pendant 5 secondes
class AppSplashScreen extends StatefulWidget {
  const AppSplashScreen({super.key});

  @override
  State<AppSplashScreen> createState() => _AppSplashScreenState();
}

class _AppSplashScreenState extends State<AppSplashScreen> {
  @override
  void initState() {
    super.initState();
    _initializeAndNavigate();
  }

  Future<void> _initializeAndNavigate() async {
    // Attendre 5 secondes pour afficher le logo
    await Future.delayed(const Duration(seconds: 5));

    try {
      // Redirection directe vers le dashboard pour tous les utilisateurs
      // L'authentification sera vérifiée au niveau de chaque fonctionnalité
      debugPrint('🚀 Redirection vers dashboard (accès invité autorisé)');
      Get.offAllNamed(Routes.bottomNavBar);
    } catch (e) {
      debugPrint('❌ Erreur lors de la navigation: $e');
      // En cas d'erreur, aller quand même au dashboard
      Get.offAllNamed(Routes.bottomNavBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: Image.asset(
          'assets/logo/app_logo.png',
          fit: BoxFit.contain,
          width: double.infinity,
          height: double.infinity,
        ),
      ),
    );
  }
}

// This widget is the root of your application.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // 📺 TV Design Size: 960x540 (Standard 1080p scaled down or 1920x1080)
    // vs 📱 Mobile Design Size: 414x896
    Size designSize = DeviceInfo.isTv
        ? const Size(960, 540)
        : const Size(414, 896);

    return ScreenUtilInit(
      designSize: designSize,
      builder: (_, child) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: Themes.light,
        darkTheme: Themes.dark,
        themeMode: Themes().theme,
        initialBinding: BindingsBuilder(() {
          Get.put(BasicSettingsController(), permanent: true);
          Get.put(SystemMaintenanceController());
          Get.put(LanguageController(), permanent: true);
          Get.put(CustomAdController(), permanent: true);
        }),
        navigatorKey: Get.key,
        // Utiliser AppSplashScreen comme écran initial
        home: const AppSplashScreen(),
        getPages: Routes.list,
        builder: (context, widget) {
          ScreenUtil.init(context);
          return Obx(
            () => MediaQuery(
              data: MediaQuery.of(
                context,
              ).copyWith(textScaler: const TextScaler.linear(1.0)),
              child: Directionality(
                textDirection: Get.find<LanguageController>().isLoading
                    ? TextDirection.ltr
                    : Get.find<LanguageController>().languageDirection,
                child: widget!,
              ),
            ),
          );
        },
      ),
    );
  }
}
