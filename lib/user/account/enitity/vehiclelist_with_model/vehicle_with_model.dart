// To parse this JSON data, do
//
//     final vehicleListModel = vehicleListModelFromJson(jsonString);

import 'dart:convert';

VehicleListModel vehicleListModelFromJson(String str) => VehicleListModel.fromJson(json.decode(str));

String vehicleListModelToJson(VehicleListModel data) => json.encode(data.toJson());

class VehicleListModel {
  String? status;
  List<VehicleData>? data;

  VehicleListModel({
    this.status,
    this.data,
  });

  factory VehicleListModel.fromJson(Map<String, dynamic> json) => VehicleListModel(
    status: json["status"],
    data: json["data"] == null ? [] : List<VehicleData>.from(json["data"]!.map((x) => VehicleData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class VehicleData {
  String? categotyName;
  List<String>? vehicleModels;

  VehicleData({
    this.categotyName,
    this.vehicleModels,
  });

  factory VehicleData.fromJson(Map<String, dynamic> json) => VehicleData(
    categotyName: json["categoty_name"],
    vehicleModels: json["vehicle_models"] == null ? [] : List<String>.from(json["vehicle_models"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "categoty_name": categotyName,
    "vehicle_models": vehicleModels == null ? [] : List<dynamic>.from(vehicleModels!.map((x) => x)),
  };
}
