// To parse this JSON data, do
//
//     final subscriptionRes = subscriptionResFromJson(jsonString);

import 'dart:convert';

SubscriptionRes subscriptionResFromJson(String str) => SubscriptionRes.fromJson(json.decode(str));

String subscriptionResToJson(SubscriptionRes data) => json.encode(data.toJson());

class SubscriptionRes {
    String status;
    List<Datum> data;

    SubscriptionRes({
        required this.status,
        required this.data,
    });

    factory SubscriptionRes.fromJson(Map<String, dynamic> json) => SubscriptionRes(
        status: json["status"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
    int totalRides;
    String subPlan;
    int price;
    String subName;
    String currency;
    String subType;
    List<String> features;

    Datum({
        required this.totalRides,
        required this.subPlan,
        required this.price,
        required this.subName,
        required this.currency,
        required this.subType,
        required this.features,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        totalRides: json["total_rides"],
        subPlan: json["sub_plan"],
        price: json["price"],
        subName: json["sub_name"],
        currency: json["currency"],
        subType: json["sub_type"],
        features: List<String>.from(json["features"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "total_rides": totalRides,
        "sub_plan": subPlan,
        "price": price,
        "sub_name": subName,
        "currency": currency,
        "sub_type": subType,
        "features": List<dynamic>.from(features.map((x) => x)),
    };
}
