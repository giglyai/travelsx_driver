// To parse this JSON data, do
//
//     final profileImageRes = profileImageResFromJson(jsonString);

import 'dart:convert';

ProfileImageBackRes profileImageResFromJson(String str) =>
    ProfileImageBackRes.fromJson(json.decode(str));

String profileImageResToJson(ProfileImageBackRes data) =>
    json.encode(data.toJson());

class ProfileImageBackRes {
  String? status;
  Data? data;

  ProfileImageBackRes({
    this.status,
    this.data,
  });

  factory ProfileImageBackRes.fromJson(Map<String, dynamic> json) =>
      ProfileImageBackRes(
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
