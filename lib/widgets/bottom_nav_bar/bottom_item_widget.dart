import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:MyTelevision/language/language_controller.dart';

import '../../controller/navbar/navbar_controller.dart';
import '../../utils/basic_screen_imports.dart';

class BottomItemWidget extends StatelessWidget {
  BottomItemWidget({super.key, this.icon, required this.label, this.index});
  final String? icon;
  final String label;
  final int? index;
  final controller = Get.put(NavbarController());
  @override
  Widget build(BuildContext context) {
    return InkWell(
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () {
        controller.selectedIndex.value = index!;
      },
      child: Obx(
        () => Container(
          padding: EdgeInsets.symmetric(horizontal: Dimensions.widthSize),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Animated Indicator line at the top
              AnimatedPositioned(
                duration: const Duration(milliseconds: 300),
                top: 0,
                child: Container(
                  height: 3.h,
                  width: controller.selectedIndex.value == index ? 20.w : 0,
                  decoration: BoxDecoration(
                    color: CustomColor.primaryLightColor,
                    borderRadius: BorderRadius.circular(Dimensions.radius),
                    boxShadow: [
                      BoxShadow(
                        color: CustomColor.primaryLightColor.withOpacity(0.5),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  verticalSpace(Dimensions.heightSize * 0.2),
                  SvgPicture.asset(
                    icon ?? "",
                    height: 18.h,
                    width: 18.w,
                    // ignore: deprecated_member_use
                    color: controller.selectedIndex.value == index
                        ? CustomColor.primaryLightColor
                        : CustomColor.boxColor.withOpacity(0.7),
                  ),
                  verticalSpace(Dimensions.heightSize * 0.3),
                  Text(
                    Get.find<LanguageController>().getTranslation(label),
                    style: GoogleFonts.montserrat(
                      fontSize: Dimensions.headingTextSize6 * 0.9,
                      fontWeight: controller.selectedIndex.value == index
                          ? FontWeight.w600
                          : FontWeight.w500,
                      color: controller.selectedIndex.value == index
                          ? CustomColor.whiteColor
                          : CustomColor.boxColor.withOpacity(0.7),
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
}
