import 'dart:convert';

PromotionModel promotionModelFromJson(String str) =>
    PromotionModel.fromJson(json.decode(str));

String promotionModelToJson(PromotionModel data) => json.encode(data.toJson());

class PromotionModel {
  String? status;
  List<Datum>? data;

  PromotionModel({
    this.status,
    this.data,
  });

  factory PromotionModel.fromJson(Map<String, dynamic> json) => PromotionModel(
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
        totalDelivery: json["total_delivery"],
        completedDelivery: json["completed_delivery"],
        daysLeftMsg: json["days_left_msg"],
        deliveryCompletedMsg: json["delivery_completed_msg"],
      );

  Map<String, dynamic> toJson() => {
        "value": value,
        "title": title,
        "name": name,
        "location": location,
        "description": description,
        "total_delivery": totalDelivery,
        "completed_delivery": completedDelivery,
        "days_left_msg": daysLeftMsg,
        "delivery_completed_msg": deliveryCompletedMsg,
      };
}
