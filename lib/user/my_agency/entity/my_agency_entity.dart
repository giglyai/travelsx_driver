// To parse this JSON data, do
//
//     final myAgency = myAgencyFromJson(jsonString);

import 'dart:convert';

MyAgency myAgencyFromJson(String str) => MyAgency.fromJson(json.decode(str));

String myAgencyToJson(MyAgency data) => json.encode(data.toJson());

class MyAgency {
  String status;
  List<Datum> data;

  MyAgency({
    required this.status,
    required this.data,
  });

  factory MyAgency.fromJson(Map<String, dynamic> json) => MyAgency(
        status: json["status"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  String? countryCode;
  String? phoneNumber;
  String businessName;
  String address;
  String place;
  int userId;
  int lpId;
  double latitude;
  double longitude;

  Datum({
    required this.countryCode,
    required this.businessName,
    required this.phoneNumber,
    required this.address,
    required this.place,
    required this.userId,
    required this.lpId,
    required this.latitude,
    required this.longitude,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        businessName: json["business_name"],
        countryCode: json["country_code"],
        phoneNumber: json["phone_number"],
        address: json["address"],
        place: json["place"],
        userId: json["user_id"],
        lpId: json["lp_id"],
        latitude: json["latitude"],
        longitude: json["longitude"],
      );

  Map<String, dynamic> toJson() => {
        "business_name": businessName,
        "country_code": countryCode,
        "phone_number": phoneNumber,
        "address": address,
        "place": place,
        "user_id": userId,
        "lp_id": lpId,
        "latitude": latitude,
        "longitude": longitude
      };
}
