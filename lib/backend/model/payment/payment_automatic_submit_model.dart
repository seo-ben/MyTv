import 'dart:convert';

PaymentSubmitAutomaticModel paymentSubmitAutomaticModelFromJson(String str) =>
    PaymentSubmitAutomaticModel.fromJson(json.decode(str));

String paymentSubmitAutomaticModelToJson(PaymentSubmitAutomaticModel data) =>
    json.encode(data.toJson());

class PaymentSubmitAutomaticModel {
  final Message message;
  final Data data;
  final String type;

  PaymentSubmitAutomaticModel({
    required this.message,
    required this.data,
    required this.type,
  });

  factory PaymentSubmitAutomaticModel.fromJson(Map<String, dynamic> json) =>
      PaymentSubmitAutomaticModel(
        message: Message.fromJson(json["message"]),
        data: Data.fromJson(json["data"]),
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "message": message.toJson(),
        "data": data.toJson(),
        "type": type,
      };
}

class Data {
  final String redirectUrl;
  final List<dynamic> redirectLinks;
  final String actionType;

  Data({
    required this.redirectUrl,
    required this.redirectLinks,
    required this.actionType,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        redirectUrl: json["redirect_url"],
        redirectLinks: List<dynamic>.from(json["redirect_links"].map((x) => x)),
        actionType: json["action_type"],
      );

  Map<String, dynamic> toJson() => {
        "redirect_url": redirectUrl,
        "redirect_links": List<dynamic>.from(redirectLinks.map((x) => x)),
        "action_type": actionType,
      };
}

class Message {
  final List<String> success;

  Message({
    required this.success,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        success: List<String>.from(json["success"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "success": List<dynamic>.from(success.map((x) => x)),
      };
}
