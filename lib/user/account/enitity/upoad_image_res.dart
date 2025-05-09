// To parse this JSON data, do
//
//     final profileImageRes = profileImageResFromJson(jsonString);

import 'dart:convert';

ProfileImageRes profileImageResFromJson(String str) =>
    ProfileImageRes.fromJson(json.decode(str));

String profileImageResToJson(ProfileImageRes data) =>
    json.encode(data.toJson());

class ProfileImageRes {
  String? status;
  Data? data;

  ProfileImageRes({
    this.status,
    this.data,
  });

  factory ProfileImageRes.fromJson(Map<String, dynamic> json) =>
      ProfileImageRes(
        status: json["status"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data?.toJson(),
      };
}

class Data {
  String? imageUrl;

  Data({
    this.imageUrl,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        imageUrl: json["image_url"],
      );

  Map<String, dynamic> toJson() => {
        "image_url": imageUrl,
      };
}
