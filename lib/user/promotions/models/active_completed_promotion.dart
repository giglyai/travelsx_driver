// To parse this JSON data, do
//
//     final activeCompletedPromotion = activeCompletedPromotionFromJson(jsonString);

import 'dart:convert';

ActiveCompletedPromotion activeCompletedPromotionFromJson(String str) =>
    ActiveCompletedPromotion.fromJson(json.decode(str));

String activeCompletedPromotionToJson(ActiveCompletedPromotion data) =>
    json.encode(data.toJson());

class ActiveCompletedPromotion {
  String? status;
  List<Datum>? data;

  ActiveCompletedPromotion({
    this.status,
    this.data,
  });

  factory ActiveCompletedPromotion.fromJson(Map<String, dynamic> json) =>
      ActiveCompletedPromotion(
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  String? value;
  String? title;
  String? name;
  String? location;
  String? description;
  int? totalDelivery;
  int? completedDelivery;
  String? daysLeftMsg;
  String? deliveryCompletedMsg;

  Datum({
    this.value,
    this.title,
    this.name,
    this.location,
    this.description,
    this.totalDelivery,
    this.completedDelivery,
    this.daysLeftMsg,
    this.deliveryCompletedMsg,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        value: json["value"],
        title: json["title"],
        name: json["name"],
        location: json["location"],
        description: json["description"],
        totalDelivery: json["total_ride"],
        completedDelivery: json["completed_ride"],
        daysLeftMsg: json["days_left_msg"],
        deliveryCompletedMsg: json["ride_completed_msg"],
      );

  Map<String, dynamic> toJson() => {
        "value": value,
        "title": title,
        "name": name,
        "location": location,
        "description": description,
        "total_ride": totalDelivery,
        "completed_ride": completedDelivery,
        "days_left_msg": daysLeftMsg,
        "ride_completed_msg": deliveryCompletedMsg,
      };
}
