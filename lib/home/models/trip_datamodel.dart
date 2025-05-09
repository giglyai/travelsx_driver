import 'dart:convert';

import 'package:travelx_driver/home/models/position_data_model.dart';

List<Trip> tripsFromJson(List jsonData) =>
    List<Trip>.from(jsonData.map((x) => Trip.fromJson(x)));

String tripsToJson(List<Trip> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Trip {
  Trip(
      {this.tripId,
      this.driver,
      this.tripSequence,
      this.distanceTime,
      this.price,
      this.routePath,
      this.tripsNearDropoff});

  final String? tripId;
  final DriverData? driver;
  final List<TripSequence>? tripSequence;
  final DistanceTime? distanceTime;
  final Price? price;
  final List<RoutePath>? routePath;
  final String? tripsNearDropoff;

  factory Trip.fromJson(Map<String, dynamic> json) => Trip(
        tripId: json['tripId'],
        driver:
            json["driver"] == null ? null : DriverData.fromJson(json["driver"]),
        tripSequence: json["trip_sequence"] == null
            ? []
            : List<TripSequence>.from(
                json["trip_sequence"]!.map((x) => TripSequence.fromJson(x))),
        distanceTime: json["distance_time"] == null
            ? null
            : DistanceTime.fromJson(json["distance_time"]),
        price: json["price"] == null ? null : Price.fromJson(json["price"]),
        routePath: json["route"] == null
            ? []
            : List<RoutePath>.from(
                json["route"]!.map((x) => RoutePath.fromJson(x))),
        tripsNearDropoff: json["trips_near_dropoff"],
      );

  Map<String, dynamic> toJson() => {
        "driver": driver?.toJson(),
        "trip_sequence": tripSequence == null
            ? []
            : List<dynamic>.from(tripSequence!.map((x) => x.toJson())),
        "distance_time": distanceTime?.toJson(),
        "price": price?.toJson(),
        "route_path": routePath == null
            ? []
            : List<dynamic>.from(routePath!.map((x) => x.toJson())),
        "trips_near_dropoff": tripsNearDropoff,
      };
}

class DistanceTime {
  DistanceTime({
    this.driverToPickup,
    this.pickupToDropoff,
  });

  final DriverToPickup? driverToPickup;
  final DriverToPickup? pickupToDropoff;

  factory DistanceTime.fromJson(Map<String, dynamic> json) => DistanceTime(
        driverToPickup: json["driver_to_pickup"] == null
            ? null
            : DriverToPickup.fromJson(json["driver_to_pickup"]),
        pickupToDropoff: json["pickup_to_dropoff"] == null
            ? null
            : DriverToPickup.fromJson(json["pickup_to_dropoff"]),
      );

  Map<String, dynamic> toJson() => {
        "driver_to_pickup": driverToPickup?.toJson(),
        "pickup_to_dropoff": pickupToDropoff?.toJson(),
      };
}

class DriverToPickup {
  DriverToPickup({
    this.distance,
    this.distanceUnit,
    this.duration,
    this.durationUnit,
  });

  final double? distance;
  final String? distanceUnit;
  final double? duration;
  final String? durationUnit;

  factory DriverToPickup.fromJson(Map<String, dynamic> json) => DriverToPickup(
        distance: json["distance"]?.toDouble(),
        distanceUnit: json["distanceUnit"],
        duration: json["duration"]?.toDouble(),
        durationUnit: json["durationUnit"],
      );

  Map<String, dynamic> toJson() => {
        "distance": distance,
        "distanceUnit": distanceUnit,
        "duration": duration,
        "durationUnit": durationUnit,
      };
}

class DriverData {
  DriverData({
    this.position,
  });

  final DriverPosition? position;

  factory DriverData.fromJson(Map<String, dynamic> json) => DriverData(
        position: json["position"] == null
            ? null
            : DriverPosition.fromJson(json["position"]),
      );

  Map<String, dynamic> toJson() => {
        "position": position?.toJson(),
      };
}

class Price {
  Price({
    this.id,
    this.pricePerMile,
    this.pricePerMin,
    this.currency,
    this.totalPrice,
    this.promo,
    this.tips,
    this.breakups,
  });
  final String? id;
  final double? pricePerMile;
  final double? pricePerMin;
  final String? currency;
  final double? totalPrice;

  final String? promo;
  final String? tips;

  final Breakups? breakups;

  factory Price.fromJson(Map<String, dynamic> json) => Price(
        id: json['id'],
        pricePerMile: double.tryParse(json["price_per_mile"].toString()),
        pricePerMin: double.tryParse(json["price_per_min"].toString()),
        currency: json["currency"],
        totalPrice: double.tryParse(json["total_price"].toString()),
        promo: json["promo"],
        tips: json["tips"],
        breakups: json["breakups"] == null
            ? null
            : Breakups.fromJson(json["breakups"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "price_per_mile": pricePerMile,
        "price_per_min": pricePerMin,
        "currency": currency,
        "promo": promo,
        "tips": tips,
        "total_price": totalPrice,
        "breakups": breakups?.toJson(),
      };
}

class Breakups {
  Breakups({
    this.basePrice,
    this.tips,
    this.surge,
    this.promotion,
  });

  final double? basePrice;
  final double? tips;
  final int? surge;
  final double? promotion;

  factory Breakups.fromJson(Map<String, dynamic> json) => Breakups(
        basePrice: double.tryParse(json["base_price"].toString()),
        tips: double.tryParse(json["tips"].toString()),
        surge: json["surge"],
        promotion: double.tryParse(json["promotion"].toString()),
      );

  Map<String, dynamic> toJson() => {
        "base_price": basePrice,
        "tips": tips,
        "surge": surge,
        "promotion": promotion,
      };
}

class RoutePath {
  RoutePath({
    this.type,
    this.routePath,
  });

  final String? type;
  final String? routePath;

  factory RoutePath.fromJson(Map<String, dynamic> json) => RoutePath(
        type: json["type"],
        routePath: json["route_path"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "route_path": routePath,
      };
}

class TripSequence {
  TripSequence(
      {this.type,
      this.address,
      this.position,
      this.name,
      this.notes,
      this.order,
      this.phoneNumber,
      this.deliveryOpt,
      this.tenantUrl});

  final String? type;
  final String? address;
  final DriverPosition? position;
  final String? name;
  final String? notes;
  final Order? order;
  final String? phoneNumber;
  List<String>? tenantUrl;

  final DeliveryOpt? deliveryOpt;

  factory TripSequence.fromJson(Map<String, dynamic> json) => TripSequence(
        type: json["type"],
        address: json["address"],
        position: json["position"] == null
            ? null
            : DriverPosition.fromJson(json["position"]),
        name: json["name"],
        notes: json["notes"],
        order: json["order"] == null ? null : Order.fromJson(json["order"]),
        phoneNumber: json["phone_number"],
        tenantUrl: json["tenant_url"] == null
            ? []
            : List<String>.from(json["tenant_url"]!.map((x) => x)),
        deliveryOpt: json["delivery_opt"] == null
            ? null
            : DeliveryOpt.fromJson(json["delivery_opt"]),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "address": address,
        "position": position?.toJson(),
        "name": name,
        "notes": notes,
        "order": order?.toJson(),
        "phone_number": phoneNumber,
        "tenant_url": tenantUrl == null
            ? []
            : List<dynamic>.from(tenantUrl!.map((x) => x)),
        "delivery_opt": deliveryOpt?.toJson(),
      };
}

class DeliveryOpt {
  DeliveryOpt({
    this.isContactlessDelivery,
    this.recipientIdRequired,
    this.signatureRequired,
    this.containsTobacco,
    this.containsAlcohol,
    this.undeliverableAction,
  });

  final String? isContactlessDelivery;
  final String? recipientIdRequired;
  final String? signatureRequired;
  final String? containsTobacco;
  final String? containsAlcohol;
  final String? undeliverableAction;

  factory DeliveryOpt.fromJson(Map<String, dynamic> json) => DeliveryOpt(
        isContactlessDelivery: json["is_contactless_delivery"],
        recipientIdRequired: json["recipient_id_required"],
        signatureRequired: json["signature_required"],
        containsTobacco: json["contains_tobacco"],
        containsAlcohol: json["contains_alcohol"],
        undeliverableAction: json["undeliverable_action"],
      );

  Map<String, dynamic> toJson() => {
        "is_contactless_delivery": isContactlessDelivery,
        "recipient_id_required": recipientIdRequired,
        "signature_required": signatureRequired,
        "contains_tobacco": containsTobacco,
        "contains_alcohol": containsAlcohol,
        "undeliverable_action": undeliverableAction,
      };
}

class Order {
  Order({
    this.tenantId,
    this.deliveryType,
    this.deliveryId,
    this.quoteId,
    this.items,
    this.orderId,
    this.storeId,
    this.tip,
    this.value,
    this.tenantUrl,
    this.deliveryBy,
  });

  final String? tenantId;
  final String? deliveryType;
  final String? deliveryId;
  final String? quoteId;
  final List<Item>? items;
  final String? orderId;
  final String? storeId;
  final String? tip;
  final String? value;
  final String? tenantUrl;
  final String? deliveryBy;

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        tenantId: json["tenant_id"],
        deliveryType: json["delivery_type"],
        deliveryId: json["delivery_id"],
        quoteId: json["quote_id"],
        items: json["items"] == null
            ? []
            : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
        orderId: json["order_id"],
        storeId: json["store_id"],
        tip: json["tip"],
        value: json["value"],
        tenantUrl: json["tenant_url"],
        deliveryBy: json["delivery_by"],
      );

  Map<String, dynamic> toJson() => {
        "tenant_id": tenantId,
        "delivery_type": deliveryType,
        "delivery_id": deliveryId,
        "quote_id": quoteId,
        "items": items == null
            ? []
            : List<dynamic>.from(items!.map((x) => x.toJson())),
        "order_id": orderId,
        "store_id": storeId,
        "tip": tip,
        "value": value,
        "tenant_url": tenantUrl,
        "delivery_by": deliveryBy,
      };
}

class Item {
  Item({
    this.name,
    this.quantity,
  });

  final String? name;
  final String? quantity;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        name: json["name"],
        quantity: json["quantity"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "quantity": quantity,
      };
}
