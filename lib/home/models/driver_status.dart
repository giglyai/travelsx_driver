// To parse this JSON data, do
//
//     final getDriverStatus = getDriverStatusFromJson(jsonString);

import 'dart:convert';

GetDriverStatus getDriverStatusFromJson(String str) =>
    GetDriverStatus.fromJson(json.decode(str));

String getDriverStatusToJson(GetDriverStatus data) =>
    json.encode(data.toJson());

class GetDriverStatus {
  String? status;
  Data? data;

  GetDriverStatus({
    this.status,
    this.data,
  });

  factory GetDriverStatus.fromJson(Map<String, dynamic> json) =>
      GetDriverStatus(
        status: json["status"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data?.toJson(),
      };
}

class Data {
  int? findTripsEverySec;
  int? updateTripEverySec;
  String? profile;

  Data({
    this.findTripsEverySec,
    this.updateTripEverySec,
    this.profile,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        findTripsEverySec: json["find_trips_every_sec"],
        updateTripEverySec: json["update_trip_every_sec"],
        profile: json["profile"],
      );

  Map<String, dynamic> toJson() => {
        "find_trips_every_sec": findTripsEverySec,
        "update_trip_every_sec": updateTripEverySec,
        "profile": profile,
      };
}
