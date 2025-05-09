// To parse this JSON data, do
//
//     final earningFilterModel = earningFilterModelFromJson(jsonString);

import 'dart:convert';

EarningFilterModel earningFilterModelFromJson(String str) =>
    EarningFilterModel.fromJson(json.decode(str));

String earningFilterModelToJson(EarningFilterModel data) =>
    json.encode(data.toJson());

class EarningFilterModel {
  String status;
  Data data;

  EarningFilterModel({
    required this.status,
    required this.data,
  });

  factory EarningFilterModel.fromJson(Map<String, dynamic> json) =>
      EarningFilterModel(
        status: json["status"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data.toJson(),
      };
}

class Data {
  Metrics metrics;
  List<List<Activity>> activities;

  Data({
    required this.metrics,
    required this.activities,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        metrics: Metrics.fromJson(json["metrics"]),
        activities: List<List<Activity>>.from(json["activities"].map(
            (x) => List<Activity>.from(x.map((x) => Activity.fromJson(x))))),
      );

  Map<String, dynamic> toJson() => {
        "metrics": metrics.toJson(),
        "activities": List<dynamic>.from(activities
            .map((x) => List<dynamic>.from(x.map((x) => x.toJson())))),
      };
}

class Activity {
  String text;
  int fee;
  String currency;
  String date;
  String distance;
  String time;
  String pickupAddress;
  String dropoffAddress;
  String createdTime;

  Activity(
      {required this.text,
      required this.fee,
      required this.currency,
      required this.date,
      required this.distance,
      required this.time,
      required this.pickupAddress,
      required this.dropoffAddress,
      required this.createdTime});

  factory Activity.fromJson(Map<String, dynamic> json) => Activity(
        createdTime: json["created_time"],
        text: json["text"],
        fee: json["fee"],
        currency: json["currency"],
        date: json["date"],
        distance: json["distance"],
        time: json["time"],
        pickupAddress: json["pickup_address"],
        dropoffAddress: json["dropoff_address"],
      );

  Map<String, dynamic> toJson() => {
        "created_time": createdTime,
        "text": text,
        "fee": fee,
        "currency": currency,
        "date": date,
        "distance": distance,
        "time": time,
        "pickup_address": pickupAddress,
        "dropoff_address": dropoffAddress,
      };
}

class Metrics {
  Breakdown breakdown;

  Metrics({
    required this.breakdown,
  });

  factory Metrics.fromJson(Map<String, dynamic> json) => Metrics(
        breakdown: Breakdown.fromJson(json["breakdown"]),
      );

  Map<String, dynamic> toJson() => {
        "breakdown": breakdown.toJson(),
      };
}

class Breakdown {
  int totalAmount;
  String currency;
  int totalTrips;
  String totalDistance;
  String totalTime;

  Breakdown({
    required this.totalAmount,
    required this.currency,
    required this.totalTrips,
    required this.totalDistance,
    required this.totalTime,
  });

  factory Breakdown.fromJson(Map<String, dynamic> json) => Breakdown(
        totalAmount: json["total_amount"],
        currency: json["currency"],
        totalTrips: json["total_trips"],
        totalDistance: json["total_distance"],
        totalTime: json["total_time"],
      );

  Map<String, dynamic> toJson() => {
        "total_amount": totalAmount,
        "currency": currency,
        "total_trips": totalTrips,
        "total_distance": totalDistance,
        "total_time": totalTime,
      };
}
