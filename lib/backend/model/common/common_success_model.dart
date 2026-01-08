import 'dart:convert';

CommonSuccessModel commonSuccessModelFromJson(String str) =>
    CommonSuccessModel.fromJson(json.decode(str));

String commonSuccessModelToJson(CommonSuccessModel data) =>
    json.encode(data.toJson());

class CommonSuccessModel {
  CommonSuccessModel({
    required this.message,
  });

  Message message;

  factory CommonSuccessModel.fromJson(Map<String, dynamic> json) {
    final rawMessage = json["message"];
    if (rawMessage is Map<String, dynamic>) {
      return CommonSuccessModel(
        message: Message.fromJson(rawMessage),
      );
    } else if (rawMessage is List) {
      // Some APIs return message as a list of strings instead of an object
      return CommonSuccessModel(
        message: Message(success: List<String>.from(rawMessage.map((x) => x.toString()))),
      );
    } else {
      return CommonSuccessModel(
        message: Message(success: []),
      );
    }
  }

  Map<String, dynamic> toJson() => {
        "message": message.toJson(),
      };
}

class Message {
  Message({
    required this.success,
  });

  List<String> success;

  factory Message.fromJson(dynamic json) {
    if (json is Map<String, dynamic>) {
      return Message(
        success: List<String>.from(json["success"].map((x) => x.toString())),
      );
    } else if (json is List) {
      return Message(
        success: List<String>.from(json.map((x) => x.toString())),
      );
    } else {
      return Message(success: []);
    }
  }

  Map<String, dynamic> toJson() => {
        "success": List<dynamic>.from(success.map((x) => x)),
      };
}
