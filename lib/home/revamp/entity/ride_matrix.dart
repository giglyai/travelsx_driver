// To parse this JSON data, do
//
//     final getAllTripsData = getAllTripsDataFromJson(jsonString);

import 'dart:convert';

GetAllTripsData getAllTripsDataFromJson(String str) =>
    GetAllTripsData.fromJson(json.decode(str));

String getAllTripsDataToJson(GetAllTripsData data) =>
    json.encode(data.toJson());

class GetAllTripsData {
  String? status;
  TripData? data;

  GetAllTripsData({
    this.status,
    this.data,
  });

  factory GetAllTripsData.fromJson(Map<String, dynamic> json) =>
      GetAllTripsData(
        status: json["status"],
        data: json["data"] == null ? null : TripData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data?.toJson(),
      };
}

class TripData {
  List<TripAllData>? all;
  List<TripAllData>? booked;
  List<TripAllData>? assigned;
  List<TripAllData>? onTrip;
  List<TripAllData>? completed;

  List<TripAllData>? cancelled;

  TripData({
    this.all,
    this.booked,
    this.assigned,
    this.onTrip,
    this.completed,
    this.cancelled,
  });

  factory TripData.fromJson(Map<String, dynamic> json) => TripData(
        all: json["all"] == null
            ? []
            : List<TripAllData>.from(
                json["all"]!.map((x) => TripAllData.fromJson(x))),
        booked: json["booked"] == null
            ? []
            : List<TripAllData>.from(
                json["booked"]!.map((x) => TripAllData.fromJson(x))),
        assigned: json["assigned"] == null
            ? []
            : List<TripAllData>.from(
                json["assigned"]!.map((x) => TripAllData.fromJson(x))),
        onTrip: json["ontrip"] == null
            ? []
            : List<TripAllData>.from(
                json["ontrip"]!.map((x) => TripAllData.fromJson(x))),
        completed: json["completed"] == null
            ? []
            : List<TripAllData>.from(
                json["completed"]!.map((x) => TripAllData.fromJson(x))),
        cancelled: json["cancelled"] == null
            ? []
            : List<TripAllData>.from(
                json["cancelled"]!.map((x) => TripAllData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "all":
            all == null ? [] : List<dynamic>.from(all!.map((x) => x.toJson())),
        "booked": booked == null
            ? []
            : List<dynamic>.from(booked!.map((x) => x.toJson())),
        "assigned":
            assigned == null ? [] : List<dynamic>.from(assigned!.map((x) => x)),
        "completed": completed == null
            ? []
            : List<dynamic>.from(completed!.map((x) => x)),
        "cancelled": cancelled == null
            ? []
            : List<dynamic>.from(cancelled!.map((x) => x)),
        "ontrip":
            onTrip == null ? [] : List<dynamic>.from(onTrip!.map((x) => x)),
      };
}

class TripAllData {
  String? rideId;
  String? rideType;
  String? vehicleType;
  String? name;
  String? phoneNumber;
  String? estimatedFee;
  String? currency;
  String? pickupPlace;
  String? dropoffPlace;
  String? pickupAddress;
  String? dropoffAddress;
  String? pickupTime;
  String? estDistance;
  String? estTime;
  String? estTolls;
  String? cancelRide;
  String? assignRide;
  String? feature;
  String? userMessage;

  TripAllData({
    this.rideId,
    this.rideType,
    this.vehicleType,
    this.name,
    this.phoneNumber,
    this.estimatedFee,
    this.currency,
    this.pickupPlace,
    this.dropoffPlace,
    this.pickupAddress,
    this.dropoffAddress,
    this.pickupTime,
    this.estDistance,
    this.estTime,
    this.estTolls,
    this.cancelRide,
    this.assignRide,
    this.feature,
    this.userMessage,
  });

  factory TripAllData.fromJson(Map<String, dynamic> json) => TripAllData(
        rideId: json["ride_id"],
        rideType: json["ride_type"],
        vehicleType: json["vehicle_type"],
        name: json["name"],
        phoneNumber: json["phone_number"],
        estimatedFee: json["est_fee"],
        currency: json["currency"],
        pickupPlace: json["pickup_place"],
        dropoffPlace: json["dropoff_place"],
        pickupAddress: json["pickup_address"],
        dropoffAddress: json["dropoff_address"],
        pickupTime: json["pickup_time"],
        estDistance: json["est_distance"],
        estTime: json["est_time"],
        estTolls: json["est_tolls"],
        cancelRide: json["cancel_ride"],
        assignRide: json["assign_ride"],
        feature: json["feature"],
        userMessage: json["user_message"],
      );

  Map<String, dynamic> toJson() => {
        "ride_id": rideId,
        "ride_type": rideType,
        "vehicle_type": vehicleType,
        "name": name,
        "phone_number": phoneNumber,
        "est_fee": estimatedFee,
        "currency": currency,
        "pickup_place": pickupPlace,
        "dropoff_place": dropoffPlace,
        "pickup_address": pickupAddress,
        "dropoff_address": dropoffAddress,
        "pickup_time": pickupTime,
        "est_distance": estDistance,
        "est_time": estTime,
        "est_tolls": estTolls,
        "cancel_ride": cancelRide,
        "assign_ride": assignRide,
        "feature": feature,
        "user_message": userMessage,
      };
}
