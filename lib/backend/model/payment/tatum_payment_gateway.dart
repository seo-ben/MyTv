import 'dart:convert';

TatumGatewayModel tatumGatewayModelFromJson(String str) =>
    TatumGatewayModel.fromJson(json.decode(str));

class TatumGatewayModel {
  final Message message;
  final Data data;
  final String type;

  TatumGatewayModel({
    required this.message,
    required this.data,
    required this.type,
  });

  factory TatumGatewayModel.fromJson(Map<String, dynamic> json) =>
      TatumGatewayModel(
        message: Message.fromJson(json["message"]),
        data: Data.fromJson(json["data"]),
        type: json["type"],
      );
}

class Data {
  final bool redirectUrl;
  final List<dynamic> redirectLinks;
  final String actionType;
  final String trxId;
  final AddressInfo addressInfo;

  Data(
      {required this.redirectUrl,
      required this.redirectLinks,
      required this.actionType,
      required this.addressInfo,
      required this.trxId});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        redirectUrl: json["redirect_url"],
        trxId: json["trx_id"],
        redirectLinks: List<dynamic>.from(json["redirect_links"].map((x) => x)),
        actionType: json["action_type"],
        addressInfo: AddressInfo.fromJson(json["address_info"]),
      );
}

class AddressInfo {
  final int the0;
  final String coin;
  final String address;
  final List<InputField> inputFields;

  AddressInfo({
    required this.the0,
    required this.coin,
    required this.address,
    required this.inputFields,
  });

  factory AddressInfo.fromJson(Map<String, dynamic> json) => AddressInfo(
        the0: json["0"],
        coin: json["coin"],
        address: json["address"],
        inputFields: List<InputField>.from(
            json["input_fields"].map((x) => InputField.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "0": the0,
        "coin": coin,
        "address": address,
        "input_fields": List<dynamic>.from(inputFields.map((x) => x.toJson())),
      };
}

class InputField {
  final String type;
  final String label;
  final String placeholder;
  final String name;
  final bool required;
  final Validation validation;

  InputField({
    required this.type,
    required this.label,
    required this.placeholder,
    required this.name,
    required this.required,
    required this.validation,
  });

  factory InputField.fromJson(Map<String, dynamic> json) => InputField(
        type: json["type"],
        label: json["label"],
        placeholder: json["placeholder"],
        name: json["name"],
        required: json["required"],
        validation: Validation.fromJson(json["validation"]),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "label": label,
        "placeholder": placeholder,
        "name": name,
        "required": required,
        "validation": validation.toJson(),
      };
}

class Validation {
  final String min;
  final String max;
  final bool required;

  Validation({
    required this.min,
    required this.max,
    required this.required,
  });

  factory Validation.fromJson(Map<String, dynamic> json) => Validation(
        min: json["min"],
        max: json["max"],
        required: json["required"],
      );

  Map<String, dynamic> toJson() => {
        "min": min,
        "max": max,
        "required": required,
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
