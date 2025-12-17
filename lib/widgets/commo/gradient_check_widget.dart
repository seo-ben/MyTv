import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/custom_color.dart';
import '../../utils/dimensions.dart';

class GradientCheckWidget extends StatelessWidget {
  const GradientCheckWidget({
    super.key,
    required this.isChecked,
  });

  final RxBool isChecked;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(Dimensions.radius * .4),
      onTap: () {
        isChecked.value = !isChecked.value;
        debugPrint(isChecked.value.toString());
      },
      child: Obx(() => Container(
          height: 16,
          width: 16,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: !isChecked.value
                  ? Colors.transparent
                  : CustomColor.primaryLightColor,
              border: Border.all(
                width: 2,
                color: CustomColor.primaryLightColor,
              )),
          child: Icon(
            Icons.check,
            size: 12,
            color: !isChecked.value ? Colors.transparent : Colors.white,
          ))),
    );
  }
}
