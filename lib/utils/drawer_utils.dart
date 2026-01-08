import '../routes/routes.dart';
import 'basic_screen_imports.dart';

class DrawerUtils {
  static List items = [
    {
      'title': Strings.myWatchList,
      'icon': Icons.playlist_add_check_sharp,
      'route': Routes.watchListScreen,
    },
    {
      'title': Strings.recentViews,
      'icon': Icons.watch_later_outlined,
      'route': Routes.recentViewsScreen,
    },
    {
      'title': Strings.live,
      'icon': Icons.live_tv_outlined,
      'route': Routes.liveScreen,
    },
    {
      'title': Strings.highlights,
      'icon': Icons.highlight_alt_outlined,
      'route': Routes.highlightScreen,
    },
    // {
    //   'title': Strings.mySubscription,
    //   'icon': Icons.subscriptions_outlined,
    //   'route': Routes.mySubscriptionScreen,
    // },
    // {
    //   'title': Strings.subscriptionLogs,
    //   'icon': Icons.history_outlined,
    //   'route': Routes.subscriptionLogs,
    // },

    // {
    //   'title': Strings.twoFaVerification,
    //   'icon': Icons.verified_user_outlined,
    //   'route': Routes.twoFaScreen,
    // },
    {
      'title': Strings.changePassword,
      'icon': Icons.lock_reset_outlined,
      'route': Routes.changePasswordScreen,
    },
  ];
}
