import 'package:get/get.dart';
import 'package:MyTelevision/views/auth/two_fa_verification_screen.dart';
import 'package:MyTelevision/views/drawer_screens/change_password/change_password_screen.dart';
import 'package:MyTelevision/views/drawer_screens/highlights/highlights_screen.dart';
import 'package:MyTelevision/views/drawer_screens/live/live_screen.dart';
import 'package:MyTelevision/views/drawer_screens/my_subscription/my_subscription_screen.dart';
import 'package:MyTelevision/views/drawer_screens/two_fa_status_show.dart';
import 'package:MyTelevision/views/drawer_screens/watch_list_screen.dart';
import 'package:MyTelevision/views/subscription/subscription_page.dart';

import '../views/drawer_screens/recent_views_screen.dart';
import '/routes/routes.dart';
import '/views/auth/sign_in/sign_in_screen.dart';
import '/views/onboard/onboard_screen.dart';
import '../bindings/splash_binding.dart';
import '../views/auth/sign_in/forget_password_otp_screen.dart';
import '../views/auth/sign_in/forgot_password/forgot_password_screen.dart';
import '../views/auth/sign_in/reset_password/reset_password_screen.dart';
import '../views/auth/sign_up/sign_up_otp_screen.dart';
import '../views/auth/sign_up/sign_up_screen.dart';
import '../views/bottom_nav_bar/bottom_nav_bar.dart';
import '../views/bottom_nav_bar/dashboard/dashboard_screen_mobile.dart';
import '../views/drawer_screens/subscription_log/subscription_log_screen.dart';
import '../views/payment/payment_screen.dart';
import '../views/splash/splash_screen.dart';

class RoutePageList {
  static var list = [
    GetPage(
      name: Routes.splashScreen,
      page: () => SplashScreen(),
      binding: SplashBinding(),
    ),
    GetPage(name: Routes.dashboard, page: () => DashboardScreenMobile()),
    GetPage(name: Routes.bottomNavBar, page: () => BottomNavBarScreen()),
    GetPage(name: Routes.signInScreen, page: () => SignInScreen()),
    GetPage(
      name: Routes.forgotPasswordScreen,
      page: () => ForgotPasswordScreen(),
    ),
    GetPage(
      name: Routes.forgetPasswordOtpScreen,
      page: () => ForgetPasswordOtpScreen(),
    ),
    GetPage(
      name: Routes.resetPasswordScreen,
      page: () => ResetPasswordScreen(),
    ),
    GetPage(name: Routes.signUpScreen, page: () => SignUpScreen()),
    GetPage(name: Routes.onboardScreen, page: () => OnboardScreen()),
    GetPage(name: Routes.signUpOtpScreen, page: () => SignUpOtpScreen()),
    // GetPage(
    //   name: Routes.kycInformation,
    //   page: () => KycInformationScreen(),
    // ),
    GetPage(name: Routes.subscriptionScreen, page: () => SubscriptionPage()),
    // GetPage(
    //   name: Routes.videoPlayerScreen,
    //   page: () => const VideoPlayerScreen(),
    // ),
    GetPage(name: Routes.watchListScreen, page: () => WatchListScreen()),
    GetPage(name: Routes.recentViewsScreen, page: () => RecentViewsScreen()),
    // GetPage(
    //   name: Routes.transactionHistoryScreen,
    //   page: () => const TransactionHistoryScreen(),
    // ),
    GetPage(
      name: Routes.mySubscriptionScreen,
      page: () => MySubscriptionScreen(),
    ),
    GetPage(name: Routes.liveScreen, page: () => LiveScreen()),
    GetPage(name: Routes.highlightScreen, page: () => HighlightsScreen()),
    GetPage(name: Routes.subscriptionLogs, page: () => SubscriptionLogScreen()),
    GetPage(
      name: Routes.changePasswordScreen,
      page: () => ChangePasswordScreen(),
    ),
    GetPage(
      name: Routes.twoFaVerificationScreen,
      page: () => TwoFaOtpVerificationScreenMobile(),
    ),
    GetPage(name: Routes.twoFaScreen, page: () => TwoFAScreen()),
    GetPage(name: Routes.paymentScreen, page: () => PaymentScreen()),
  ];
}
