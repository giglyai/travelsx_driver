// To parse this JSON data, do
//
//     final getTravelVehicleListData = getTravelVehicleListDataFromJson(jsonString);

import 'dart:convert';

GetTravelVehicleListData getTravelVehicleListDataFromJson(String str) =>
    GetTravelVehicleListData.fromJson(json.decode(str));

String getTravelVehicleListDataToJson(GetTravelVehicleListData data) =>
    json.encode(data.toJson());

class GetTravelVehicleListData {
  String? status;
  Data? data;

  GetTravelVehicleListData({
    this.status,
    this.data,
  });

  factory GetTravelVehicleListData.fromJson(Map<String, dynamic> json) =>
      GetTravelVehicleListData(
        status: json["status"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data?.toJson(),
      };
}

class Data {
  int? totalVehicles;
  int? onlineVehicles;
  int? offlineVehicles;
  List<AllVehicle>? allVehicles;

  Data({
    this.totalVehicles,
    this.onlineVehicles,
    this.offlineVehicles,
    this.allVehicles,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        totalVehicles: json["total_vehicles"],
        onlineVehicles: json["online_vehicles"],
        offlineVehicles: json["offline_vehicles"],
        allVehicles: json["all_vehicles"] == null
            ? []
            : List<AllVehicle>.from(
                json["all_vehicles"]!.map((x) => AllVehicle.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "total_vehicles": totalVehicles,
        "online_vehicles": onlineVehicles,
        "offline_vehicles": offlineVehicles,
        "all_vehicles": allVehicles == null
            ? []
            : List<dynamic>.from(allVehicles!.map((x) => x.toJson())),
      };
}

class AllVehicle {
  String? name;
  String? deviceToken;
  String? countryCode;
  String? phoneNumber;
  String? vehicleModel;
  String? vehicleType;
  String? vehicleNumber;
  String? location;
  int? lpId;
  int? userId;
  int? indexId;
  String? key;
  int? latitude;
  int? longitude;
  bool? online;

  AllVehicle({
    this.name,
    this.deviceToken,
    this.countryCode,
    this.phoneNumber,
    this.vehicleModel,
    this.vehicleType,
    this.vehicleNumber,
    this.location,
    this.lpId,
    this.userId,
    this.indexId,
    this.key,
    this.latitude,
    this.longitude,
    this.online,
  });

  factory AllVehicle.fromJson(Map<String, dynamic> json) => AllVehicle(
        name: json["name"],
        deviceToken: json["device_token"],
        countryCode: json["country_code"],
        phoneNumber: json["phone_number"],
        vehicleModel: json["vehicle_model"],
        vehicleType: json["vehicle_type"],
        vehicleNumber: json["vehicle_number"],
        location: json["location"],
        lpId: json["lp_id"],
        userId: json["user_id"],
        indexId: json["index_id"],
        key: json["key"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        online: json["online"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "device_token": deviceToken,
        "country_code": countryCode,
        "phone_number": phoneNumber,
        "vehicle_model": vehicleModel,
        "vehicle_type": vehicleType,
        "vehicle_number": vehicleNumber,
        "location": location,
        "lp_id": lpId,
        "user_id": userId,
        "index_id": indexId,
        "key": key,
        "latitude": latitude,
        "longitude": longitude,
        "online": online,
      };
}
