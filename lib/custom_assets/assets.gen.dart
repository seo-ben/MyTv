/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsAppGen {
  const $AssetsAppGen();

  /// File path: assets/app/app_launcher.png
  AssetGenImage get appLauncher =>
      const AssetGenImage('assets/app/app_launcher.png');

  /// File path: assets/app/basic_logo_for_dark.png
  AssetGenImage get basicLogoForDark =>
      const AssetGenImage('assets/app/basic_logo_for_dark.png');

  /// File path: assets/app/basic_logo_for_light.png
  AssetGenImage get basicLogoForLight =>
      const AssetGenImage('assets/app/basic_logo_for_light.png');

  /// File path: assets/app/ios_launcher.jpg
  AssetGenImage get iosLauncher =>
      const AssetGenImage('assets/app/ios_launcher.jpg');

  /// List of all assets
  List<AssetGenImage> get values =>
      [appLauncher, basicLogoForDark, basicLogoForLight, iosLauncher];
}

class $AssetsBgGen {
  const $AssetsBgGen();

  /// File path: assets/bg/congratulations.svg
  String get congratulations => 'assets/bg/congratulations.svg';

  /// File path: assets/bg/container.png
  AssetGenImage get container => const AssetGenImage('assets/bg/container.png');

  /// File path: assets/bg/dashboard_bg.png
  AssetGenImage get dashboardBgPng =>
      const AssetGenImage('assets/bg/dashboard_bg.png');

  /// File path: assets/bg/dashboard_bg.svg
  String get dashboardBgSvg => 'assets/bg/dashboard_bg.svg';

  /// File path: assets/bg/dashboard_item_bg.png
  AssetGenImage get dashboardItemBg =>
      const AssetGenImage('assets/bg/dashboard_item_bg.png');

  /// List of all assets
  List<dynamic> get values => [
        congratulations,
        container,
        dashboardBgPng,
        dashboardBgSvg,
        dashboardItemBg
      ];
}

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// File path: assets/icons/demography.svg
  String get demography => 'assets/icons/demography.svg';

  /// File path: assets/icons/home.svg
  String get home => 'assets/icons/home.svg';

  /// File path: assets/icons/mystery.svg
  String get mystery => 'assets/icons/mystery.svg';

  /// File path: assets/icons/notifications.svg
  String get notifications => 'assets/icons/notifications.svg';

  /// File path: assets/icons/person.svg
  String get person => 'assets/icons/person.svg';

  /// List of all assets
  List<String> get values => [demography, home, mystery, notifications, person];
}

class $AssetsLogoGen {
  const $AssetsLogoGen();

  /// File path: assets/logo/account_circle.png
  AssetGenImage get accountCirclePng =>
      const AssetGenImage('assets/logo/account_circle.png');

  /// File path: assets/logo/account_circle.svg
  String get accountCircleSvg => 'assets/logo/account_circle.svg';

  /// File path: assets/logo/app_launcher.png
  AssetGenImage get appLauncher =>
      const AssetGenImage('assets/logo/app_launcher.png');

  /// File path: assets/logo/app_logo.png
  AssetGenImage get appLogoPng =>
      const AssetGenImage('assets/logo/app_logo.png');

  /// File path: assets/logo/app_logo.svg
  String get appLogoSvg => 'assets/logo/app_logo.svg';

  /// File path: assets/logo/logo.png
  AssetGenImage get logoPng => const AssetGenImage('assets/logo/logo.png');

  /// File path: assets/logo/logo.svg
  String get logoSvg => 'assets/logo/logo.svg';

  /// List of all assets
  List<dynamic> get values => [
        accountCirclePng,
        accountCircleSvg,
        appLauncher,
        appLogoPng,
        appLogoSvg,
        logoPng,
        logoSvg
      ];
}

class Assets {
  Assets._();

  static const $AssetsAppGen app = $AssetsAppGen();
  static const $AssetsBgGen bg = $AssetsBgGen();
  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const $AssetsLogoGen logo = $AssetsLogoGen();
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
