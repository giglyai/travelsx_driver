// To parse this JSON data, do
//
//     final tripSingleModel = tripSingleModelFromJson(jsonString);

import 'dart:convert';

TripSingleModel tripSingleModelFromJson(String str) =>
    TripSingleModel.fromJson(json.decode(str));

String tripSingleModelToJson(TripSingleModel data) =>
    json.encode(data.toJson());

class TripSingleModel {
  String? status;
  Data? data;

  TripSingleModel({
    this.status,
    this.data,
  });

  factory TripSingleModel.fromJson(Map<String, dynamic> json) =>
      TripSingleModel(
        status: json["status"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data?.toJson(),
      };
}

class Data {
  AgentMetrics? agentMetrics;
  Metrics? metrics;
  List<List<Activity>>? activities;

  Data({
    this.agentMetrics,
    this.metrics,
    this.activities,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        agentMetrics: json["agent_metrics"] == null
            ? null
            : AgentMetrics.fromJson(json["agent_metrics"]),
        metrics:
            json["metrics"] == null ? null : Metrics.fromJson(json["metrics"]),
        activities: json["activities"] == null
            ? []
            : List<List<Activity>>.from(json["activities"]!.map((x) =>
                List<Activity>.from(x.map((x) => Activity.fromJson(x))))),
      );

  Map<String, dynamic> toJson() => {
        "agent_metrics": agentMetrics?.toJson(),
        "metrics": metrics?.toJson(),
        "activities": activities == null
            ? []
            : List<dynamic>.from(activities!
                .map((x) => List<dynamic>.from(x.map((x) => x.toJson())))),
      };
}

class Activity {
  String? rideId;
  String? rideType;
  String? vehicleType;
  String? user;
  String? phoneNumber;
  String? fee;
  String? currency;
  String? pickupPlace;
  String? dropoffPlace;
  String? pickupAddress;
  String? dropoffAddress;
  String? date;
  String? distance;
  String? time;
  String? couldCancelRide;
  String? tolls;
  Activity({
    this.rideId,
    this.rideType,
    this.vehicleType,
    this.user,
    this.phoneNumber,
    this.fee,
    this.currency,
    this.pickupPlace,
    this.dropoffPlace,
    this.pickupAddress,
    this.dropoffAddress,
    this.date,
    this.distance,
    this.time,
    this.couldCancelRide,
    this.tolls,
  });

  factory Activity.fromJson(Map<String, dynamic> json) => Activity(
        rideId: json["ride_id"],
        rideType: json["ride_type"],
        vehicleType: json["vehicle_type"],
        user: json["user"],
        phoneNumber: json["phone_number"],
        fee: json["fee"],
        currency: json["currency"],
        pickupPlace: json["pickup_place"],
        dropoffPlace: json["dropoff_place"],
        pickupAddress: json["pickup_address"],
        dropoffAddress: json["dropoff_address"],
        date: json["date"],
        distance: json["distance"],
        time: json["time"],
        couldCancelRide: json["could_cancel_ride"],
        tolls: json["tolls"],
      );

  Map<String, dynamic> toJson() => {
        "ride_id": rideId,
        "ride_type": rideType,
        "vehicle_type": vehicleType,
        "user": user,
        "phone_number": phoneNumber,
        "fee": fee,
        "currency": currency,
        "pickup_place": pickupPlace,
        "dropoff_place": dropoffPlace,
        "pickup_address": pickupAddress,
        "dropoff_address": dropoffAddress,
        "date": date,
        "distance": distance,
        "time": time,
        "could_cancel_ride": couldCancelRide,
        "tolls": tolls,
      };
}

class AgentMetrics {
  int? booked;
  int? completed;
  int? cancelled;

  AgentMetrics({
    this.booked,
    this.completed,
    this.cancelled,
  });

  factory AgentMetrics.fromJson(Map<String, dynamic> json) => AgentMetrics(
        booked: json["booked"],
        completed: json["completed"],
        cancelled: json["cancelled"],
      );

  Map<String, dynamic> toJson() => {
        "booked": booked,
        "completed": completed,
        "cancelled": cancelled,
      };
}

class Metrics {
  int? totalTrips;
  Breakdown? breakdown;

  Metrics({
    this.totalTrips,
    this.breakdown,
  });

  factory Metrics.fromJson(Map<String, dynamic> json) => Metrics(
        totalTrips: json["total_trips"],
        breakdown: json["breakdown"] == null
            ? null
            : Breakdown.fromJson(json["breakdown"]),
      );

  Map<String, dynamic> toJson() => {
        "total_trips": totalTrips,
        "breakdown": breakdown?.toJson(),
      };
}

class Breakdown {
  String? totalDistance;
  String? totalTime;

  Breakdown({
    this.totalDistance,
    this.totalTime,
  });

  factory Breakdown.fromJson(Map<String, dynamic> json) => Breakdown(
        totalDistance: json["total_distance"],
        totalTime: json["total_time"],
      );

  Map<String, dynamic> toJson() => {
        "total_distance": totalDistance,
        "total_time": totalTime,
      };
}
