// To parse this JSON data, do
//
//     final rideHomeModel = rideHomeModelFromJson(jsonString);

import 'dart:convert';

RideHomeModel rideHomeModelFromJson(String str) =>
    RideHomeModel.fromJson(json.decode(str));

String rideHomeModelToJson(RideHomeModel data) => json.encode(data.toJson());

class RideHomeModel {
  String? status;
  Data? data;

  RideHomeModel({
    this.status,
    this.data,
  });

  factory RideHomeModel.fromJson(Map<String, dynamic> json) => RideHomeModel(
        status: json["status"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data?.toJson(),
      };
}

class Data {
  String? id;
  List<DriverAd>? driverAd;
  List<DriverAd>? referral;

  Data({
    this.id,
    this.driverAd,
    this.referral,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        driverAd: json["driver_ad"] == null
            ? []
            : List<DriverAd>.from(
                json["driver_ad"]!.map((x) => DriverAd.fromJson(x))),
        referral: json["referral"] == null
            ? []
            : List<DriverAd>.from(
                json["referral"]!.map((x) => DriverAd.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "driver_ad": driverAd == null
            ? []
            : List<dynamic>.from(driverAd!.map((x) => x.toJson())),
        "referral": referral == null
            ? []
            : List<dynamic>.from(referral!.map((x) => x.toJson())),
      };
}

class DriverAd {
  String? url;
  String? offerText;

  DriverAd({
    this.url,
    this.offerText,
  });

  factory DriverAd.fromJson(Map<String, dynamic> json) => DriverAd(
        url: json["url"],
        offerText: json["offer_text"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "offer_text": offerText,
      };
}
