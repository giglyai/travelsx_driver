// To parse this JSON data, do
//
//     final accountDeleteRes = accountDeleteResFromJson(jsonString);

import 'dart:convert';

AccountDeleteRes accountDeleteResFromJson(String str) => AccountDeleteRes.fromJson(json.decode(str));

String accountDeleteResToJson(AccountDeleteRes data) => json.encode(data.toJson());

class AccountDeleteRes {
  String status;
  String data;

  AccountDeleteRes({
    required this.status,
    required this.data,
  });

  factory AccountDeleteRes.fromJson(Map<String, dynamic> json) => AccountDeleteRes(
    status: json["status"],
    data: json["data"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data,
  };
}
