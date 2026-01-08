import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/custom_color.dart';
import '../../../utils/dimensions.dart';

class CustomSnackBar {
  static success(String message) {
    return Get.dialog(
      AlertDialog(
        backgroundColor: CustomColor.greenColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: Dimensions.paddingSize,
          vertical: Dimensions.paddingSize * 0.8,
        ),
        content: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: CustomColor.whiteColor.withOpacity(0.12),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.check, color: Colors.white),
            ),
            SizedBox(width: Dimensions.widthSize * 0.7),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Success',
                    style: TextStyle(
                      color: CustomColor.whiteColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: Dimensions.heightSize * 0.3),
                  Text(
                    message,
                    style: TextStyle(color: CustomColor.whiteColor),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('OK', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      barrierDismissible: true,
    );
  }

  static error(String message) {
    return Get.dialog(
      AlertDialog(
        backgroundColor: CustomColor.redColor.withValues(alpha: 0.9),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: Dimensions.paddingSize,
          vertical: Dimensions.paddingSize * 0.8,
        ),
        content: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: CustomColor.whiteColor.withOpacity(0.12),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.error_outline, color: Colors.white),
            ),
            SizedBox(width: Dimensions.widthSize * 0.7),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Error',
                    style: TextStyle(
                      color: CustomColor.whiteColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: Dimensions.heightSize * 0.3),
                  Text(
                    message,
                    style: TextStyle(color: CustomColor.whiteColor),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('OK', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      barrierDismissible: true,
    );
  }
}
