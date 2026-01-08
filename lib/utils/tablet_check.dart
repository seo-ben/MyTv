import 'basic_screen_imports.dart';

bool isTablet(BuildContext context) {
  final double shortestSide = MediaQuery.of(context).size.shortestSide;
  return shortestSide > 500; // Tablets typically have a minimum width of 600 dp
}
