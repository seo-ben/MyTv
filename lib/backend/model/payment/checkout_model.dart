import 'dart:convert';

CheckoutModel checkoutModelFromJson(String str) =>
    CheckoutModel.fromJson(json.decode(str));

class CheckoutModel {
  final Message message;
  final Data data;

  CheckoutModel({
    required this.message,
    required this.data,
  });

  factory CheckoutModel.fromJson(Map<String, dynamic> json) => CheckoutModel(
        message: Message.fromJson(json["message"]),
        data: Data.fromJson(json["data"]),
      );
}

class Data {
  final RequestData requestData;
  final List<PaymentMethod> paymentMethods;
  final String expireDate;

  Data({
    required this.requestData,
    required this.paymentMethods,
    required this.expireDate,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        requestData: RequestData.fromJson(json["request_data"]),
        paymentMethods: List<PaymentMethod>.from(
            json["payment_methods"].map((x) => PaymentMethod.fromJson(x))),
        expireDate: json["expire_date"],
      );
}

class PaymentMethod {
  final int id;
  final dynamic slug;
  final dynamic code;
  final dynamic type;
  final dynamic name;
  final dynamic title;
  final dynamic alias;
  final dynamic image;
  final List<Credential> credentials;
  final List<String> supportedCurrencies;

  PaymentMethod({
    required this.id,
    required this.slug,
    required this.code,
    required this.type,
    required this.name,
    required this.title,
    required this.alias,
    required this.image,
    required this.credentials,
    required this.supportedCurrencies,
  });

  factory PaymentMethod.fromJson(Map<String, dynamic> json) => PaymentMethod(
        id: json["id"],
        slug: json["slug"] ?? '',
        code: json["code"] ?? '',
        type: json["type"] ?? '',
        name: json["name"] ?? '',
        title: json["title"] ?? '',
        alias: json["alias"] ?? '',
        image: json["image"] ?? '',
        credentials: List<Credential>.from(
            json["credentials"].map((x) => Credential.fromJson(x))),
        supportedCurrencies:
            List<String>.from(json["supported_currencies"].map((x) => x)),
      );
}

class Credential {
  final dynamic label;
  final dynamic placeholder;
  final dynamic name;
  final dynamic value;

  Credential({
    required this.label,
    required this.placeholder,
    required this.name,
    required this.value,
  });

  factory Credential.fromJson(Map<String, dynamic> json) => Credential(
        label: json["label"] ?? '',
        placeholder: json["placeholder"] ?? '',
        name: json["name"] ?? '',
        value: json["value"] ?? '',
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
  });

  factory Currency.fromJson(Map<String, dynamic> json) => Currency(
        id: json["id"],
        paymentGatewayId: json["payment_gateway_id"],
        name: json["name"] ?? '',
        alias: json["alias"] ?? '',
        currencyCode: json["currency_code"] ?? '',
        currencySymbol: json["currency_symbol"] ?? '',
        image: json["image"] ?? '',
        minLimit: json["min_limit"] ?? '',
        maxLimit: json["max_limit"] ?? '',
        percentCharge: json["percent_charge"] ?? '',
        fixedCharge: json["fixed_charge"] ?? '',
        rate: json["rate"] ?? '',
      );
}

class RequestData {
  final dynamic packageId;
  final dynamic price;
  final dynamic name;
  final dynamic duration;

  RequestData({
    required this.packageId,
    required this.price,
    required this.name,
    required this.duration,
  });

  factory RequestData.fromJson(Map<String, dynamic> json) => RequestData(
        packageId: json["package_id"] ?? '',
        price: json["price"] ?? '',
        name: json["name"] ?? '',
        duration: json["duration"] ?? '',
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
