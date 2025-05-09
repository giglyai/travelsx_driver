// To parse this JSON data, do
//
//     final getFinalRideFullDetails = getFinalRideFullDetailsFromJson(jsonString);

import 'dart:convert';

GetFinalRideFullDetails getFinalRideFullDetailsFromJson(String str) =>
    GetFinalRideFullDetails.fromJson(json.decode(str));

String getFinalRideFullDetailsToJson(GetFinalRideFullDetails data) =>
    json.encode(data.toJson());

class GetFinalRideFullDetails {
  String? status;
  Data? data;

  GetFinalRideFullDetails({
    this.status,
    this.data,
  });

  factory GetFinalRideFullDetails.fromJson(Map<String, dynamic> json) =>
      GetFinalRideFullDetails(
        status: json["status"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data?.toJson(),
      };
}

class Data {
  int? totalDistance;
  String? totalTime;
  String? currency;
  int? totalFee;
  String? name;
  String? phoneNumber;
  String? pickup;
  String? dropoff;

  Data({
    this.totalDistance,
    this.totalTime,
    this.currency,
    this.totalFee,
    this.name,
    this.phoneNumber,
    this.pickup,
    this.dropoff,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        totalDistance: json["total_distance"],
        totalTime: json["total_time"],
        currency: json["currency"],
        totalFee: json["total_fee"],
        name: json["name"],
        phoneNumber: json["phone_number"],
        pickup: json["pickup"],
        dropoff: json["dropoff"],
      );

  Map<String, dynamic> toJson() => {
        "total_distance": totalDistance,
        "total_time": totalTime,
        "currency": currency,
        "total_fee": totalFee,
        "name": name,
        "phone_number": phoneNumber,
        "pickup": pickup,
        "dropoff": dropoff,
      };
}
