// To parse this JSON data, do
//
//     final notificationsModel = notificationsModelFromJson(jsonString);

import 'dart:convert';

NotificationsModel notificationsModelFromJson(String str) =>
    NotificationsModel.fromJson(json.decode(str));

String notificationsModelToJson(NotificationsModel data) =>
    json.encode(data.toJson());

class NotificationsModel {
  String? status;
  List<Datum>? data;

  NotificationsModel({
    this.status,
    this.data,
  });

  factory NotificationsModel.fromJson(Map<String, dynamic> json) =>
      NotificationsModel(
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
  String? createdTime;
  int? createdUxTime;
  String? label;
  String? content;

  Datum({
    this.createdTime,
    this.createdUxTime,
    this.label,
    this.content,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        createdTime: json["created_time"],
        createdUxTime: json["created_ux_time"],
        label: json["label"],
        content: json["content"],
      );

  Map<String, dynamic> toJson() => {
        "created_time": createdTime,
        "created_ux_time": createdUxTime,
        "label": label,
        "content": content,
      };
}
