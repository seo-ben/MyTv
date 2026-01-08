import 'dart:convert';

PaypalSubmitModel paypalSubmitModelFromJson(String str) =>
    PaypalSubmitModel.fromJson(json.decode(str));

String paypalSubmitModelToJson(PaypalSubmitModel data) =>
    json.encode(data.toJson());

class PaypalSubmitModel {
  final Message message;
  final Data data;
  final String type;

  PaypalSubmitModel({
    required this.message,
    required this.data,
    required this.type,
  });

  factory PaypalSubmitModel.fromJson(Map<String, dynamic> json) =>
      PaypalSubmitModel(
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
  final List<RedirectLink> redirectLinks;
  final String actionType;

  Data({
    required this.redirectUrl,
    required this.redirectLinks,
    required this.actionType,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        redirectUrl: json["redirect_url"],
        redirectLinks: List<RedirectLink>.from(
            json["redirect_links"].map((x) => RedirectLink.fromJson(x))),
        actionType: json["action_type"],
      );

  Map<String, dynamic> toJson() => {
        "redirect_url": redirectUrl,
        "redirect_links":
            List<dynamic>.from(redirectLinks.map((x) => x.toJson())),
        "action_type": actionType,
      };
}

class RedirectLink {
  final String href;
  final String rel;
  final String method;

  RedirectLink({
    required this.href,
    required this.rel,
    required this.method,
  });

  factory RedirectLink.fromJson(Map<String, dynamic> json) => RedirectLink(
        href: json["href"],
        rel: json["rel"],
        method: json["method"],
      );

  Map<String, dynamic> toJson() => {
        "href": href,
        "rel": rel,
        "method": method,
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
