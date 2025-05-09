// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  String? status;
  Data? data;

  LoginModel({
    this.status,
    this.data,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        status: json["status"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data?.toJson(),
      };
}

class Data {
  String? firstName;
  String? lastName;
  String? email;
  String? password;
  String? phoneNumber;
  String? country;
  String? state;
  String? city;
  String? street;
  String? postalCode;
  Lp? lp;
  int? userId;
  String? profile;
  String? authToken;
  String? confirmPassword;

  Data({
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.phoneNumber,
    this.country,
    this.state,
    this.city,
    this.street,
    this.postalCode,
    this.lp,
    this.userId,
    this.profile,
    this.authToken,
    this.confirmPassword,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        password: json["password"],
        phoneNumber: json["phone_number"],
        country: json["country"],
        state: json["state"],
        city: json["city"],
        street: json["street"],
        postalCode: json["postal_code"],
        lp: json["lp"] == null ? null : Lp.fromJson(json["lp"]),
        userId: json["user_id"],
        profile: json["profile"],
        authToken: json["auth_token"],
        confirmPassword: json["confirm_password"],
      );

  Map<String, dynamic> toJson() => {
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "password": password,
        "phone_number": phoneNumber,
        "country": country,
        "state": state,
        "city": city,
        "street": street,
        "postal_code": postalCode,
        "lp": lp?.toJson(),
        "user_id": userId,
        "profile": profile,
        "auth_token": authToken,
        "confirm_password": confirmPassword,
      };
}

class Lp {
  String? name;
  int? id;

  Lp({
    this.name,
    this.id,
  });

  factory Lp.fromJson(Map<String, dynamic> json) => Lp(
        name: json["name"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
      };
}

class User {
  String? name;
  int? id;
  String? phoneNumber;
  String? countryCode;
  User({
    this.name,
    this.id,
    this.phoneNumber,
    this.countryCode,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        name: json["name"],
        id: json["id"],
        phoneNumber: json["phone_number"],
        countryCode: json["country_code"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
        "phone_number": phoneNumber,
        "country_code": countryCode,
      };
}
