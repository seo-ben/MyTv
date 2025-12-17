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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                icon ?? "",
                height: 18.h,
                width: 18.w,
                // ignore: deprecated_member_use
                color: controller.selectedIndex.value == index
                    ? CustomColor.primaryLightColor
                    : CustomColor.boxColor,
              ),
              verticalSpace(Dimensions.heightSize * 0.5),
              Text(
                Get.find<LanguageController>().getTranslation(label),
                style: GoogleFonts.montserrat(
                  fontSize: Dimensions.headingTextSize6,
                  fontWeight: controller.selectedIndex.value == index
                      ? FontWeight.w600
                      : FontWeight.w500,
                  color: controller.selectedIndex.value == index
                      ? CustomColor.secondaryLightColor
                      : CustomColor.boxColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
