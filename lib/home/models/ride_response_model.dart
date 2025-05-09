// To parse this JSON data, do
//
//     final ride = rideFromJson(jsonString);

import 'dart:convert';

import 'package:travelx_driver/home/models/position_data_model.dart';

List<Ride> rideFromJson(List jsonData) =>
    List<Ride>.from(jsonData.map((x) => Ride.fromJson(x)));

String rideToJson(List<Ride> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Ride {
  String? rideFeature;
  String? vehicleType;
  String? rideTripId;
  String? rideId;
  Driver driver;
  Promo? promo;
  PickupDetails? pickupDetails;
  TripDetails? tripDetails;
  List<TripSequence> tripSequence;
  Price? price;
  List<Route>? route;
  String? rideType;
  String? tripsNearDropoff;
  String? tripId;
  DropoffDetails? dropoffDetails;
  bool? rideAval;
  String? rideVehicle;
  String? rideAvalTime;
  CreatedBy? createdBy;
  User? user;
  Payment? payment;
  RideCommn? rideCommn;

  Ride({
    this.rideTripId,
    this.rideId,
    required this.driver,
    this.promo,
    this.createdBy,
    this.pickupDetails,
    this.tripDetails,
    required this.tripSequence,
    this.price,
    this.route,
    this.tripsNearDropoff,
    this.tripId,
    this.dropoffDetails,
    this.rideType,
    this.rideAval,
    this.rideVehicle,
    this.rideAvalTime,
    this.user,
    this.payment,
    this.vehicleType,
    this.rideFeature,
    this.rideCommn,
  });

  factory Ride.fromJson(Map<String, dynamic> json) => Ride(
        rideTripId: json["trip_id"],
        rideId: json["ride_id"],
        driver: Driver.fromJson(json["driver"]),
        createdBy: json["created_by"] == null
            ? null
            : CreatedBy.fromJson(json["created_by"]),
        payment:
            json["payment"] == null ? null : Payment.fromJson(json["payment"]),
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        promo: json["promo"] == null ? null : Promo.fromJson(json["promo"]),
        pickupDetails: json["pickup_details"] == null
            ? null
            : PickupDetails.fromJson(json["pickup_details"]),
        tripDetails: json["trip_details"] == null
            ? null
            : TripDetails.fromJson(json["trip_details"]),
        tripSequence: List<TripSequence>.from(
            json["trip_sequence"].map((x) => TripSequence.fromJson(x))),
        price: json["price"] == null ? null : Price.fromJson(json["price"]),
        route: json["route"] == null
            ? []
            : List<Route>.from(json["route"]!.map((x) => Route.fromJson(x))),
        rideType: json["ride_type"],

        tripsNearDropoff: json["trips_near_dropoff"],
        tripId: json["tripId"],
        // dropoffDetails: json["dropoff_details"] == null
        //     ? null
        //     : DropoffDetails.fromJson(json["dropoff_details"]),
        rideAval: json["ride_aval"],
        rideVehicle: json["ride_vehicle"],
        vehicleType: json["vehicle_type"],
        rideAvalTime: json["ride_aval_time"],
        rideFeature: json["ride_feature"],
        rideCommn: json["ride_commn"] == null
            ? null
            : RideCommn?.fromJson(json["ride_commn"]),
      );

  Map<String, dynamic> toJson() => {
        "trip_id": rideTripId,
        "ride_id": rideId,
        "driver": driver.toJson(),
        "promo": promo?.toJson(),
        "created_by": createdBy?.toJson(),
        "pickup_details": pickupDetails?.toJson(),
        "trip_details": tripDetails?.toJson(),
        "trip_sequence":
            List<dynamic>.from(tripSequence.map((x) => x.toJson())),
        "price": price?.toJson(),
        "route": route == null
            ? []
            : List<dynamic>.from(route!.map((x) => x.toJson())),
        "ride_type": rideType,

        "trips_near_dropoff": tripsNearDropoff,
        "tripId": tripId,
        "ride_vehicle": rideVehicle,

        "ride_aval": rideAval,
        "ride_aval_time": rideAvalTime,
        "user": user?.toJson(),
        "vehicle_type": vehicleType,
        "ride_feature": rideFeature,
        // "dropoff_details": dropoffDetails?.toJson(),
        "ride_commn": rideCommn?.toJson(),
      };
}

class Driver {
  DriverPosition position;

  Driver({
    required this.position,
  });

  factory Driver.fromJson(Map<String, dynamic> json) => Driver(
        position: DriverPosition.fromJson(json["position"]),
      );

  Map<String, dynamic> toJson() => {
        "position": position.toJson(),
      };
}

class Position {
  double latitude;
  double longitude;

  Position({
    required this.latitude,
    required this.longitude,
  });

  factory Position.fromJson(Map<String, dynamic> json) => Position(
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "latitude": latitude,
        "longitude": longitude,
      };
}

class DropoffDetails {
  String? distance;
  String? distanceUnit;
  String? duration;
  String? durationUnit;

  DropoffDetails({
    this.distance,
    this.distanceUnit,
    this.duration,
    this.durationUnit,
  });

  factory DropoffDetails.fromJson(Map<String, dynamic> json) => DropoffDetails(
        distance: json["distance"],
        distanceUnit: json["distanceUnit"],
        duration: json["duration"],
        durationUnit: json["durationUnit"],
      );

  Map<String, dynamic> toJson() => {
        "distance": distance,
        "distanceUnit": distanceUnit,
        "duration": duration,
        "durationUnit": durationUnit,
      };
}

class PickupDetails {
  dynamic distance;
  String? distanceUnit;
  dynamic duration;
  String? durationUnit;

  PickupDetails({
    this.distance,
    this.distanceUnit,
    this.duration,
    this.durationUnit,
  });

  factory PickupDetails.fromJson(Map<String, dynamic> json) => PickupDetails(
        distance: json["distance"],
        distanceUnit: json["distanceUnit"],
        duration: json["duration"],
        durationUnit: json["durationUnit"],
      );

  Map<String, dynamic> toJson() => {
        "distance": distance,
        "distanceUnit": distanceUnit,
        "duration": duration,
        "durationUnit": durationUnit,
      };
}

class Price {
  String? id;
  String? pricePerUnit;
  String? currency;
  String? totalPrice;
  String? priceText;

  Price({
    this.id,
    this.pricePerUnit,
    this.currency,
    this.totalPrice,
    this.priceText,
  });

  factory Price.fromJson(Map<String, dynamic> json) => Price(
        id: json["id"],
        pricePerUnit: json["price_per_unit"],
        currency: json["currency"],
        totalPrice: json["total_price"],
        priceText: json["price_text"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "price_per_unit": pricePerUnit,
        "currency": currency,
        "total_price": totalPrice,
        "price_text": priceText,
      };
}

class Promo {
  String? promoHead;
  String? promoText;
  String? promoUrl;

  Promo({
    this.promoHead,
    this.promoText,
    this.promoUrl,
  });

  factory Promo.fromJson(Map<String, dynamic> json) => Promo(
        promoHead: json["promo_head"],
        promoText: json["promo_text"],
        promoUrl: json["promo_url"],
      );

  Map<String, dynamic> toJson() => {
        "promo_head": promoHead,
        "promo_text": promoText,
        "promo_url": promoUrl,
      };
}

class Route {
  Route({
    this.type,
    this.routePath,
  });
  String? type;
  String? routePath;

  factory Route.fromJson(Map<String, dynamic> json) => Route(
        type: json["type"],
        routePath: json["route_path"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "route_path": routePath,
      };
}

class TripDetails {
  String? distance;
  String? distanceUnit;
  String? duration;
  String? durationUnit;
  int? noOfTolls;

  TripDetails({
    this.distance,
    this.distanceUnit,
    this.duration,
    this.durationUnit,
    this.noOfTolls,
  });

  factory TripDetails.fromJson(Map<String, dynamic> json) => TripDetails(
        distance: json["distance"],
        distanceUnit: json["distanceUnit"],
        duration: json["duration"],
        durationUnit: json["durationUnit"],
        noOfTolls: json["noOfTolls"],
      );

  Map<String, dynamic> toJson() => {
        "distance": distance,
        "distanceUnit": distanceUnit,
        "duration": duration,
        "durationUnit": durationUnit,
        "noOfTolls": noOfTolls,
      };
}

class TripSequence {
  String? type;
  String? address;
  DriverPosition position;
  String? name;
  String? notes;
  String? firstName;

  String? lastName;

  String? phoneNumber;
  String? pickupTime;
  String? dropoffTime;

  TripSequence(
      {this.type,
      this.address,
      required this.position,
      this.name,
      this.notes,
      this.phoneNumber,
      this.firstName,
      this.lastName,
      this.pickupTime,
      this.dropoffTime});

  factory TripSequence.fromJson(Map<String, dynamic> json) => TripSequence(
        type: json["type"],
        address: json["address"],
        position: DriverPosition.fromJson(json["position"]),
        name: json["name"],
        notes: json["notes"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        phoneNumber: json["phone_number"],
        pickupTime: json["pickup_time"],
        dropoffTime: json["dropoff_time"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "address": address,
        "position": position.toJson(),
        "name": name,
        "notes": notes,
        "first_name": firstName,
        "last_name": lastName,
        "phone_number": phoneNumber,
        "pickup_time": pickupTime,
        "dropoff_time": dropoffTime,
      };
}

class CreatedBy {
  String? name;
  String? subText;

  CreatedBy({this.name, this.subText});

  factory CreatedBy.fromJson(Map<String, dynamic> json) => CreatedBy(
        name: json["name"],
        subText: json["sub_text"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "sub_text": subText,
      };
}

class User {
  String? deviceToken;

  User({
    this.deviceToken,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        deviceToken: json["device_token"],
      );

  Map<String, dynamic> toJson() => {
        "device_token": deviceToken,
      };
}

class Payment {
  String? amount;
  String? currency;
  String? mode;
  String? status;

  Payment({this.amount, this.currency, this.mode, this.status});

  factory Payment.fromJson(Map<String, dynamic> json) => Payment(
        amount: json["amount"],
        currency: json["currency"],
        mode: json["mode"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "amount": amount,
        "currency": currency,
        "mode": mode,
        "status": status,
      };
}

class RideCommn {
  int? totalCommn;
  int? walletBalance;
  int? reqAmount;
  String? currency;
  String? desc;

  RideCommn({
    this.totalCommn,
    this.walletBalance,
    this.reqAmount,
    this.currency,
    this.desc,
  });

  factory RideCommn.fromJson(Map<String, dynamic> json) => RideCommn(
        totalCommn: json["total_commn"],
        walletBalance: json["wallet_balance"],
        reqAmount: json["req_amount"],
        currency: json["currency"],
        desc: json["desc"],
      );

  Map<String, dynamic> toJson() => {
        "total_commn": totalCommn,
        "wallet_balance": walletBalance,
        "req_amount": reqAmount,
        "currency": currency,
        "desc": desc,
      };
}
