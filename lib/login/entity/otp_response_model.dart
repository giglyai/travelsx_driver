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
  String? userProfile;

  Data({
    this.lp,
    this.user,
    this.profile,
    this.authToken,
    this.userProfile,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        lp: json["lp"] == null ? null : Lp.fromJson(json["lp"]),
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        profile:
            json["profile"] == null ? null : Profile.fromJson(json["profile"]),
        authToken: json["auth_token"],
        userProfile: json["user_profile"],
      );

  Map<String, dynamic> toJson() => {
        "lp": lp?.toJson(),
        "user": user?.toJson(),
        "profile": profile?.toJson(),
        "auth_token": authToken,
        "user_profile": userProfile,
      };
}

class Lp {
  int? id;
  String? name;

  Lp({
    this.id,
    this.name,
  });

  factory Lp.fromJson(Map<String, dynamic> json) => Lp(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class Profile {
  String? onlineStatus;
  String? rideStatus;
  String? deliveryStatus;

  Profile({
    this.onlineStatus,
    this.rideStatus,
    this.deliveryStatus,
  });

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        onlineStatus: json["online_status"],
        rideStatus: json["ride_status"],
        deliveryStatus: json["delivery_status"],
      );

  Map<String, dynamic> toJson() => {
        "online_status": onlineStatus,
        "ride_status": rideStatus,
        "delivery_status": deliveryStatus,
      };
}

class User {
  int? id;
  String? firstName;
  String? lastName;
  String? phoneNumber;
  String? countryCode;
  String? accountStatus;

  User({
    this.id,
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.countryCode,
    this.accountStatus,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        phoneNumber: json["phone_number"],
        countryCode: json["country_code"],
        accountStatus: json["account_status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "phone_number": phoneNumber,
        "country_code": countryCode,
        "account_status": accountStatus,
      };
}
