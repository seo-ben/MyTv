import 'dart:convert';

MySubscriptionInfoModel mySubscriptionInfoModelFromJson(String str) =>
    MySubscriptionInfoModel.fromJson(json.decode(str));

String mySubscriptionInfoModelToJson(MySubscriptionInfoModel data) =>
    json.encode(data.toJson());

class MySubscriptionInfoModel {
  final Message message;
  final List<Datum> data;

  MySubscriptionInfoModel({
    required this.message,
    required this.data,
  });

  factory MySubscriptionInfoModel.fromJson(Map<String, dynamic> json) =>
      MySubscriptionInfoModel(
        message: Message.fromJson(json["message"]),
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message.toJson(),
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  final int id;
  final dynamic packageName;
  final dynamic amount;
  final dynamic status;
  final DateTime createdAt;
  final Transaction transaction;

  Datum({
    required this.id,
    required this.packageName,
    required this.amount,
    required this.status,
    required this.createdAt,
    required this.transaction,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        packageName: json["package_name"],
        amount: json["amount"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        transaction: Transaction.fromJson(json["transaction"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "package_name": packageName,
        "amount": amount,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "transaction": transaction.toJson(),
      };
}

class Transaction {
  final int id;
  final dynamic trx;
  final dynamic amount;
  final int status;

  Transaction({
    required this.id,
    required this.trx,
    required this.amount,
    required this.status,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
        id: json["id"],
        trx: json["trx"],
        amount: json["amount"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "trx": trx,
        "amount": amount,
        "status": status,
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
