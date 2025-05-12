// To parse this JSON data, do
//
//     final getCountryCodeRes = getCountryCodeResFromJson(jsonString);

import 'dart:convert';

GetCountryCodeRes getCountryCodeResFromJson(String str) =>
    GetCountryCodeRes.fromJson(json.decode(str));

String getCountryCodeResToJson(GetCountryCodeRes data) =>
    json.encode(data.toJson());

class GetCountryCodeRes {
  String? status;
  Data? data;

  GetCountryCodeRes({
    this.status,
    this.data,
  });

  factory GetCountryCodeRes.fromJson(Map<String, dynamic> json) =>
      GetCountryCodeRes(
        status: json["status"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data?.toJson(),
      };
}

class Data {
  String? countryCode;

  Data({
    this.countryCode,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        countryCode: json["country_code"],
      );

  Map<String, dynamic> toJson() => {
        "country_code": countryCode,
      };
}
