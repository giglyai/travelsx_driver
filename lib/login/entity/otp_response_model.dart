// To parse this JSON data, do
//
//     final otpModelResponse = otpModelResponseFromJson(jsonString);

import 'dart:convert';

OtpModelResponse otpModelResponseFromJson(String str) =>
    OtpModelResponse.fromJson(json.decode(str));

String otpModelResponseToJson(OtpModelResponse data) =>
    json.encode(data.toJson());

class OtpModelResponse {
  String? status;
  Data? data;

  OtpModelResponse({
    this.status,
    this.data,
  });

  factory OtpModelResponse.fromJson(Map<String, dynamic> json) =>
      OtpModelResponse(
        status: json["status"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data?.toJson(),
  };
}

class Data {
  Lp? lp;
  User? user;
  Profile? profile;
  String? authToken;

  Data({
    this.lp,
    this.user,
    this.profile,
    this.authToken,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    lp: json["lp"] == null ? null : Lp.fromJson(json["lp"]),
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    profile:
    json["profile"] == null ? null : Profile.fromJson(json["profile"]),
    authToken: json["auth_token"],
  );

  Map<String, dynamic> toJson() => {
    "lp": lp?.toJson(),
    "user": user?.toJson(),
    "profile": profile?.toJson(),
    "auth_token": authToken,
  };
}

class Lp {
  int? id;
  String? name;
  String? phoneNumber;
  String? countryCode;

  Lp({
    this.id,
    this.name,
    this.phoneNumber,
    this.countryCode,
  });

  factory Lp.fromJson(Map<String, dynamic> json) => Lp(
    id: json["id"],
    name: json["name"],
    phoneNumber: json["phone_number"],
    countryCode: json["country_code"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "phone_number": phoneNumber,
    "country_code": countryCode,
  };
}

class Profile {
  String? onlineStatus;

  Profile({
    this.onlineStatus,
  });

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
    onlineStatus: json["online_status"],
  );

  Map<String, dynamic> toJson() => {
    "online_status": onlineStatus,
  };
}

class User {
  int? id;
  String? firstName;
  String? lastName;
  String? phoneNumber;
  String? countryCode;
  String? accountStatus;
  bool? isSubscribed;
  bool? isNewUser;

  User({
    this.id,
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.countryCode,
    this.accountStatus,
    this.isSubscribed,
    this.isNewUser,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    phoneNumber: json["phone_number"],
    countryCode: json["country_code"],
    accountStatus: json["account_status"],
    isSubscribed: json["is_subscribed"],
    isNewUser: json["is_new_user"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "first_name": firstName,
    "last_name": lastName,
    "phone_number": phoneNumber,
    "country_code": countryCode,
    "account_status": accountStatus,
    "is_subscribed": isSubscribed,
    "is_new_user": isNewUser,
  };
}
