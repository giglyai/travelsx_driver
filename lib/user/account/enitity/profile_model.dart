// To parse this JSON data, do
//
//     final getUserProfileData = getUserProfileDataFromJson(jsonString);

import 'dart:convert';

GetUserProfileData getUserProfileDataFromJson(String str) =>
    GetUserProfileData.fromJson(json.decode(str));

String getUserProfileDataToJson(GetUserProfileData data) =>
    json.encode(data.toJson());

class GetUserProfileData {
  String? status;
  Data? data;

  GetUserProfileData({
    this.status,
    this.data,
  });

  factory GetUserProfileData.fromJson(Map<String, dynamic> json) =>
      GetUserProfileData(
        status: json["status"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data?.toJson(),
      };
}

class Data {
  int? lpId;
  int? userId;
  String? countryCode;
  String? phoneNumber;
  String? businessName;
  String? address;
  String? place;
  String? addressCoords;
  String? firstName;
  String? lastName;
  String? email;
  String? profileImage;
  String? accountStatus;
  String? accountRating;
  String? vehicleCompany;
  String? vehicleModel;
  String? vehicleName;
  String? vehicleType;
  String? vehicleNumber;
  String? licenceNumber;
  bool? activeDriver;
  String? userType;
  List<AgencyList>? agencyList;
  List<DocsType>? docsType;
  List<String>? missingDocs;
  bool? isSubscriped;
  bool? isActive;
  JoiningFee? joiningFee;

  Data({
    this.lpId,
    this.userId,
    this.countryCode,
    this.phoneNumber,
    this.businessName,
    this.address,
    this.place,
    this.addressCoords,
    this.firstName,
    this.lastName,
    this.email,
    this.profileImage,
    this.accountStatus,
    this.accountRating,
    this.vehicleCompany,
    this.vehicleModel,
    this.vehicleName,
    this.vehicleNumber,
    this.licenceNumber,
    this.activeDriver,
    this.userType,
    this.agencyList,
    this.docsType,
    this.isSubscriped,
    this.missingDocs,
    this.joiningFee,
    this.vehicleType,
    this.isActive,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        lpId: json["lp_id"],
        userId: json["user_id"],
        countryCode: json["country_code"],
        phoneNumber: json["phone_number"],
        businessName: json["business_name"],
        address: json["address"],
        place: json["place"],
        addressCoords: json["address_coords"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        profileImage: json["profile_image"],
        accountStatus: json["account_status"],
        accountRating: json["account_rating"],
        vehicleCompany: json["vehicle_company"],
        vehicleModel: json["vehicle_model"],
        vehicleName: json["vehicle_name"],
        vehicleNumber: json["vehicle_number"],
        licenceNumber: json["licence_number"],
        activeDriver: json["active_driver"],
        isActive: json["is_active"],
        userType: json["user_type"],
        vehicleType: json["vehicle_type"],
        agencyList: json["agency_list"] == null
            ? []
            : List<AgencyList>.from(
                json["agency_list"]!.map((x) => AgencyList.fromJson(x))),
        docsType: json["docsType"] == null
            ? []
            : List<DocsType>.from(
                json["docsType"]!.map((x) => DocsType.fromJson(x))),
        isSubscriped: json["is_subscriped"],
        missingDocs: json["missing_docs"] == null
            ? []
            : List<String>.from(json["missing_docs"]!.map((x) => x)),
        joiningFee: json["joining_fee"] == null
            ? null
            : JoiningFee.fromJson(json["joining_fee"]),
      );

  Map<String, dynamic> toJson() => {
        "lp_id": lpId,
        "user_id": userId,
        "country_code": countryCode,
        "phone_number": phoneNumber,
        "business_name": businessName,
        "address": address,
        "place": place,
        "address_coords": addressCoords,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "profile_image": profileImage,
        "account_status": accountStatus,
        "account_rating": accountRating,
        "vehicle_company": vehicleCompany,
        "vehicle_model": vehicleModel,
        "vehicle_name": vehicleName,
        "vehicle_number": vehicleNumber,
        "licence_number": licenceNumber,
        "active_driver": activeDriver,
        "user_type": userType,
        "vehicle_type": vehicleType,
        "agency_list": agencyList == null
            ? []
            : List<dynamic>.from(agencyList!.map((x) => x.toJson())),
        "docsType": docsType == null
            ? []
            : List<dynamic>.from(docsType!.map((x) => x.toJson())),
        "is_subscriped": isSubscriped,
        "missing_docs": missingDocs == null
            ? []
            : List<dynamic>.from(missingDocs!.map((x) => x)),
        "joining_fee": joiningFee?.toJson(),
        "is_active": isActive
      };
}

class AgencyList {
  String? place;
  String? businessName;
  double? latitude;
  int? userId;
  String? address;
  int? lpId;
  String? phoneNumber;
  double? longitude;

  AgencyList({
    this.place,
    this.businessName,
    this.latitude,
    this.userId,
    this.address,
    this.lpId,
    this.phoneNumber,
    this.longitude,
  });

  factory AgencyList.fromJson(Map<String, dynamic> json) => AgencyList(
        place: json["place"],
        businessName: json["business_name"],
        latitude: json["latitude"]?.toDouble(),
        userId: json["user_id"],
        address: json["address"],
        lpId: json["lp_id"],
        phoneNumber: json["phone_number"],
        longitude: json["longitude"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "place": place,
        "business_name": businessName,
        "latitude": latitude,
        "user_id": userId,
        "address": address,
        "lp_id": lpId,
        "phone_number": phoneNumber,
        "longitude": longitude,
      };
}

class DocsType {
  String? docType;
  List<String>? imageUrls;

  DocsType({
    this.docType,
    this.imageUrls,
  });

  factory DocsType.fromJson(Map<String, dynamic> json) => DocsType(
        docType: json["doc_type"],
        imageUrls: json["imageUrls"] == null
            ? []
            : List<String>.from(json["imageUrls"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "doc_type": docType,
        "imageUrls": imageUrls == null
            ? []
            : List<dynamic>.from(imageUrls!.map((x) => x)),
      };
}

class JoiningFee {
  String? status;
  int? amount;
  String? currency;

  JoiningFee({
    this.status,
    this.amount,
    this.currency,
  });

  factory JoiningFee.fromJson(Map<String, dynamic> json) => JoiningFee(
        status: json["status"],
        amount: json["amount"],
        currency: json["currency"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "amount": amount,
        "currency": currency,
      };
}
