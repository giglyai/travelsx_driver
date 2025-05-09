import 'package:travelx_driver/home/models/position_data_model.dart';

class PostUserDataParams {
  int? lpId;
  User? user;
  Device? device;
  String? deviceToken;
  App? app;
  String? source;
  String? timezone;
  String? vehicleType;
  String? createIsoTime;

  PostUserDataParams({
    this.lpId,
    this.user,
    this.device,
    this.deviceToken,
    this.app,
    this.source,
    this.timezone,
    this.vehicleType,
    this.createIsoTime,
  });

  PostUserDataParams.fromJson(Map<String, dynamic> json) {
    lpId = json['lp_id'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    device =
        json['device'] != null ? new Device.fromJson(json['device']) : null;
    deviceToken = json['device_token'];
    app = json['app'] != null ? new App.fromJson(json['app']) : null;
    source = json['source'];
    timezone = json['timezone'];
    vehicleType = json['vehicle_type'];
    createIsoTime = json['create_iso_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lp_id'] = this.lpId;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.device != null) {
      data['device'] = this.device!.toJson();
    }
    data['device_token'] = this.deviceToken;
    if (this.app != null) {
      data['app'] = this.app!.toJson();
    }
    data['source'] = this.source;
    data['timezone'] = this.timezone;
    data['vehicle_type'] = this.vehicleType;
    data['create_iso_time'] = this.createIsoTime;
    return data;
  }
}

class User {
  int? userId;
  int? userStatus;
  DriverPosition? position;
  String? name;
  String? phoneNumber;
  String? countryCode;
  String? accountStatus;

  User({
    this.userId,
    this.userStatus,
    this.position,
    this.name,
    this.phoneNumber,
    this.countryCode,
    this.accountStatus,
  });

  User.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    userStatus = json['user_status'];
    position =
        json['position'] != null
            ? new DriverPosition.fromJson(json['position'])
            : null;
    name = json['name'];
    phoneNumber = json['phone_number'];
    countryCode = json['country_code'];
    accountStatus = json['account_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['user_status'] = this.userStatus;
    if (this.position != null) {
      data['position'] = this.position!.toJson();
    }
    data['name'] = this.name;
    data['phone_number'] = this.phoneNumber;
    data['country_code'] = this.countryCode;
    data['account_status'] = this.accountStatus;
    return data;
  }
}

class Position {
  double? latitude;
  double? longitude;

  Position({this.latitude, this.longitude});

  Position.fromJson(Map<String, dynamic> json) {
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    return data;
  }
}

class Device {
  String? name;
  String? os;
  String? osVersion;

  Device({this.name, this.os, this.osVersion});

  Device.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    os = json['os'];
    osVersion = json['os_version'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['os'] = this.os;
    data['os_version'] = this.osVersion;
    return data;
  }
}

class App {
  String? name;
  String? version;

  App({this.name, this.version});

  App.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    version = json['version'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['version'] = this.version;
    return data;
  }
}
