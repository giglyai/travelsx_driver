// To parse this JSON data, do
//
//     final paymentResposne = paymentResposneFromJson(jsonString);

import 'dart:convert';

PaymentResposne paymentResposneFromJson(String str) =>
    PaymentResposne.fromJson(json.decode(str));

String paymentResposneToJson(PaymentResposne data) =>
    json.encode(data.toJson());

class PaymentResposne {
  bool? success;
  String? code;
  String? message;
  Data? data;

  PaymentResposne({
    this.success,
    this.code,
    this.message,
    this.data,
  });

  factory PaymentResposne.fromJson(Map<String, dynamic> json) =>
      PaymentResposne(
        success: json["success"],
        code: json["code"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "code": code,
        "message": message,
        "data": data?.toJson(),
      };
}

class Data {
  String? merchantId;
  String? merchantTransactionId;
  String? transactionId;
  int? amount;
  String? state;
  String? responseCode;
  PaymentInstrument? paymentInstrument;

  Data({
    this.merchantId,
    this.merchantTransactionId,
    this.transactionId,
    this.amount,
    this.state,
    this.responseCode,
    this.paymentInstrument,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        merchantId: json["merchantId"],
        merchantTransactionId: json["merchantTransactionId"],
        transactionId: json["transactionId"],
        amount: json["amount"],
        state: json["state"],
        responseCode: json["responseCode"],
        paymentInstrument: json["paymentInstrument"] == null
            ? null
            : PaymentInstrument.fromJson(json["paymentInstrument"]),
      );

  Map<String, dynamic> toJson() => {
        "merchantId": merchantId,
        "merchantTransactionId": merchantTransactionId,
        "transactionId": transactionId,
        "amount": amount,
        "state": state,
        "responseCode": responseCode,
        "paymentInstrument": paymentInstrument?.toJson(),
      };
}

class PaymentInstrument {
  String? type;
  String? utr;
  String? unmaskedAccountNumber;

  PaymentInstrument({
    this.type,
    this.utr,
    this.unmaskedAccountNumber,
  });

  factory PaymentInstrument.fromJson(Map<String, dynamic> json) =>
      PaymentInstrument(
        type: json["type"],
        utr: json["utr"],
        unmaskedAccountNumber: json["unmaskedAccountNumber"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "utr": utr,
        "unmaskedAccountNumber": unmaskedAccountNumber,
      };
}
