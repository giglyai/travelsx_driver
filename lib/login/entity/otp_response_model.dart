class OtpModelResponse {
  String? status;
  Data? data;

  OtpModelResponse({this.status, this.data});

  OtpModelResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  Lp? lp;
  User? user;
  Profile? profile;
  String? authToken;
  String? deviceToken;
  String? userType;

  Data(
      {this.lp,
      this.user,
      this.profile,
      this.authToken,
      this.deviceToken,
      this.userType});

  Data.fromJson(Map<String, dynamic> json) {
    lp = json['lp'] != null ? new Lp.fromJson(json['lp']) : null;
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    profile =
        json['profile'] != null ? new Profile.fromJson(json['profile']) : null;
    authToken = json['auth_token'];
    deviceToken = json['device_token'];
    userType = json['user_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.lp != null) {
      data['lp'] = this.lp!.toJson();
    }
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.profile != null) {
      data['profile'] = this.profile!.toJson();
    }
    data['auth_token'] = this.authToken;
    data['device_token'] = this.deviceToken;
    data['user_type'] = this.userType;
    return data;
  }
}

class Lp {
  int? id;
  String? name;
  String? phoneNumber;
  String? whatsapp;
  String? countryCode;
  String? email;
  String? deviceToken;

  Lp(
      {this.id,
      this.name,
      this.phoneNumber,
      this.whatsapp,
      this.countryCode,
      this.email,
      this.deviceToken});

  Lp.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phoneNumber = json['phone_number'];
    whatsapp = json['whatsapp'];
    countryCode = json['country_code'];
    email = json['email'];
    deviceToken = json['device_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['phone_number'] = this.phoneNumber;
    data['whatsapp'] = this.whatsapp;
    data['country_code'] = this.countryCode;
    data['email'] = this.email;
    data['device_token'] = this.deviceToken;
    return data;
  }
}

class User {
  int? id;
  String? firstName;
  String? lastName;
  String? phoneNumber;
  String? countryCode;
  String? email;
  String? accountStatus;
  String? address;
  String? place;
  String? deviceToken;
  String? vehicleModel;
  bool? isRegistered;
  bool? isSubscribed;
  bool? isNewUser;

  User(
      {this.id,
      this.firstName,
      this.lastName,
      this.phoneNumber,
      this.countryCode,
      this.email,
      this.accountStatus,
      this.address,
      this.place,
      this.deviceToken,
      this.vehicleModel,
      this.isRegistered,
      this.isSubscribed,
      this.isNewUser});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    phoneNumber = json['phone_number'];
    countryCode = json['country_code'];
    email = json['email'];
    accountStatus = json['account_status'];
    address = json['address'];
    place = json['place'];
    deviceToken = json['device_token'];
    vehicleModel = json['vehicle_model'];
    isRegistered = json['is_registered'];
    isSubscribed = json['is_subscribed'];
    isNewUser = json['is_new_user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['phone_number'] = this.phoneNumber;
    data['country_code'] = this.countryCode;
    data['email'] = this.email;
    data['account_status'] = this.accountStatus;
    data['address'] = this.address;
    data['place'] = this.place;
    data['device_token'] = this.deviceToken;
    data['vehicle_model'] = this.vehicleModel;
    data['is_registered'] = this.isRegistered;
    data['is_subscribed'] = this.isSubscribed;
    data['is_new_user'] = this.isNewUser;
    return data;
  }
}

class Profile {
  String? onlineStatus;
  String? rideStatus;

  Profile({this.onlineStatus, this.rideStatus});

  Profile.fromJson(Map<String, dynamic> json) {
    onlineStatus = json['online_status'];
    rideStatus = json['ride_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['online_status'] = this.onlineStatus;
    data['ride_status'] = this.rideStatus;
    return data;
  }
}
