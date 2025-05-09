// To parse this JSON data, do
//
//     final walletModel = walletModelFromJson(jsonString);

import 'dart:convert';

WalletModel walletModelFromJson(String str) =>
    WalletModel.fromJson(json.decode(str));

String walletModelToJson(WalletModel data) => json.encode(data.toJson());

class WalletModel {
  String? status;
  Data? data;

  WalletModel({
    this.status,
    this.data,
  });

  factory WalletModel.fromJson(Map<String, dynamic> json) => WalletModel(
        status: json["status"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data?.toJson(),
      };
}

class Data {
  Total? total;
  List<Transaction>? transactions;

  Data({
    this.total,
    this.transactions,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        total: json["total"] == null ? null : Total.fromJson(json["total"]),
        transactions: json["transactions"] == null
            ? []
            : List<Transaction>.from(
                json["transactions"]!.map((x) => Transaction.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "total": total?.toJson(),
        "transactions": transactions == null
            ? []
            : List<dynamic>.from(transactions!.map((x) => x.toJson())),
      };
}

class Total {
  int? balance;
  String? currency;

  Total({
    this.balance,
    this.currency,
  });

  factory Total.fromJson(Map<String, dynamic> json) => Total(
        balance: json["balance"],
        currency: json["currency"],
      );

  Map<String, dynamic> toJson() => {
        "balance": balance,
        "currency": currency,
      };
}

class Transaction {
  String? id;
  String? createdTime;
  int? amount;
  String? currency;
  String? type;
  String? description;
  String? transaction;

  Transaction({
    this.id,
    this.createdTime,
    this.type,
    this.amount,
    this.currency,
    this.description,
    this.transaction,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
        id: json["id"],
        type: json["type"],
        createdTime: json["timestamp"],
        amount: json["amount"],
        currency: json["currency"],
        description: json["description"],
        transaction: json["transaction"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "timestamp": createdTime,
        "amount": amount,
        "currency": currency,
        "description": description,
        "transaction": transaction,
      };
}
