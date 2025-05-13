import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travelx_driver/user/account/enitity/profile_model.dart';

import '../../home/models/ride_response_model.dart';

class LogInStatus {
  FlutterSecureStorage storage = const FlutterSecureStorage();
  late String accessToken;
  late String name;
  late String phoneNumber;
  late String email;
  late String driverId;
  late String getLpId;
  late String getDeviceToken;
  late String getDriverProfile;
  late String getPhoneNumber;
  late String getPlayerId;

  Future<void> userHasLoggedIn({
    required String token,
    required String phoneNumber,
    required String countryCode,
    required String lpId,
    required String userId,
    String? driverProfile,
  }) async {
    accessToken = token;
    userId = userId;
    getLpId = lpId;
    getDriverProfile = driverProfile ?? "";
    getPhoneNumber = phoneNumber;
    storage.write(key: 'auth_token', value: token);
    storage.write(key: 'userId', value: userId);
    storage.write(key: 'lpId', value: lpId);
    storage.write(key: 'profile', value: driverProfile);
    storage.write(key: 'phone_number', value: phoneNumber);
    storage.write(key: 'country_code', value: countryCode);
  }

  Future<String?> driverStatus() async {
    SharedPreferences storage = await SharedPreferences.getInstance();

    String? userId;
    userId = storage.getString('driverStatus');
    if (userId != null) {
      userId = userId;
    }
    return userId;
  }

  Future<void> setDeviceTokenFireBase({required String deviceToken}) async {
    getDeviceToken = deviceToken;
    storage.write(key: 'device_token', value: deviceToken);
  }

  Future<void> savedPlayerId(String playerId) async {
    getPlayerId = playerId;
    storage.write(key: 'player_id', value: playerId);
  }

  static Future<void> setUserToken({String? token}) async {
    FlutterSecureStorage storage = const FlutterSecureStorage();
    if (token != null) {
      storage.write(key: 'auth_token', value: token);
    }
  }

  static Future<void> setAccountStatus({String? accountStatus}) async {
    FlutterSecureStorage storage = const FlutterSecureStorage();
    if (accountStatus != null) {
      storage.write(key: 'account_status', value: accountStatus);
    }
  }

  static Future<void> setPlayerID({String? playerId}) async {
    FlutterSecureStorage storage = const FlutterSecureStorage();
    if (playerId != null) {
      storage.write(key: 'player_id', value: playerId);
    }
  }

  Future<String?> getPlayerIdDetails() async {
    String? playerId;
    await storage
        .read(key: 'player_id')
        .then((value) => playerId = value.toString());
    if (playerId != null) {
      playerId = playerId!;
    }

    return playerId;
  }

  static Future<void> setUserProfile({String? profile}) async {
    FlutterSecureStorage storage = const FlutterSecureStorage();
    if (profile != null) {
      storage.write(key: 'profile', value: profile);
    }
  }

  static Future<void> setUserLpID({String? lpID}) async {
    FlutterSecureStorage storage = const FlutterSecureStorage();
    if (lpID != null) {
      storage.write(key: 'lpId', value: lpID);
    }
  }

  static Future<void> setUserID({String? driverID}) async {
    FlutterSecureStorage storage = const FlutterSecureStorage();
    if (driverID != null) {
      storage.write(key: 'userId', value: driverID);
    }
  }

  static Future<void> setUserDriverID({String? driverID}) async {
    FlutterSecureStorage storage = const FlutterSecureStorage();
    if (driverID != null) {
      storage.write(key: 'driverId', value: driverID);
    }
  }

  static Future<void> setCountryCode({String? countryCode}) async {
    FlutterSecureStorage storage = const FlutterSecureStorage();
    if (countryCode != null) {
      storage.write(key: 'country_code', value: countryCode);
    }
  }

  static Future<void> setCountry({String? country}) async {
    FlutterSecureStorage storage = const FlutterSecureStorage();
    if (country != null) {
      storage.write(key: 'currency', value: country);
    }
  }

  static Future<void> setDeviceToken({String? deviceToken}) async {
    FlutterSecureStorage storage = const FlutterSecureStorage();
    if (deviceToken != null) {
      storage.write(key: 'device_token', value: deviceToken);
    }
  }

  static Future<void> setUserPhoneNumber({String? phoneNumber}) async {
    FlutterSecureStorage storage = const FlutterSecureStorage();
    if (phoneNumber != null) {
      storage.write(key: 'phone_number', value: phoneNumber);
    }
  }

  Future<void> savedDeviceToken(String deviceToken) async {
    getDeviceToken = deviceToken;
    storage.write(key: 'device_token', value: deviceToken);
  }

  Future<String?> getDeviceTokenDetails() async {
    String? deviceToken;
    await storage
        .read(key: 'device_token')
        .then((value) => deviceToken = value.toString());
    if (deviceToken != null) {
      deviceToken = deviceToken!;
    }

    return deviceToken;
  }

  Future<String?> getUserToken() async {
    String? token;
    await storage
        .read(key: 'auth_token')
        .then((value) => token = value.toString());
    if (token != null) {
      accessToken = token!;
    }
    return token;
  }

  Future<String?> getDriverID() async {
    String? driverId;
    await storage
        .read(key: 'driverId')
        .then((value) => driverId = value.toString());
    if (driverId != null) {
      driverId = driverId!;
    }
    return driverId;
  }

  Future<String?> getUserID() async {
    String? userId;
    await storage
        .read(key: 'userId')
        .then((value) => userId = value.toString());
    if (userId != null) {
      userId = userId!;
    }
    return userId;
  }

  Future<String?> getDriverLpId() async {
    //return stored token
    String? lpId;
    await storage.read(key: 'lpId').then((value) => lpId = value.toString());
    if (lpId != null) {
      lpId = lpId!;
    }
    return lpId;
  }

  Future<bool> checkLoginStatus() async {
    //returns true if user is already loggedIn
    var test = await storage.containsKey(key: 'auth_token');
    if (kDebugMode) {
      print("checklogin $test");
    }
    return test;
  }

  Future<String?> getAccountStatus() async {
    //returns true if user is already loggedIn

    String? accountStatus;
    await storage
        .read(key: 'account_status')
        .then((value) => accountStatus = value.toString());
    if (accountStatus != null) {
      accountStatus = accountStatus!;
    }
    return accountStatus;
  }

  Future<String?> getUserName() async {
    //return stored token
    String? name;
    await storage
        .read(key: 'first_name')
        .then((value) => name = value.toString());
    if (name != null) {
      name = name!;
    }
    return name;
  }

  Future<String?> getUserProfile() async {
    //return stored token
    String? profile;
    await storage
        .read(key: 'profile')
        .then((value) => profile = value.toString());
    if (profile != null) {
      profile = profile!;
    }
    return profile;
  }

  Future<double?> getUserLat() async {
    //return stored token
    double? lat;
    await storage
        .read(key: 'latitude')
        .then((value) => lat = double.tryParse(value.toString()));
    if (lat != null) {
      lat = lat!;
    }
    return lat;
  }

  Future<double?> getUserLong() async {
    //return stored token
    double? long;
    await storage
        .read(key: 'longitude')
        .then((value) => long = double.tryParse(value.toString()));
    if (long != null) {
      long = long!;
    }
    return long;
  }

  static Future<void> setUserLat({double? lat}) async {
    FlutterSecureStorage storage = const FlutterSecureStorage();
    if (lat != null) {
      storage.write(key: 'latitude', value: lat.toString());
    }
  }

  static Future<void> setUserLong({double? long}) async {
    FlutterSecureStorage storage = const FlutterSecureStorage();
    if (long != null) {
      storage.write(key: 'longitude', value: long.toString());
    }
  }

  Future<void> setUserLogInCredentials(String email, String password) async {
    storage.write(key: 'savedEmail', value: email);
    storage.write(key: 'savedPassword', value: password);
  }

  Future<String?> getUserSavedEmail() async {
    String? email;
    email = await storage
        .read(key: 'savedEmail')
        .then((value) => email = value.toString());
    return email!;
  }

  Future<bool> userPasswordIsSaved() async {
    bool? credentialsAreSaved = await storage.containsKey(key: 'savedEmail');
    return credentialsAreSaved;
  }

  Future<String?> getUserSavedPassword() async {
    String? password;
    password = await storage
        .read(key: 'savedPassword')
        .then((value) => password = value.toString());
    return password!;
  }

  Future<void> clearSavedPassword() async {
    await storage.delete(key: 'savedEmail');
    storage.delete(key: 'savedPassword');
  }

  Future<String?> getUserEmail() async {
    //return stored token
    String? email;
    await storage.read(key: 'email').then((value) => email = value.toString());
    if (email != null) {
      email = email!;
    }
    return email;
  }

  Future<String?> getUserPhoneNumber() async {
    //return stored token
    String? phoneNumber;
    await storage
        .read(key: 'phone_number')
        .then((value) => phoneNumber = value.toString());
    if (phoneNumber != null) {
      phoneNumber = phoneNumber!;
    }
    return phoneNumber;
  }

  Future<String?> getCountryCode() async {
    //return stored token
    String? countryCode;
    await storage
        .read(key: 'country_code')
        .then((value) => countryCode = value.toString());
    if (countryCode != null) {
      countryCode = countryCode!;
    }
    return countryCode;
  }

  Future<String?> getCountry() async {
    //return stored token
    String? country;
    await storage
        .read(key: 'currency')
        .then((value) => country = value.toString());
    if (country != null) {
      country = country!;
    }
    return country;
  }

  ///user profile data section

  static Future<void> setUserProfileFirstName({
    String? profileFirstName,
  }) async {
    FlutterSecureStorage storage = const FlutterSecureStorage();
    if (profileFirstName != null) {
      storage.write(
        key: 'profile_first_name',
        value: profileFirstName.toString(),
      );
    }
  }

  Future<String?> getUserProfileFirstName() async {
    //return stored token
    String? profileFirstName;
    await storage
        .read(key: 'profile_first_name')
        .then((value) => profileFirstName = value.toString());
    if (profileFirstName != null) {
      profileFirstName = profileFirstName!;
    }
    return profileFirstName;
  }

  static Future<void> setAgencyList({List<AgencyList>? agencyList}) async {
    FlutterSecureStorage storage = const FlutterSecureStorage();
    if (agencyList != null) {
      storage.write(key: 'agency_list', value: jsonEncode(agencyList));
    }
  }

  Future<List<AgencyList>?> getAgencyList() async {
    String? jsonString = await storage.read(key: 'agency_list');
    if (jsonString != null) {
      return (jsonDecode(jsonString) as List)
          .map((json) => AgencyList.fromJson(json))
          .toList();
    } else {
      return null;
    }
  }

  Future<String?> getUserVehicleModel() async {
    //return stored token
    String? vehicleModel;
    await storage
        .read(key: 'profile_vehicle_model')
        .then((value) => vehicleModel = value.toString());
    if (vehicleModel != null) {
      vehicleModel = vehicleModel!;
    }
    return vehicleModel;
  }

  Future<String?> getUserVehicleName() async {
    //return stored token
    String? vehicleName;
    await storage
        .read(key: 'profile_vehicle_name')
        .then((value) => vehicleName = value.toString());
    if (vehicleName != null) {
      vehicleName = vehicleName!;
    }
    return vehicleName;
  }

  Future<String?> getUserVehicleNumber() async {
    //return stored token
    String? vehicleNumber;
    await storage
        .read(key: 'profile_vehicle_number')
        .then((value) => vehicleNumber = value.toString());
    if (vehicleNumber != null) {
      vehicleNumber = vehicleNumber!;
    }
    return vehicleNumber;
  }

  Future<String?> getUserVehicleType() async {
    //return stored token
    String? vehicleType;
    await storage
        .read(key: 'profile_vehicle_type')
        .then((value) => vehicleType = value.toString());
    if (vehicleType != null) {
      vehicleType = vehicleType!;
    }
    return vehicleType;
  }

  Future<String?> getUserVehicleCategory() async {
    //return stored token
    String? vehicleCategory;
    await storage
        .read(key: 'profile_vehicle_category')
        .then((value) => vehicleCategory = value.toString());
    if (vehicleCategory != null) {
      vehicleCategory = vehicleCategory!;
    }
    return vehicleCategory;
  }

  static Future<void> setUserVehicleCategory({String? vehicleCategory}) async {
    FlutterSecureStorage storage = const FlutterSecureStorage();
    if (vehicleCategory != null) {
      storage.write(
        key: 'profile_vehicle_category',
        value: vehicleCategory.toString(),
      );
    }
  }

  static Future<void> setUserVehicleModel({String? vehicleModel}) async {
    FlutterSecureStorage storage = const FlutterSecureStorage();
    if (vehicleModel != null) {
      storage.write(
        key: 'profile_vehicle_model',
        value: vehicleModel.toString(),
      );
    }
  }

  static Future<void> setUserVehicleType({String? vehicleType}) async {
    FlutterSecureStorage storage = const FlutterSecureStorage();
    if (vehicleType != null) {
      storage.write(key: 'profile_vehicle_type', value: vehicleType.toString());
    }
  }

  static Future<void> setActingDriver({String? isActingDriver}) async {
    FlutterSecureStorage storage = const FlutterSecureStorage();
    if (isActingDriver != null) {
      storage.write(
        key: 'profile_acting_driver',
        value: isActingDriver.toString(),
      );
    }
  }

  static Future<void> setUserVehicleName({String? vehicleName}) async {
    FlutterSecureStorage storage = const FlutterSecureStorage();
    if (vehicleName != null) {
      storage.write(key: 'profile_vehicle_name', value: vehicleName.toString());
    }
  }

  static Future<void> setUserVehicleNumber({String? vehicleNumber}) async {
    FlutterSecureStorage storage = const FlutterSecureStorage();
    if (vehicleNumber != null) {
      storage.write(
        key: 'profile_vehicle_number',
        value: vehicleNumber.toString(),
      );
    }
  }

  static Future<void> setUserProfileLastName({String? profileLastName}) async {
    FlutterSecureStorage storage = const FlutterSecureStorage();
    if (profileLastName != null) {
      storage.write(
        key: 'profile_last_name',
        value: profileLastName.toString(),
      );
    }
  }

  Future<String?> getUserProfileLastName() async {
    //return stored token
    String? profileLastName;
    await storage
        .read(key: 'profile_last_name')
        .then((value) => profileLastName = value.toString());
    if (profileLastName != null) {
      profileLastName = profileLastName!;
    }
    return profileLastName;
  }

  static Future<void> setUserProfileEmail({String? profileEmail}) async {
    FlutterSecureStorage storage = const FlutterSecureStorage();
    if (profileEmail != null) {
      storage.write(key: 'profile_email', value: profileEmail.toString());
    }
  }

  Future<String?> getUserProfileEmail() async {
    //return stored token
    String? profileEmail;
    await storage
        .read(key: 'profile_email')
        .then((value) => profileEmail = value.toString());
    if (profileEmail != null) {
      profileEmail = profileEmail!;
    }
    return profileEmail;
  }

  static Future<void> setUserProfileImageData({
    String? profileImageData,
  }) async {
    FlutterSecureStorage storage = const FlutterSecureStorage();
    if (profileImageData != null) {
      storage.write(key: 'profile_image', value: profileImageData.toString());
    }
  }

  Future<String?> getActingDriver() async {
    //return stored token
    String? actingDriver;
    await storage
        .read(key: 'profile_acting_driver')
        .then((value) => actingDriver = value.toString());
    if (actingDriver != null) {
      actingDriver = actingDriver!;
    }
    return actingDriver;
  }

  Future<String?> getUserProfileImageData() async {
    //return stored token
    String? profileImageData;
    await storage
        .read(key: 'profile_image')
        .then((value) => profileImageData = value.toString());
    if (profileImageData != null) {
      profileImageData = profileImageData!;
    }
    return profileImageData;
  }

  static Future<void> setUserProfileAccountStatus({
    String? profileAccountStatus,
  }) async {
    FlutterSecureStorage storage = const FlutterSecureStorage();
    if (profileAccountStatus != null) {
      storage.write(
        key: 'profile_account_status',
        value: profileAccountStatus.toString(),
      );
    }
  }

  Future<String?> getUserProfileAccountData() async {
    //return stored token
    String? profileAccountStatus;
    await storage
        .read(key: 'profile_account_status')
        .then((value) => profileAccountStatus = value.toString());
    if (profileAccountStatus != null) {
      profileAccountStatus = profileAccountStatus!;
    }
    return profileAccountStatus;
  }

  static Future<void> setUserProfileAccountRating({
    String? profileAccountRating,
  }) async {
    FlutterSecureStorage storage = const FlutterSecureStorage();
    if (profileAccountRating != null) {
      storage.write(
        key: 'profile_account_rating',
        value: profileAccountRating.toString(),
      );
    }
  }

  Future<String?> getUserProfileAccountRating() async {
    //return stored token
    String? profileAccountRating;
    await storage
        .read(key: 'profile_account_rating')
        .then((value) => profileAccountRating = value.toString());
    if (profileAccountRating != null) {
      profileAccountRating = profileAccountRating!;
    }
    return profileAccountRating;
  }

  Future<void> userTokenExpired() async {
    //logOutUser
    await storage.delete(key: 'auth_token');
    await storage.delete(key: 'email');
    await storage.delete(key: 'first_name');
    await storage.delete(key: 'lpId');
    await storage.delete(key: 'driverId');
    await storage.delete(key: 'userId');
    await storage.delete(key: 'profile');

    //showing loginScreen when loggedOut
    // Get.snackbar("Session Expired", "Please Login Again",
    //     animationDuration: const Duration(milliseconds: 500),
    //     isDismissible: true,
    //     padding: EdgeInsets.only(
    //         left: ScreenWidth * 0.05,
    //         top: ScreenWidth * 0.05,
    //         bottom: ScreenWidth * 0.05),
    //     snackPosition: SnackPosition.BOTTOM,
    //     icon: Icon(
    //       Icons.error_outline,
    //       color: Colors.red,
    //       size: ScreenWidth * 0.15,
    //     ),
    //     margin: EdgeInsets.only(
    //         bottom: ScreenHeight * 0.05,
    //         left: ScreenWidth * 0.05,
    //         right: ScreenWidth * 0.05));

    // Future.delayed(Duration(seconds: 2),(){
    //
    // });
  }

  Future<Ride> storeGotDriverData({required Ride ride}) async {
    String jsonString = jsonEncode(ride);

    await storage.write(key: 'ride', value: jsonString);
    return ride;
  }

  Future<String> storeDriverTripSequence({required String rideType}) async {
    await storage.write(key: 'ride_type', value: rideType);
    return rideType;
  }

  Future<String?> getDriverTripSequence() async {
    String? jsonString = await storage.read(key: 'ride_type');
    if (jsonString != null) {
      return jsonString;
    } else {
      return jsonString;
    }
  }

  Future<bool> isUserGotRide() async {
    var test = await storage.containsKey(key: 'ride');
    return test;
  }

  Future<Ride?> getUserRideDetails() async {
    String? jsonString = await storage.read(key: 'ride');
    if (jsonString != null) {
      return Ride.fromJson(jsonDecode(jsonString));
    } else {
      return null;
    }
  }

  Future<void> clearRide() async {
    await storage.delete(key: 'ride');
  }

  Future<void> clearRideType() async {
    await storage.delete(key: 'ride_type');
  }

  Future<void> logOutUser() async {
    await storage.delete(key: 'auth_token');
    await storage.delete(key: 'email');
    await storage.delete(key: 'first_name');
    await storage.delete(key: 'lpId');
    await storage.delete(key: 'driverId');
    await storage.delete(key: 'profile');
    await storage.delete(key: 'player_id');
  }
}
