import 'dart:convert';

AuthorizeSubmitModel authorizeSubmitModelFromJson(String str) =>
    AuthorizeSubmitModel.fromJson(json.decode(str));

String authorizeSubmitModelToJson(AuthorizeSubmitModel data) =>
    json.encode(data.toJson());

class AuthorizeSubmitModel {
  Message? message;
  Data? data;
  String? type;

  AuthorizeSubmitModel({this.message, this.data, this.type});

  factory AuthorizeSubmitModel.fromJson(Map<String, dynamic> json) =>
      AuthorizeSubmitModel(
        message: json["message"] == null
            ? null
            : Message.fromJson(json["message"]),
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
    "message": message?.toJson(),
    "data": data?.toJson(),
    "type": type,
  };
}

class Data {
  String? identifier;
  String? gatewayAlias;
  String? actionType;

  Data({this.identifier, this.gatewayAlias, this.actionType});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    identifier: json["identifier"],
    gatewayAlias: json["gateway_alias"],
    actionType: json["action_type"],
  );

  Map<String, dynamic> toJson() => {
    "identifier": identifier,
    "gateway_alias": gatewayAlias,
    "action_type": actionType,
  };
}

class Message {
  List<String>? success;

  Message({this.success});

  factory Message.fromJson(Map<String, dynamic> json) => Message(
    success: json["success"] == null
        ? []
        : List<String>.from(json["success"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "success": success == null
        ? []
        : List<dynamic>.from(success!.map((x) => x)),
  };
}
