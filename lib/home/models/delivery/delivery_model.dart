// // To parse this JSON data, do
// //
// //     final deliveryModel = deliveryModelFromJson(jsonString);
//
// import 'dart:convert';
//
// import 'package:travelx_driver/home/models/position_data_model.dart';
//
// List<DeliveryModel> deliveryModelFromJson(List jsonData) =>
//     List<DeliveryModel>.from(jsonData.map((x) => DeliveryModel.fromJson(x)));
//
// String deliveryModelToJson(List<DeliveryModel> data) =>
//     json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
//
// class DeliveryModel {
//   String? tripId;
//   String? deliveryId;
//   Driver driver;
//   Promo? promo;
//   PDetails? pickupDetails;
//   PDetails? tripDetails;
//   List<TripSequence> tripSequence;
//   Price? price;
//   List<Route>? route;
//   String? tripsNearDropoff;
//
//   DeliveryModel({
//     this.tripId,
//     this.deliveryId,
//     required this.driver,
//     this.promo,
//     this.pickupDetails,
//     this.tripDetails,
//     required this.tripSequence,
//     this.price,
//     this.route,
//     this.tripsNearDropoff,
//   });
//
//   factory DeliveryModel.fromJson(Map<String, dynamic> json) => DeliveryModel(
//         tripId: json["trip_id"],
//         deliveryId: json["delivery_id"],
//         driver: Driver.fromJson(json["driver"]),
//         promo: json["promo"] == null ? null : Promo.fromJson(json["promo"]),
//         pickupDetails: json["pickup_details"] == null
//             ? null
//             : PDetails.fromJson(json["pickup_details"]),
//         tripDetails: json["trip_details"] == null
//             ? null
//             : PDetails.fromJson(json["trip_details"]),
//         tripSequence: json["trip_sequence"] == null
//             ? []
//             : List<TripSequence>.from(
//                 json["trip_sequence"]!.map((x) => TripSequence.fromJson(x))),
//         price: json["price"] == null ? null : Price.fromJson(json["price"]),
//         route: json["route"] == null
//             ? []
//             : List<Route>.from(json["route"]!.map((x) => Route.fromJson(x))),
//         tripsNearDropoff: json["trips_near_dropoff"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "trip_id": tripId,
//         "delivery_id": deliveryId,
//         "driver": driver.toJson(),
//         "promo": promo?.toJson(),
//         "pickup_details": pickupDetails?.toJson(),
//         "trip_details": tripDetails?.toJson(),
//         "trip_sequence":
//             List<dynamic>.from(tripSequence.map((x) => x.toJson())),
//         "price": price?.toJson(),
//         "route": route == null
//             ? []
//             : List<dynamic>.from(route!.map((x) => x.toJson())),
//         "trips_near_dropoff": tripsNearDropoff,
//       };
// }
//
// class Driver {
//   DriverPosition position;
//
//   Driver({
//     required this.position,
//   });
//
//   factory Driver.fromJson(Map<String, dynamic> json) => Driver(
//         position: DriverPosition.fromJson(json["position"]),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "position": position.toJson(),
//       };
// }
//
// class Position {
//   double latitude;
//   double longitude;
//
//   Position({
//     required this.latitude,
//     required this.longitude,
//   });
//
//   factory Position.fromJson(Map<String, dynamic> json) => Position(
//         latitude: json["latitude"].toDouble(),
//         longitude: json["longitude"].toDouble(),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "latitude": latitude,
//         "longitude": longitude,
//       };
// }
//
// class PDetails {
//   String? distance;
//   String? distanceUnit;
//   String? duration;
//   String? durationUnit;
//
//   PDetails({
//     this.distance,
//     this.distanceUnit,
//     this.duration,
//     this.durationUnit,
//   });
//
//   factory PDetails.fromJson(Map<String, dynamic> json) => PDetails(
//         distance: json["distance"],
//         distanceUnit: json["distanceUnit"],
//         duration: json["duration"],
//         durationUnit: json["durationUnit"],
//       );
//
//   get noOfTolls => null;
//
//   Map<String, dynamic> toJson() => {
//         "distance": distance,
//         "distanceUnit": distanceUnit,
//         "duration": duration,
//         "durationUnit": durationUnit,
//       };
// }
//
// class Price {
//   String? id;
//   String? pricePerUnit;
//   String? currency;
//   String? totalPrice;
//   String? priceText;
//
//   Price({
//     this.id,
//     this.pricePerUnit,
//     this.currency,
//     this.totalPrice,
//     this.priceText,
//   });
//
//   factory Price.fromJson(Map<String, dynamic> json) => Price(
//         id: json["id"],
//         pricePerUnit: json["price_per_unit"],
//         currency: json["currency"],
//         totalPrice: json["total_price"],
//         priceText: json["price_text"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "price_per_unit": pricePerUnit,
//         "currency": currency,
//         "total_price": totalPrice,
//         "price_text": priceText,
//       };
// }
//
// class Promo {
//   String? promoHead;
//   String? promoText;
//   String? promoUrl;
//
//   Promo({
//     this.promoHead,
//     this.promoText,
//     this.promoUrl,
//   });
//
//   factory Promo.fromJson(Map<String, dynamic> json) => Promo(
//         promoHead: json["promo_head"],
//         promoText: json["promo_text"],
//         promoUrl: json["promo_url"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "promo_head": promoHead,
//         "promo_text": promoText,
//         "promo_url": promoUrl,
//       };
// }
//
// class Route {
//   String? type;
//   String? routePath;
//
//   Route({
//     this.type,
//     this.routePath,
//   });
//
//   factory Route.fromJson(Map<String, dynamic> json) => Route(
//         type: json["type"],
//         routePath: json["route_path"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "type": type,
//         "route_path": routePath,
//       };
// }
//
// class TripSequence {
//   String? type;
//   String? address;
//   DriverPosition position;
//   String? name;
//   String? notes;
//   String? phoneNumber;
//   String? pickupTime;
//   Order? order;
//   String? dropoffTime;
//
//   TripSequence({
//     this.type,
//     this.address,
//     required this.position,
//     this.name,
//     this.notes,
//     this.phoneNumber,
//     this.pickupTime,
//     this.order,
//     this.dropoffTime,
//   });
//
//   factory TripSequence.fromJson(Map<String, dynamic> json) => TripSequence(
//         type: json["type"],
//         address: json["address"],
//         position: DriverPosition.fromJson(json["position"]),
//         name: json["name"],
//         notes: json["notes"],
//         phoneNumber: json["phone_number"],
//         pickupTime: json["pickup_time"],
//         order: json["order"] == null ? null : Order.fromJson(json["order"]),
//         dropoffTime: json["dropoff_time"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "type": type,
//         "address": address,
//         "position": position.toJson(),
//         "name": name,
//         "notes": notes,
//         "phone_number": phoneNumber,
//         "pickup_time": pickupTime,
//         "order": order?.toJson(),
//         "dropoff_time": dropoffTime,
//       };
// }
//
// class Order {
//   String? deliveryType;
//   String? packageType;
//   String? deliveryId;
//   String? orderId;
//   List<Item>? items;
//
//   Order({
//     this.deliveryType,
//     this.packageType,
//     this.deliveryId,
//     this.orderId,
//     this.items,
//   });
//
//   factory Order.fromJson(Map<String, dynamic> json) => Order(
//         deliveryType: json["delivery_type"],
//         packageType: json["package_type"],
//         deliveryId: json["delivery_id"],
//         orderId: json["order_id"],
//         items: json["items"] == null
//             ? []
//             : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "delivery_type": deliveryType,
//         "package_type": packageType,
//         "delivery_id": deliveryId,
//         "order_id": orderId,
//         "items": items == null
//             ? []
//             : List<dynamic>.from(items!.map((x) => x.toJson())),
//       };
// }
//
// class Item {
//   String? name;
//   String? quantity;
//
//   Item({
//     this.name,
//     this.quantity,
//   });
//
//   factory Item.fromJson(Map<String, dynamic> json) => Item(
//         name: json["name"],
//         quantity: json["quantity"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "name": name,
//         "quantity": quantity,
//       };
// }
