import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/custom_color.dart';
import '../text_labels/title_heading4_widget.dart';

class GridItemWidget extends StatelessWidget {
  const GridItemWidget({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 16.w, // Using responsive dimensions
        vertical: 8.h,
      ),
      decoration: BoxDecoration(
        color: CustomColor.boxColor.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(12.r), // Simplified radius
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.schedule,
            size: 20.r, // Responsive icon size
            color: CustomColor.primaryLightTextColor,
          ),
          SizedBox(width: 8.w), // Horizontal spacing
          TitleHeading4Widget(
            text: title,
            fontSize: 14.sp, // Responsive text size
          ),
        ],
      ),
    );
  }
}
