// To parse this JSON data, do
//
//     final transactionModel = transactionModelFromJson(jsonString);

import 'dart:convert';

TransactionModel transactionModelFromJson(String str) =>
    TransactionModel.fromJson(json.decode(str));

String transactionModelToJson(TransactionModel data) =>
    json.encode(data.toJson());

class TransactionModel {
  final Message message;
  final Data data;
  final String type;

  TransactionModel({
    required this.message,
    required this.data,
    required this.type,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      TransactionModel(
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
  final Instructions instructions;
  final List<String> transactionTypes;
  final List<Transaction> transactions;

  Data({
    required this.instructions,
    required this.transactionTypes,
    required this.transactions,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        instructions: Instructions.fromJson(json["instructions"]),
        transactionTypes:
            List<String>.from(json["transaction_types"].map((x) => x)),
        transactions: List<Transaction>.from(
            json["transactions"].map((x) => Transaction.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "instructions": instructions.toJson(),
        "transaction_types": List<dynamic>.from(transactionTypes.map((x) => x)),
        "transactions": List<dynamic>.from(transactions.map((x) => x.toJson())),
      };
}

class Instructions {
  final String slug;
  final String status;

  Instructions({
    required this.slug,
    required this.status,
  });

  factory Instructions.fromJson(Map<String, dynamic> json) => Instructions(
        slug: json["slug"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "slug": slug,
        "status": status,
      };
}

class Transaction {
  final String type;
  final String trxId;
  final String requestCurrency;
  final int receiveAmount;
  final int status;
  final dynamic callbackRef;
  final DateTime createdAt;

  Transaction({
    required this.type,
    required this.trxId,
    required this.requestCurrency,
    required this.receiveAmount,
    required this.status,
    required this.callbackRef,
    required this.createdAt,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
        type: json["type"],
        trxId: json["trx_id"],
        requestCurrency: json["request_currency"],
        receiveAmount: json["receive_amount"],
        status: json["status"],
        callbackRef: json["callback_ref"],
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "trx_id": trxId,
        "request_currency": requestCurrency,
        "receive_amount": receiveAmount,
        "status": status,
        "callback_ref": callbackRef,
        "created_at": createdAt.toIso8601String(),
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
