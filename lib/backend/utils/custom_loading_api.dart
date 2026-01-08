import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../utils/custom_color.dart';

class CustomLoadingAPI extends StatelessWidget {
  const CustomLoadingAPI({
    super.key,
    this.color,
  });
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SpinKitFadingCircle(
        color: color ?? CustomColor.primaryLightColor,
      ),
    );
  }
}
