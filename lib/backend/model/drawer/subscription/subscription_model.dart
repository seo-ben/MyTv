import 'dart:convert';

SubscriptionModel subscriptionModelFromJson(String str) =>
    SubscriptionModel.fromJson(json.decode(str));

class SubscriptionModel {
  final Message message;
  final Data data;

  SubscriptionModel({
    required this.message,
    required this.data,
  });

  factory SubscriptionModel.fromJson(Map<String, dynamic> json) =>
      SubscriptionModel(
        message: Message.fromJson(json["message"]),
        data: Data.fromJson(json["data"]),
      );
}

class Data {
  final List<SubscribePageDatum> subscribePageData;

  Data({
    required this.subscribePageData,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        subscribePageData: List<SubscribePageDatum>.from(
            json["subscribePageData"]
                .map((x) => SubscribePageDatum.fromJson(x))),
      );
}

class SubscribePageDatum {
  final dynamic id;
  final String name;
  final String duration;
  final dynamic price;
  final String defaultFeature;
  final String baseCurrency;
  final List<Feature> feature;

  SubscribePageDatum({
    required this.id,
    required this.name,
    required this.duration,
    required this.price,
    required this.defaultFeature,
    required this.feature,
    required this.baseCurrency,
  });

  factory SubscribePageDatum.fromJson(Map<String, dynamic> json) =>
      SubscribePageDatum(
        id: json["id"],
        name: json["name"],
        duration: json["duration"],
        price: json["price"],
        defaultFeature: json["defaultFeature"],
        baseCurrency: json["base_currency"],
        feature:
            List<Feature>.from(json["feature"].map((x) => Feature.fromJson(x))),
      );
}

class Feature {
  final dynamic id;
  final String details;

  Feature({
    required this.id,
    required this.details,
  });

  factory Feature.fromJson(Map<String, dynamic> json) => Feature(
        id: json["id"],
        details: json["details"],
      );
}

class Message {
  final List<String> success;

  Message({
    required this.success,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        success: List<String>.from(json["success"].map((x) => x)),
      );
}
