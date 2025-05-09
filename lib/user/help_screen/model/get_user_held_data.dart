// To parse this JSON data, do
//
//     final getUserHelpData = getUserHelpDataFromJson(jsonString);

import 'dart:convert';

GetUserHelpData getUserHelpDataFromJson(String str) => GetUserHelpData.fromJson(json.decode(str));

String getUserHelpDataToJson(GetUserHelpData data) => json.encode(data.toJson());

class GetUserHelpData {
  String? status;
  Data? data;

  GetUserHelpData({
    this.status,
    this.data,
  });

  factory GetUserHelpData.fromJson(Map<String, dynamic> json) => GetUserHelpData(
    status: json["status"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data?.toJson(),
  };
}

class Data {
  String? whtsapp;
  String? phone;

  Data({
    this.whtsapp,
    this.phone,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    whtsapp: json["whtsapp"],
    phone: json["phone"],
  );

  Map<String, dynamic> toJson() => {
    "whtsapp": whtsapp,
    "phone": phone,
  };
}
