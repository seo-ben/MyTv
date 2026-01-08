import 'dart:convert';

PaymentInfoModel paymentInfoModelFromJson(String str) =>
    PaymentInfoModel.fromJson(json.decode(str));

class PaymentInfoModel {
  final Message message;
  final Data data;
  final String type;

  PaymentInfoModel({
    required this.message,
    required this.data,
    required this.type,
  });

  factory PaymentInfoModel.fromJson(Map<String, dynamic> json) =>
      PaymentInfoModel(
        message: Message.fromJson(json["message"]),
        data: Data.fromJson(json["data"]),
        type: json["type"],
      );
}

class Data {
  final List<PaymentGateway> paymentGateways;

  Data({
    required this.paymentGateways,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        paymentGateways: List<PaymentGateway>.from(
            json["payment_gateways"].map((x) => PaymentGateway.fromJson(x))),
      );
}

class PaymentGateway {
  final int id;
  final dynamic type;
  final dynamic name;

  final dynamic desc;

  final List<Currency> currencies;

  PaymentGateway({
    required this.id,
    required this.type,
    required this.name,
    required this.desc,
    required this.currencies,
  });

  factory PaymentGateway.fromJson(Map<String, dynamic> json) => PaymentGateway(
        id: json["id"],
        type: json["type"] ?? '',
        name: json["name"] ?? '',
        desc: json["desc"] ?? '',
        currencies: List<Currency>.from(
            json["currencies"].map((x) => Currency.fromJson(x))),
      );
}

class Currency {
  final int id;
  final int paymentGatewayId;
  final dynamic name;
  final dynamic alias;
  final dynamic currencyCode;
  final dynamic currencySymbol;
  final dynamic image;
  final dynamic minLimit;
  final dynamic maxLimit;
  final dynamic percentCharge;
  final dynamic fixedCharge;
  final dynamic rate;
  final DateTime createdAt;
  final DateTime updatedAt;

  Currency({
    required this.id,
    required this.paymentGatewayId,
    required this.name,
    required this.alias,
    required this.currencyCode,
    required this.currencySymbol,
    required this.image,
    required this.minLimit,
    required this.maxLimit,
    required this.percentCharge,
    required this.fixedCharge,
    required this.rate,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Currency.fromJson(Map<String, dynamic> json) => Currency(
        id: json["id"],
        paymentGatewayId: json["payment_gateway_id"],
        name: json["name"] ?? '',
        alias: json["alias"] ?? '',
        currencyCode: json["currency_code"] ?? '',
        currencySymbol: json["currency_symbol"] ?? '',
        image: json["image"] ?? '',
        minLimit: json["min_limit"],
        maxLimit: json["max_limit"],
        percentCharge: json["percent_charge"],
        fixedCharge: json["fixed_charge"],
        rate: json["rate"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
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
