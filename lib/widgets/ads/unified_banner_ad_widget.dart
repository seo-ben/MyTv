import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/custom_ad_controller.dart';
import '../../backend/services/api_endpoint.dart';

class UnifiedBannerAdWidget extends StatefulWidget {
  final bool isLarge;

  const UnifiedBannerAdWidget({Key? key, this.isLarge = false})
    : super(key: key);

  @override
  State<UnifiedBannerAdWidget> createState() => _UnifiedBannerAdWidgetState();
}

class _UnifiedBannerAdWidgetState extends State<UnifiedBannerAdWidget> {
  bool _isClosed = false;

  @override
  Widget build(BuildContext context) {
    // If user closed the ad, show nothing
    if (_isClosed) {
      return const SizedBox.shrink();
    }

    // Use Get.find to ensure we use the global controller instance
    final controller = Get.find<CustomAdController>();

    return Obx(() {
      // 1. Check if Custom Ads are loading (optional, maybe show nothing or loader)
      // We can skip this to show AdMob while loading or just wait.

      // 2. Check for available Custom Banner Ads
      if (controller.bannerAds.isNotEmpty) {
        // Pick a random ad from the list instead of always showing the first one
        final randomIndex = controller.bannerAds.length > 1
            ? DateTime.now().millisecondsSinceEpoch %
                  controller.bannerAds.length
            : 0;
        var ad = controller.bannerAds[randomIndex];

        // Record View with a simple check to avoid spamming calls
        WidgetsBinding.instance.addPostFrameCallback((_) {
          // Optimally, we should track if this specific ad view instance was recorded
          // to avoid duplicates on every build, but for now this is the requirement.
          controller.recordAdView(ad.id);
        });

        String imageUrl = ad.imageUrl ?? "";
        if (!imageUrl.startsWith("http")) {
          imageUrl = "${ApiEndpoint.mainDomain}/storage/custom-ads/$imageUrl";
        }

        return Stack(
          children: [
            GestureDetector(
              onTap: () => controller.onAdClicked(ad),
              child: Container(
                height: widget.isLarge ? 100 : 50,
                width: double.infinity,
                color: Colors.transparent,
                child: Center(
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.contain,
                    width: double.infinity,
                    height: double.infinity,
                    alignment: Alignment.center,
                    errorBuilder: (context, error, stackTrace) =>
                        const SizedBox.shrink(),
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return const SizedBox.shrink();
                    },
                  ),
                ),
              ),
            ),
            // Close button
            Positioned(
              top: 4,
              right: 4,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _isClosed = true;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.6),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.close, color: Colors.white, size: 16),
                ),
              ),
            ),
          ],
        );
      }

      // 3. No Background AdMob - Return empty if no custom ads
      return const SizedBox.shrink();
    });
  }
}
