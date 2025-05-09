class PostProfileData {
  PostProfileData(
      {required this.lpId,
      required this.userId,
      this.countryCode,
      this.phoneNumber,
      this.user});

  int lpId;
  int userId;
  String? countryCode;
  String? phoneNumber;
  String? user;

  factory PostProfileData.fromJson(Map<String, dynamic> json) =>
      PostProfileData(
          lpId: json["lp_id"],
          userId: json["user_id"],
          countryCode: json["country_code"],
          phoneNumber: json["phone_number"],
          user: json['user']);

  Map<String, dynamic> toJson() => {
        "lp_id": lpId,
        "user_id": userId,
        "country_code": countryCode,
        "phone_number": phoneNumber,
        "user": user
      };
}

class PostUserData {
  PostUserData(
      {required this.lpId,
      required this.userId,
      this.countryCode,
      this.phoneNumber,
      this.user,
      this.vehicleNumber,
      this.rideId});

  int lpId;
  int userId;
  String? countryCode;
  String? phoneNumber;
  String? user;
  String? vehicleNumber;
  String? rideId;

  factory PostUserData.fromJson(Map<String, dynamic> json) => PostUserData(
        lpId: json["lp_id"],
        userId: json["user_id"],
        countryCode: json["country_code"],
        phoneNumber: json["phone_number"],
        user: json['user'],
        vehicleNumber: json['vehicle_number'],
        rideId: json['ride_id'],
      );
  Map<String, dynamic> toJson() => {
        "lp_id": lpId,
        "user_id": userId,
        "country_code": countryCode,
        "phone_number": phoneNumber,
        "user": user,
        "vehicle_number": vehicleNumber,
        "ride_id": rideId
      };
}
