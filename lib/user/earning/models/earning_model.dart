// To parse this JSON data, do
//
//     final earningModel = earningModelFromJson(jsonString);

import 'dart:convert';

EarningModel earningModelFromJson(String str) =>
    EarningModel.fromJson(json.decode(str));

String earningModelToJson(EarningModel data) => json.encode(data.toJson());

class EarningModel {
  String? status;
  Data? data;

  EarningModel({this.status, this.data});

  factory EarningModel.fromJson(Map<String, dynamic> json) => EarningModel(
    status: json["status"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {"status": status, "data": data?.toJson()};
}

class Data {
  Metrics? metrics;
  List<List<Activity>>? activities;

  Data({this.metrics, this.activities});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    metrics: json["metrics"] == null ? null : Metrics.fromJson(json["metrics"]),
    activities:
        json["activities"] == null
            ? []
            : List<List<Activity>>.from(
              json["activities"]!.map(
                (x) => List<Activity>.from(x.map((x) => Activity.fromJson(x))),
              ),
            ),
  );

  Map<String, dynamic> toJson() => {
    "metrics": metrics?.toJson(),
    "activities":
        activities == null
            ? []
            : List<dynamic>.from(
              activities!.map(
                (x) => List<dynamic>.from(x.map((x) => x.toJson())),
              ),
            ),
  };
}

class Activity {
  String? text;
  String? amount;
  String? currency;
  String? deliveryAddr;
  String? dlvyTime;

  Activity({
    this.text,
    this.amount,
    this.currency,
    this.deliveryAddr,
    this.dlvyTime,
  });

  factory Activity.fromJson(Map<String, dynamic> json) => Activity(
    text: json["text"],
    amount: json["amount"],
    currency: json["currency"],
    deliveryAddr: json["delivery_addr"],
    dlvyTime: json["dlvy_time"],
  );

  Map<String, dynamic> toJson() => {
    "text": text,
    "amount": amount,
    "currency": currency,
    "delivery_addr": deliveryAddr,
    "dlvy_time": dlvyTime,
  };
}

class Metrics {
  Breakdown? breakdown;

  Metrics({this.breakdown});

  factory Metrics.fromJson(Map<String, dynamic> json) => Metrics(
    breakdown:
        json["breakdown"] == null
            ? null
            : Breakdown.fromJson(json["breakdown"]),
  );

  Map<String, dynamic> toJson() => {"breakdown": breakdown?.toJson()};
}

class Breakdown {
  int? totalAmount;
  String? currency;
  int? totalRides;

  Breakdown({this.totalAmount, this.currency, this.totalRides});

  factory Breakdown.fromJson(Map<String, dynamic> json) => Breakdown(
    totalAmount: json["total_amount"],
    currency: json["currency"],
    totalRides: json["total_rides"],
  );

  Map<String, dynamic> toJson() => {
    "total_amount": totalAmount,
    "currency": currency,
    "total_rides": totalRides,
  };
}
