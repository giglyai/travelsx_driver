// To parse this JSON data, do
//
//     final vehicleInformationList = vehicleInformationListFromJson(jsonString);

import 'dart:convert';

VehicleInformationList vehicleInformationListFromJson(String str) => VehicleInformationList.fromJson(json.decode(str));

String vehicleInformationListToJson(VehicleInformationList data) => json.encode(data.toJson());

class VehicleInformationList {
  String? status;
  Data? data;

  VehicleInformationList({
    this.status,
    this.data,
  });

  factory VehicleInformationList.fromJson(Map<String, dynamic> json) => VehicleInformationList(
    status: json["status"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data?.toJson(),
  };
}

class Data {
  List<String>? vehicleCompany;
  List<String>? vehicleModel;
  String? vehicleNumber;
  String? licenceNumber;

  Data({
    this.vehicleCompany,
    this.vehicleModel,
    this.vehicleNumber,
    this.licenceNumber,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    vehicleCompany: json["vehicle_company"] == null ? [] : List<String>.from(json["vehicle_company"]!.map((x) => x)),
    vehicleModel: json["vehicle_model"] == null ? [] : List<String>.from(json["vehicle_model"]!.map((x) => x)),
    vehicleNumber: json["vehicle_number"],
    licenceNumber: json["licence_number"],
  );

  Map<String, dynamic> toJson() => {
    "vehicle_company": vehicleCompany == null ? [] : List<dynamic>.from(vehicleCompany!.map((x) => x)),
    "vehicle_model": vehicleModel == null ? [] : List<dynamic>.from(vehicleModel!.map((x) => x)),
    "vehicle_number": vehicleNumber,
    "licence_number": licenceNumber,
  };
}
