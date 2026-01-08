import 'dart:convert';

DashboardModel dashboardModelFromJson(String str) =>
    DashboardModel.fromJson(json.decode(str));

class DashboardModel {
  final Message message;
  final Data? data;

  DashboardModel({
    required this.message,
    required this.data,
  });

  factory DashboardModel.fromJson(Map<String, dynamic> json) => DashboardModel(
        message: Message.fromJson(json["message"]),
        data: (json["data"] == null ||
                (json["data"] is List && json["data"].isEmpty))
            ? null
            : Data.fromJson(json["data"]),
      );
}

class Data {
  final SubscriptionLog? subscriptionLog;

  Data({
    this.subscriptionLog,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        subscriptionLog: json["subscription_log"] is Map<String, dynamic>
            ? SubscriptionLog.fromJson(json["subscription_log"])
            : null,
      );
}

class SubscriptionLog {
  final int id;
  final int userId;
  final int transactionId;
  final int packageId;
  final String expireDate;
  final bool status;
  final DateTime createdAt;
  final dynamic updatedAt;
  final Package package;
  final Transaction transaction;

  SubscriptionLog({
    required this.id,
    required this.userId,
    required this.transactionId,
    required this.packageId,
    required this.expireDate,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.package,
    required this.transaction,
  });

  factory SubscriptionLog.fromJson(Map<String, dynamic> json) =>
      SubscriptionLog(
        id: json["id"],
        userId: json["user_id"],
        transactionId: json["transaction_id"],
        packageId: json["package_id"],
        expireDate: json["expire_date"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"],
        package: Package.fromJson(json["package"]),
        transaction: Transaction.fromJson(json["transaction"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "transaction_id": transactionId,
        "package_id": packageId,
        "expire_date": expireDate,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt,
        "package": package.toJson(),
        "transaction": transaction.toJson(),
      };
}

class Package {
  final int id;
  final String name;
  final String duration;
  final String type;
  final int price;
  final String defaultFeature;
  final int status;
  final DateTime createdAt;
  final DateTime updatedAt;

  Package({
    required this.id,
    required this.name,
    required this.duration,
    required this.type,
    required this.price,
    required this.defaultFeature,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Package.fromJson(Map<String, dynamic> json) => Package(
        id: json["id"],
        name: json["name"],
        duration: json["duration"],
        type: json["type"],
        price: json["price"],
        defaultFeature: json["default_feature"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "duration": duration,
        "type": type,
        "price": price,
        "default_feature": defaultFeature,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class Transaction {
  final int id;

  final String trxId;

  final int requestAmount;
  final String requestCurrency;

  Transaction({
    required this.id,
    required this.trxId,
    required this.requestAmount,
    required this.requestCurrency,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
        id: json["id"],
        trxId: json["trx_id"],
        requestAmount: json["request_amount"],
        requestCurrency: json["request_currency"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "trx_id": trxId,
        "request_amount": requestAmount,
        "request_currency": requestCurrency,
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
