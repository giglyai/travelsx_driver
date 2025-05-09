// To parse this JSON data, do
//
//     final tripMetrics = tripMetricsFromJson(jsonString);

import 'dart:convert';

TripMetrics tripMetricsFromJson(String str) => TripMetrics.fromJson(json.decode(str));

String tripMetricsToJson(TripMetrics data) => json.encode(data.toJson());

class TripMetrics {
  String? status;
  Data? data;

  TripMetrics({
    this.status,
    this.data,
  });

  factory TripMetrics.fromJson(Map<String, dynamic> json) => TripMetrics(
    status: json["status"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data?.toJson(),
  };
}

class Data {
  String? sinceOnline;
  String? sinceOffline;
  String? dayEarnings;
  String? currency;
  int? dayTrips;

  Data({
    this.sinceOnline,
    this.sinceOffline,
    this.dayEarnings,
    this.currency,
    this.dayTrips,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    sinceOnline: json["sinceOnline"],
    sinceOffline: json["sinceOffline"],
    dayEarnings: json["dayEarnings"],
    currency: json["currency"],
    dayTrips: json["dayTrips"],
  );

  Map<String, dynamic> toJson() => {
    "sinceOnline": sinceOnline,
    "sinceOffline": sinceOffline,
    "dayEarnings": dayEarnings,
    "currency": currency,
    "dayTrips": dayTrips,
  };
}
