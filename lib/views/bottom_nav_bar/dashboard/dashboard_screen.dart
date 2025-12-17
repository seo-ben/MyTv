import '../../../utils/basic_screen_imports.dart';
import '../../../utils/responsive_layout.dart';
import 'dashboard_screen_mobile.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(mobileScaffold: DashboardScreenMobile());
  }
}
