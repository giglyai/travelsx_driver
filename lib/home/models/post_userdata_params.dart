import 'package:travelx_driver/home/models/position_data_model.dart';
import 'package:travelx_driver/user/account/enitity/profile_model.dart';

class PostUserDataParams {
  PostUserDataParams(
      {required this.lpId,
      required this.user,
      this.source,
      this.deviceToken,
      this.device,
      this.app,
      this.vehicleType,
      this.timezone,
      this.countryCode,
      this.phoneNumber,
      this.agencyList});

  int? lpId;
  User user;
  Device? device;
  App? app;
  String? source;
  String? deviceToken;
  String? timezone;
  String? vehicleType;
  String? countryCode;
  String? phoneNumber;
  List<AgencyList>? agencyList;

  factory PostUserDataParams.fromJson(Map<String, dynamic> json) =>
      PostUserDataParams(
        lpId: json["lp_id"],
        user: User.fromJson(json["user"]),
        device: Device.fromJson(json["device"]),
        deviceToken: json["device_token"],
        app: App.fromJson(json["app"]),
        timezone: json["timezone"],
        source: json["source"],
        vehicleType: json["vehicle_type"],
        countryCode: json["country_code"],
        phoneNumber: json["phone_number"],
        agencyList: json["agency_list"] == null
            ? []
            : List<AgencyList>.from(
                json["agency_list"]!.map((x) => AgencyList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "lp_id": lpId,
        "user": user.toJson(),
        "device": device?.toJson(),
        "device_token": deviceToken,
        "app": app?.toJson(),
        "source": source,
        "timezone": timezone,
        "vehicle_type": vehicleType,
        "country_code": countryCode,
        "phone_number": phoneNumber,
        "agency_list": agencyList == null
            ? []
            : List<dynamic>.from(agencyList!.map((x) => x.toJson())),
      };
}

class App {
  App({
    required this.name,
    required this.version,
  });

  String name;
  String version;

  factory App.fromJson(Map<String, dynamic> json) => App(
        name: json["name"],
        version: json["version"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "version": version,
      };
}

class Device {
  Device({
    required this.name,
    required this.os,
    required this.osVersion,
  });

  String name;
  String os;
  String osVersion;

  factory Device.fromJson(Map<String, dynamic> json) => Device(
        name: json["name"],
        os: json["os"],
        osVersion: json["os_version"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "os": os,
        "os_version": osVersion,
      };
}

class User {
  User(
      {this.userId,
      this.userStatus,
      this.position,
      this.user,
      this.name,
      this.phoneNumber,
      this.countryCode});

  int? userId;
  int? userStatus;
  DriverPosition? position;
  String? user;
  String? name;
  String? phoneNumber;
  String? countryCode;

  factory User.fromJson(Map<String, dynamic> json) => User(
        userId: json["user_id"],
        userStatus: json["user_status"],
        position: DriverPosition.fromJson(json["position"]),
        user: json["user"],
        name: json["name"],
        phoneNumber: json["phone_number"],
        countryCode: json["country_code"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "user_status": userStatus,
        "position": position?.toJson(),
        "user": user,
        "name": name,
        "phone_number": phoneNumber,
        "country_code": countryCode
      };
}

class Lp {
  int lpId;

  Lp({
    required this.lpId,
  });

  factory Lp.fromJson(Map<String, dynamic> json) => Lp(
        lpId: json["lp_id"],
      );

  Map<String, dynamic> toJson() => {
        "lp_id": lpId,
      };
}
