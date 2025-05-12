// To parse this JSON data, do
//
//     final countryCodeList = countryCodeListFromJson(jsonString);

import 'dart:convert';

CountryCodeList countryCodeListFromJson(String str) =>
    CountryCodeList.fromJson(json.decode(str));

String countryCodeListToJson(CountryCodeList data) =>
    json.encode(data.toJson());

class CountryCodeList {
  String? status;
  List<Country>? data;

  CountryCodeList({
    this.status,
    this.data,
  });

  factory CountryCodeList.fromJson(Map<String, dynamic> json) =>
      CountryCodeList(
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<Country>.from(json["data"]!.map((x) => Country.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Country {
  String? id;
  String? name;
  String? countryCode;
  String? flagUrl;

  Country({
    this.id,
    this.name,
    this.countryCode,
    this.flagUrl,
  });

  factory Country.fromJson(Map<String, dynamic> json) => Country(
        id: json["id"],
        name: json["name"],
        countryCode: json["country_code"],
        flagUrl: json["flag_url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "country_code": countryCode,
        "flag_url": flagUrl,
      };
}
