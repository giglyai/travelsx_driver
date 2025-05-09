// To parse this JSON data, do
//
//     final addAddressRespone = addAddressResponeFromJson(jsonString);

import 'dart:convert';

UserRidesRespone addAddressResponeFromJson(String str) => UserRidesRespone.fromJson(json.decode(str));

String addAddressResponeToJson(UserRidesRespone data) => json.encode(data.toJson());

class UserRidesRespone {
    String status;
    Data data;

    UserRidesRespone({
        required this.status,
        required this.data,
    });

    factory UserRidesRespone.fromJson(Map<String, dynamic> json) => UserRidesRespone(
        status: json["status"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": data.toJson(),
    };
}

class Data {
    int lpId;
    int userId;
    String phoneNumber;
    String address;
    int unit;
    String addressNick;
    int latitude;
    int longitude;

    Data({
        required this.lpId,
        required this.userId,
        required this.phoneNumber,
        required this.address,
        required this.unit,
        required this.addressNick,
        required this.latitude,
        required this.longitude,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        lpId: json["lp_id"],
        userId: json["user_id"],
        phoneNumber: json["phone_number"],
        address: json["address"],
        unit: json["unit"],
        addressNick: json["address_nick"],
        latitude: json["latitude"],
        longitude: json["longitude"],
    );

    Map<String, dynamic> toJson() => {
        "lp_id": lpId,
        "user_id": userId,
        "phone_number": phoneNumber,
        "address": address,
        "unit": unit,
        "address_nick": addressNick,
        "latitude": latitude,
        "longitude": longitude,
    };
}
