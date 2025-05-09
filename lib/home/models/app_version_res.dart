// To parse this JSON data, do
//
//     final appVersionRes = appVersionResFromJson(jsonString);

import 'dart:convert';

AppVersionRes appVersionResFromJson(String str) =>
    AppVersionRes.fromJson(json.decode(str));

String appVersionResToJson(AppVersionRes data) => json.encode(data.toJson());

class AppVersionRes {
  String? status;
  Data? data;

  AppVersionRes({
    this.status,
    this.data,
  });

  factory AppVersionRes.fromJson(Map<String, dynamic> json) => AppVersionRes(
        status: json["status"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data?.toJson(),
      };
}

class Data {
  String appVersion;
  String installMandatory;

  Data({
    required this.appVersion,
    required this.installMandatory,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        appVersion: json["app_version"],
        installMandatory: json["install_mandatory"],
      );

  Map<String, dynamic> toJson() => {
        "app_version": appVersion,
        "install_mandatory": installMandatory,
      };
}
