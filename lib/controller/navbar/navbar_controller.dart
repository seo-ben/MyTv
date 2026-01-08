import 'package:get/get.dart';

import '../../language/strings.dart';
import '../../views/bottom_nav_bar/dashboard/dashboard_screen_mobile.dart';
import '../../views/bottom_nav_bar/notification/notification_screen.dart';
import '../../views/bottom_nav_bar/profile/profile_screen.dart';

class NavbarController extends GetxController {
  final RxInt selectedIndex = 0.obs;
  final RxBool isRoutesIndex = false.obs;

  RxList<String> appTitle = [
    Strings.search,
    // Strings.search,
    Strings.notification,
    Strings.profile,
  ].obs;

  final List body = [
    DashboardScreenMobile(),
    // SearchScreen(),
    NotificationScreen(),
    ProfileScreen(),
  ];
}
