import 'dart:convert';

TwoFaInfoModel twoFaInfoModelFromJson(String str) =>
    TwoFaInfoModel.fromJson(json.decode(str));

String twoFaInfoModelToJson(TwoFaInfoModel data) => json.encode(data.toJson());

class TwoFaInfoModel {
  final Message message;
  final Data data;
  final String type;

  TwoFaInfoModel({
    required this.message,
    required this.data,
    required this.type,
  });

  factory TwoFaInfoModel.fromJson(Map<String, dynamic> json) => TwoFaInfoModel(
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
  final String status;
  final String message;

  Data({
    required this.status,
    required this.message,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
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
