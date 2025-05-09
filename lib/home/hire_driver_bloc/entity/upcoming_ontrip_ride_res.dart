// To parse this JSON data, do
//
//     final upcomingOntripRideRes = upcomingOntripRideResFromJson(jsonString);

import 'dart:convert';

import 'package:travelx_driver/home/models/position_data_model.dart';

UpcomingOntripRideRes upcomingOntripRideResFromJson(String str) =>
    UpcomingOntripRideRes.fromJson(json.decode(str));

String upcomingOntripRideResToJson(UpcomingOntripRideRes data) =>
    json.encode(data.toJson());

class UpcomingOntripRideRes {
  String? status;
  Data? data;

  UpcomingOntripRideRes({
    this.status,
    this.data,
  });

  factory UpcomingOntripRideRes.fromJson(Map<String, dynamic> json) =>
      UpcomingOntripRideRes(
        status: json["status"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data?.toJson(),
      };
}

class Data {
  List<UpcomingRide>? upcomingRide;
  List<OntripRide>? ontripRide;
  List<NewRide>? newRide;
  Data({this.upcomingRide, this.ontripRide, this.newRide});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        upcomingRide: json["upcoming_ride"] == null
            ? []
            : List<UpcomingRide>.from(
                json["upcoming_ride"]!.map((x) => UpcomingRide.fromJson(x))),
        ontripRide: json["ontrip_ride"] == null
            ? []
            : List<OntripRide>.from(
                json["ontrip_ride"]!.map((x) => OntripRide.fromJson(x))),
        newRide: json["new_ride"] == null
            ? []
            : List<NewRide>.from(
                json["new_ride"]!.map((x) => NewRide.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "upcoming_ride": upcomingRide == null
            ? []
            : List<dynamic>.from(upcomingRide!.map((x) => x.toJson())),
        "ontrip_ride": ontripRide == null
            ? []
            : List<dynamic>.from(ontripRide!.map((x) => x.toJson())),
        "new_ride": newRide == null
            ? []
            : List<dynamic>.from(newRide!.map((x) => x.toJson())),
      };
}

class OntripRide {
  String? tripId;
  String? rideId;
  Driver driver;
  Promo? promo;
  String? bookedBy;
  String? bookedByContact;
  String? bookedFor;
  String? bookedForContact;
  CreatedBy? createdBy;
  String? rideStatus;
  PickupDetails? pickupDetails;
  TripDetails? tripDetails;
  OntripRideDriverDetails? driverDetails;
  List<TripSequence>? tripSequence;
  String? rideRoute;
  Price? price;
  List<dynamic>? route;
  String? rideVehicle;
  String? rideType;
  String? tripsNearDropoff;
  bool? rideAval;
  String? rideAvalTime;
  String? vehicleType;
  String? rideFeature;
  String? travelMode;
  User? user;
  Payment? payment;
  String? userMessage;

  OntripRide({
    this.tripId,
    this.rideId,
    required this.driver,
    this.promo,
    this.bookedBy,
    this.bookedByContact,
    this.bookedFor,
    this.bookedForContact,
    this.createdBy,
    this.rideStatus,
    this.pickupDetails,
    this.tripDetails,
    this.driverDetails,
    this.tripSequence,
    this.rideRoute,
    this.price,
    this.route,
    this.rideVehicle,
    this.rideType,
    this.tripsNearDropoff,
    this.rideAval,
    this.rideAvalTime,
    this.vehicleType,
    this.rideFeature,
    this.travelMode,
    this.user,
    this.payment,
    this.userMessage,
  });

  factory OntripRide.fromJson(Map<String, dynamic> json) => OntripRide(
        tripId: json["trip_id"],
        userMessage: json["user_message"],
        rideId: json["ride_id"],
        driver: Driver.fromJson(json["driver"]),
        promo: json["promo"] == null ? null : Promo.fromJson(json["promo"]),
        bookedBy: json["booked_by"],
        bookedByContact: json["booked_by_contact"],
        bookedFor: json["booked_for"],
        bookedForContact: json["booked_for_contact"],
        createdBy: json["created_by"] == null
            ? null
            : CreatedBy.fromJson(json["created_by"]),
        rideStatus: json["ride_status"],
        pickupDetails: json["pickup_details"] == null
            ? null
            : PickupDetails.fromJson(json["pickup_details"]),
        tripDetails: json["trip_details"] == null
            ? null
            : TripDetails.fromJson(json["trip_details"]),
        driverDetails: json["driver_details"] == null
            ? null
            : OntripRideDriverDetails.fromJson(json["driver_details"]),
        tripSequence: json["trip_sequence"] == null
            ? []
            : List<TripSequence>.from(
                json["trip_sequence"]!.map((x) => TripSequence.fromJson(x))),
        rideRoute: json["ride_route"],
        price: json["price"] == null ? null : Price.fromJson(json["price"]),
        route: json["route"] == null
            ? []
            : List<dynamic>.from(json["route"]!.map((x) => x)),
        rideVehicle: json["ride_vehicle"],
        rideType: json["ride_type"],
        tripsNearDropoff: json["trips_near_dropoff"],
        rideAval: json["ride_aval"],
        rideAvalTime: json["ride_aval_time"],
        vehicleType: json["vehicle_type"],
        rideFeature: json["ride_feature"],
        travelMode: json["travel_mode"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        payment:
            json["payment"] == null ? null : Payment.fromJson(json["payment"]),
      );

  Map<String, dynamic> toJson() => {
        "trip_id": tripId,
        "ride_id": rideId,
        "user_message": userMessage,
        "driver": driver?.toJson(),
        "promo": promo?.toJson(),
        "booked_by": bookedBy,
        "booked_by_contact": bookedByContact,
        "booked_for": bookedFor,
        "booked_for_contact": bookedForContact,
        "created_by": createdBy?.toJson(),
        "ride_status": rideStatus,
        "pickup_details": pickupDetails?.toJson(),
        "trip_details": tripDetails?.toJson(),
        "driver_details": driverDetails?.toJson(),
        "trip_sequence": tripSequence == null
            ? []
            : List<dynamic>.from(tripSequence!.map((x) => x.toJson())),
        "ride_route": rideRoute,
        "price": price?.toJson(),
        "route": route == null ? [] : List<dynamic>.from(route!.map((x) => x)),
        "ride_vehicle": rideVehicle,
        "ride_type": rideType,
        "trips_near_dropoff": tripsNearDropoff,
        "ride_aval": rideAval,
        "ride_aval_time": rideAvalTime,
        "vehicle_type": vehicleType,
        "ride_feature": rideFeature,
        "travel_mode": travelMode,
        "user": user?.toJson(),
        "payment": payment?.toJson(),
      };
}

class NewRide {
  String? tripId;
  String? rideId;
  Driver? driver;
  Promo? promo;
  String? bookedBy;
  String? bookedByContact;
  String? bookedFor;
  String? bookedForContact;
  CreatedBy? createdBy;
  String? rideStatus;
  PickupDetails? pickupDetails;
  TripDetails? tripDetails;
  List<TripSequence>? tripSequence;
  String? rideRoute;
  Price? price;

  List<dynamic>? route;
  String? rideVehicle;
  String? rideType;
  String? tripsNearDropoff;
  String? staysAt;
  String? noOfAdults;
  String? noOfKids;
  String? tourDuration;
  bool? rideAval;
  String? rideAvalTime;
  String? vehicleType;
  String? rideFeature;
  String? travelMode;
  User? user;
  Payment? payment;
  String? userMessage;
  bool? cancelRide;

  NewRide({
    this.tripId,
    this.rideId,
    this.driver,
    this.promo,
    this.bookedBy,
    this.bookedByContact,
    this.bookedFor,
    this.bookedForContact,
    this.createdBy,
    this.rideStatus,
    this.pickupDetails,
    this.tripDetails,
    this.tripSequence,
    this.rideRoute,
    this.price,
    this.route,
    this.rideVehicle,
    this.rideType,
    this.tripsNearDropoff,
    this.staysAt,
    this.noOfAdults,
    this.noOfKids,
    this.tourDuration,
    this.rideAval,
    this.rideAvalTime,
    this.vehicleType,
    this.rideFeature,
    this.travelMode,
    this.user,
    this.payment,
    this.userMessage,
    this.cancelRide,
  });

  factory NewRide.fromJson(Map<String, dynamic> json) => NewRide(
        tripId: json["trip_id"],
        rideId: json["ride_id"],
        driver: json["driver"] == null ? null : Driver.fromJson(json["driver"]),
        promo: json["promo"] == null ? null : Promo.fromJson(json["promo"]),
        bookedBy: json["booked_by"],
        bookedByContact: json["booked_by_contact"],
        bookedFor: json["booked_for"],
        bookedForContact: json["booked_for_contact"],
        createdBy: json["created_by"] == null
            ? null
            : CreatedBy.fromJson(json["created_by"]),
        rideStatus: json["ride_status"],
        pickupDetails: json["pickup_details"] == null
            ? null
            : PickupDetails.fromJson(json["pickup_details"]),
        tripDetails: json["trip_details"] == null
            ? null
            : TripDetails.fromJson(json["trip_details"]),
        tripSequence: json["trip_sequence"] == null
            ? []
            : List<TripSequence>.from(
                json["trip_sequence"]!.map((x) => TripSequence.fromJson(x))),
        rideRoute: json["ride_route"],
        price: json["price"] == null ? null : Price.fromJson(json["price"]),
        route: json["route"] == null
            ? []
            : List<dynamic>.from(json["route"]!.map((x) => x)),
        rideVehicle: json["ride_vehicle"],
        rideType: json["ride_type"],
        tripsNearDropoff: json["trips_near_dropoff"],
        staysAt: json["stays_at"],
        noOfAdults: json["no_of_adults"],
        noOfKids: json["no_of_kids"],
        tourDuration: json["tour_duration"],
        rideAval: json["ride_aval"],
        rideAvalTime: json["ride_aval_time"],
        vehicleType: json["vehicle_type"],
        rideFeature: json["ride_feature"],
        travelMode: json["travel_mode"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        payment:
            json["payment"] == null ? null : Payment.fromJson(json["payment"]),
        userMessage: json["user_message"],
        cancelRide: json["cancel_ride"],
      );

  Map<String, dynamic> toJson() => {
        "trip_id": tripId,
        "ride_id": rideId,
        "driver": driver?.toJson(),
        "promo": promo?.toJson(),
        "booked_by": bookedBy,
        "booked_by_contact": bookedByContact,
        "booked_for": bookedFor,
        "booked_for_contact": bookedForContact,
        "created_by": createdBy?.toJson(),
        "ride_status": rideStatus,
        "pickup_details": pickupDetails?.toJson(),
        "trip_details": tripDetails?.toJson(),
        "trip_sequence": tripSequence == null
            ? []
            : List<dynamic>.from(tripSequence!.map((x) => x.toJson())),
        "ride_route": rideRoute,
        "price": price?.toJson(),
        "route": route == null ? [] : List<dynamic>.from(route!.map((x) => x)),
        "ride_vehicle": rideVehicle,
        "ride_type": rideType,
        "trips_near_dropoff": tripsNearDropoff,
        "stays_at": staysAt,
        "no_of_adults": noOfAdults,
        "no_of_kids": noOfKids,
        "tour_duration": tourDuration,
        "ride_aval": rideAval,
        "ride_aval_time": rideAvalTime,
        "vehicle_type": vehicleType,
        "ride_feature": rideFeature,
        "travel_mode": travelMode,
        "user": user?.toJson(),
        "payment": payment?.toJson(),
        "user_message": userMessage,
        "cancel_ride": cancelRide,
      };
}

class CreatedBy {
  String? name;
  String? subText;
  String? promoUrl;

  CreatedBy({
    this.name,
    this.subText,
    this.promoUrl,
  });

  factory CreatedBy.fromJson(Map<String, dynamic> json) => CreatedBy(
        name: json["name"],
        subText: json["sub_text"],
        promoUrl: json["promo_url"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "sub_text": subText,
        "promo_url": promoUrl,
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

class OntripRideDriverDetails {
  String? travelMode;
  int? userId;
  String? deviceToken;
  int? lpId;
  dynamic firstName;
  String? vehicleNumber;
  String? vehicleName;
  String? vehicleModel;
  String? phoneNumber;

  OntripRideDriverDetails({
    this.travelMode,
    this.userId,
    this.deviceToken,
    this.lpId,
    this.firstName,
    this.vehicleNumber,
    this.vehicleName,
    this.vehicleModel,
    this.phoneNumber,
  });

  factory OntripRideDriverDetails.fromJson(Map<String, dynamic> json) =>
      OntripRideDriverDetails(
        travelMode: json["travel_mode"],
        userId: json["user_id"],
        deviceToken: json["device_token"],
        lpId: json["lp_id"],
        firstName: json["first_name"],
        vehicleNumber: json["vehicle_number"],
        vehicleName: json["vehicle_name"],
        vehicleModel: json["vehicle_model"],
        phoneNumber: json["phone_number"],
      );

  Map<String, dynamic> toJson() => {
        "travel_mode": travelMode,
        "user_id": userId,
        "device_token": deviceToken,
        "lp_id": lpId,
        "first_name": firstName,
        "vehicle_number": vehicleNumber,
        "vehicle_name": vehicleName,
        "vehicle_model": vehicleModel,
        "phone_number": phoneNumber,
      };
}

class Payment {
  String? mode;
  String? currency;
  String? status;
  String? amount;

  Payment({
    this.mode,
    this.currency,
    this.status,
    this.amount,
  });

  factory Payment.fromJson(Map<String, dynamic> json) => Payment(
        mode: json["mode"],
        currency: json["currency"],
        status: json["status"],
        amount: json["amount"],
      );

  Map<String, dynamic> toJson() => {
        "mode": mode,
        "currency": currency,
        "status": status,
        "amount": amount,
      };
}

class PickupDetails {
  String? distance;
  String? distanceUnit;
  String? duration;
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
  String? currency;
  String? pricePerUnit;
  String? priceText;
  String? totalPrice;

  Price({
    this.id,
    this.currency,
    this.pricePerUnit,
    this.priceText,
    this.totalPrice,
  });

  factory Price.fromJson(Map<String, dynamic> json) => Price(
        id: json["id"],
        currency: json["currency"],
        pricePerUnit: json["price_per_unit"],
        priceText: json["price_text"],
        totalPrice: json["total_price"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "currency": currency,
        "price_per_unit": pricePerUnit,
        "price_text": priceText,
        "total_price": totalPrice,
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
  String? place;
  DriverPosition position;
  String? notes;
  String? firstName;
  String? lastName;
  String? countryCode;
  String? phoneNumber;
  String? pickupTime;
  String? dropoffTime;

  TripSequence({
    this.type,
    this.address,
    this.place,
    required this.position,
    this.notes,
    this.firstName,
    this.lastName,
    this.countryCode,
    this.phoneNumber,
    this.pickupTime,
    this.dropoffTime,
  });

  factory TripSequence.fromJson(Map<String, dynamic> json) => TripSequence(
        type: json["type"],
        address: json["address"],
        place: json["place"],
        position: DriverPosition.fromJson(json["position"]),
        notes: json["notes"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        countryCode: json["country_code"],
        phoneNumber: json["phone_number"],
        pickupTime: json["pickup_time"],
        dropoffTime: json["dropoff_time"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "address": address,
        "place": place,
        "position": position?.toJson(),
        "notes": notes,
        "first_name": firstName,
        "last_name": lastName,
        "country_code": countryCode,
        "phone_number": phoneNumber,
        "pickup_time": pickupTime,
        "dropoff_time": dropoffTime,
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

class UpcomingRide {
  String? tripId;
  String? rideId;
  Driver driver;
  Promo? promo;
  String? bookedBy;
  String? bookedByContact;
  String? bookedFor;
  String? bookedForContact;
  CreatedBy? createdBy;
  String? rideStatus;
  PickupDetails? pickupDetails;
  TripDetails? tripDetails;
  UpcomingRideDriverDetails? driverDetails;
  List<TripSequence>? tripSequence;
  String? rideRoute;
  Price? price;
  List<dynamic>? route;
  String? rideVehicle;
  String? rideType;
  String? tripsNearDropoff;
  bool? rideAval;
  String? rideAvalTime;
  String? vehicleType;
  String? rideFeature;
  String? travelMode;
  User? user;
  Payment? payment;
  bool? cancelRide;
  String? userMessage;

  UpcomingRide({
    this.tripId,
    this.rideId,
    required this.driver,
    this.promo,
    this.bookedBy,
    this.bookedByContact,
    this.bookedFor,
    this.bookedForContact,
    this.createdBy,
    this.rideStatus,
    this.pickupDetails,
    this.tripDetails,
    this.driverDetails,
    this.tripSequence,
    this.rideRoute,
    this.price,
    this.route,
    this.rideVehicle,
    this.rideType,
    this.tripsNearDropoff,
    this.rideAval,
    this.rideAvalTime,
    this.vehicleType,
    this.rideFeature,
    this.travelMode,
    this.user,
    this.payment,
    this.cancelRide,
    this.userMessage,
  });

  factory UpcomingRide.fromJson(Map<String, dynamic> json) => UpcomingRide(
        tripId: json["trip_id"],
        userMessage: json["user_message"],
        rideId: json["ride_id"],
        driver: Driver.fromJson(json["driver"]),
        promo: json["promo"] == null ? null : Promo.fromJson(json["promo"]),
        bookedBy: json["booked_by"],
        bookedByContact: json["booked_by_contact"],
        bookedFor: json["booked_for"],
        bookedForContact: json["booked_for_contact"],
        createdBy: json["created_by"] == null
            ? null
            : CreatedBy.fromJson(json["created_by"]),
        rideStatus: json["ride_status"],
        pickupDetails: json["pickup_details"] == null
            ? null
            : PickupDetails.fromJson(json["pickup_details"]),
        tripDetails: json["trip_details"] == null
            ? null
            : TripDetails.fromJson(json["trip_details"]),
        driverDetails: json["driver_details"] == null
            ? null
            : UpcomingRideDriverDetails.fromJson(json["driver_details"]),
        tripSequence: json["trip_sequence"] == null
            ? []
            : List<TripSequence>.from(
                json["trip_sequence"]!.map((x) => TripSequence.fromJson(x))),
        rideRoute: json["ride_route"],
        price: json["price"] == null ? null : Price.fromJson(json["price"]),
        route: json["route"] == null
            ? []
            : List<dynamic>.from(json["route"]!.map((x) => x)),
        rideVehicle: json["ride_vehicle"],
        rideType: json["ride_type"],
        tripsNearDropoff: json["trips_near_dropoff"],
        rideAval: json["ride_aval"],
        rideAvalTime: json["ride_aval_time"],
        vehicleType: json["vehicle_type"],
        rideFeature: json["ride_feature"],
        travelMode: json["travel_mode"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        payment:
            json["payment"] == null ? null : Payment.fromJson(json["payment"]),
        cancelRide: json["cancel_ride"],
      );

  Map<String, dynamic> toJson() => {
        "trip_id": tripId,
        "ride_id": rideId,
        "user_message": userMessage,
        "driver": driver?.toJson(),
        "promo": promo?.toJson(),
        "booked_by": bookedBy,
        "booked_by_contact": bookedByContact,
        "booked_for": bookedFor,
        "booked_for_contact": bookedForContact,
        "created_by": createdBy?.toJson(),
        "ride_status": rideStatus,
        "pickup_details": pickupDetails?.toJson(),
        "trip_details": tripDetails?.toJson(),
        "driver_details": driverDetails?.toJson(),
        "trip_sequence": tripSequence == null
            ? []
            : List<dynamic>.from(tripSequence!.map((x) => x.toJson())),
        "ride_route": rideRoute,
        "price": price?.toJson(),
        "route": route == null ? [] : List<dynamic>.from(route!.map((x) => x)),
        "ride_vehicle": rideVehicle,
        "ride_type": rideType,
        "trips_near_dropoff": tripsNearDropoff,
        "ride_aval": rideAval,
        "ride_aval_time": rideAvalTime,
        "vehicle_type": vehicleType,
        "ride_feature": rideFeature,
        "travel_mode": travelMode,
        "user": user?.toJson(),
        "payment": payment?.toJson(),
        "cancel_ride": cancelRide,
      };
}

class UpcomingRideDriverDetails {
  int? userId;
  String? deviceToken;
  int? lpId;
  dynamic firstName;
  String? vehicleNumber;
  String? vehicleName;
  String? vehicleModel;
  String? phoneNumber;

  UpcomingRideDriverDetails({
    this.userId,
    this.deviceToken,
    this.lpId,
    this.firstName,
    this.vehicleNumber,
    this.vehicleName,
    this.vehicleModel,
    this.phoneNumber,
  });

  factory UpcomingRideDriverDetails.fromJson(Map<String, dynamic> json) =>
      UpcomingRideDriverDetails(
        userId: json["user_id"],
        deviceToken: json["device_token"],
        lpId: json["lp_id"],
        firstName: json["first_name"],
        vehicleNumber: json["vehicle_number"],
        vehicleName: json["vehicle_name"],
        vehicleModel: json["vehicle_model"],
        phoneNumber: json["phone_number"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "device_token": deviceToken,
        "lp_id": lpId,
        "first_name": firstName,
        "vehicle_number": vehicleNumber,
        "vehicle_name": vehicleName,
        "vehicle_model": vehicleModel,
        "phone_number": phoneNumber,
      };
}
