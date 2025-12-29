import 'dart:convert';

class CustomAdvertisementModel {
  final List<CustomAd> advertisements;
  final int total;

  CustomAdvertisementModel({required this.advertisements, required this.total});

  factory CustomAdvertisementModel.fromJson(Map<String, dynamic> json) {
    return CustomAdvertisementModel(
      advertisements: List<CustomAd>.from(
        json["advertisements"].map((x) => CustomAd.fromJson(x)),
      ),
      total: json["total"] ?? 0,
    );
  }
}

class CustomAd {
  final int id;
  final String title;
  final String? description;
  final String type; // 'banner', 'interstitial', 'video'
  final String platform; // 'android', 'ios', 'both'
  final String? imageUrl;
  final String? videoUrl;
  final String? clickUrl;
  final int displayDuration;
  final int priority;

  CustomAd({
    required this.id,
    required this.title,
    this.description,
    required this.type,
    required this.platform,
    this.imageUrl,
    this.videoUrl,
    this.clickUrl,
    required this.displayDuration,
    required this.priority,
  });

  factory CustomAd.fromJson(Map<String, dynamic> json) {
    return CustomAd(
      id: json["id"],
      title: json["title"],
      description: json["description"],
      type: json["type"],
      platform: json["platform"],
      imageUrl: json["image_url"],
      videoUrl: json["video_url"],
      clickUrl: json["click_url"],
      displayDuration: json["display_duration"] ?? 10,
      priority: json["priority"] ?? 0,
    );
  }
}
