import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'log_in_status.dart';

class UserRepository {
  UserRepository._();

  /// Cached instance of [AuthRepository];
  static UserRepository? _instance;
  FlutterSecureStorage storage = const FlutterSecureStorage();

  static UserRepository get instance {
    _instance ??= UserRepository._();
    return _instance!;
  }

  Future<void> init() async {
    //Initialise tokens from secure storage
    getEmail = await _refreshEmail;
    getProfile = await _accessProfile;
    getPhoneNumber = await _accessPhoneNumber;
    getLpID = await _accessLpID;
    getUserID = await _accessUserID;
    getAccountStatus = await _accessAccounStatus;

    getDriverID = await _accessDriverID;
    getCountryCode = await _accessCountryCode;
    getCountry = await _accessCountry;
    getDeviceToken = await _accessDeviceToken;
    getLat = await _accessLat;
    getLong = await _accessLong;
    getPlayerId = await _accessPlayerId;
  }

  static String? getAccountStatus;
  static String? getAccountRating;
  static String? getFirstName;
  static String? getLastName;
  static String? getEmail;
  static String? getPhoneNumber;
  static String? getLpID;
  static String? getUserID;
  static String? getDriverID;
  static String? getProfile;
  static String? getCountryCode;
  static String? getCountry;
  static String? getDeviceToken;
  static double? getLat;
  static double? getLong;
  static String? getPlayerId;

  Future<String?> get _accessPlayerId async {
    return await LogInStatus().getPlayerIdDetails();
  }

  Future<void> setAccessPlayerId(String playerID) async {
    getPlayerId = playerID;
    return await LogInStatus.setPlayerID(playerId: playerID);
  }

  Future<String?> get _refreshEmail async {
    return await LogInStatus().getUserEmail();
  }

  Future<String?> get _accessCountryCode async {
    return await LogInStatus().getCountryCode();
  }

  Future<String?> get _accessAccounStatus async {
    return await LogInStatus().getAccountStatus();
  }

  Future<String?> get _accessCountry async {
    return await LogInStatus().getCountry();
  }

  Future<String?> get _accessDeviceToken async {
    return await LogInStatus().getDeviceTokenDetails();
  }

  Future<String?> get _accessPhoneNumber async {
    return await LogInStatus().getUserPhoneNumber();
  }

  Future<String?> get _accessLpID async {
    return await LogInStatus().getDriverLpId();
  }

  Future<String?> get _accessUserID async {
    return await LogInStatus().getUserID();
  }

  Future<String?> get _accessDriverID async {
    return await LogInStatus().getDriverID();
  }

  Future<String?> get _accessProfile async {
    return await LogInStatus().getUserProfile();
  }

  Future<double?> get _accessLat async {
    return await LogInStatus().getUserLat();
  }

  Future<double?> get _accessLong async {
    return await LogInStatus().getUserLong();
  }

  Future<void> setRefreshEmail(String email) async {
    getEmail = email;
  }

  Future<void> setAccessProfile(String profile) async {
    getProfile = profile;
    return await LogInStatus.setUserProfile(profile: profile);
  }

  Future<void> setAccessPhoneNumber(String phoneNumber) async {
    getPhoneNumber = phoneNumber;
    return await LogInStatus.setUserPhoneNumber(phoneNumber: phoneNumber);
  }

  Future<void> setAccessLpID(String lpID) async {
    getLpID = lpID;
    return await LogInStatus.setUserLpID(lpID: lpID);
  }

  Future<void> setAccessUserID(String driverID) async {
    getUserID = driverID;
    return await LogInStatus.setUserID(driverID: driverID);
  }

  Future<void> setAccessDriverID(String driverID) async {
    getDriverID = driverID;
    return await LogInStatus.setUserDriverID(driverID: driverID);
  }

  Future<void> setAccessCountryCode(String countryCode) async {
    getCountryCode = countryCode;
    return await LogInStatus.setCountryCode(countryCode: countryCode);
  }

  Future<void> setAccessCountry(String country) async {
    getCountryCode = country;
    return await LogInStatus.setCountry(country: country);
  }

  Future<void> setAccessDeviceToken(String deviceToken) async {
    getDeviceToken = deviceToken;
    return await LogInStatus.setDeviceToken(deviceToken: deviceToken);
  }

  Future<void> setUserCurrentLat(double lat) async {
    getLat = lat;
    return await LogInStatus.setUserLat(lat: lat);
  }

  Future<void> setUserCurrentLong(double long) async {
    getLong = long;
    return await LogInStatus.setUserLong(long: long);
  }

  Future<void> userAccountUpdate(Map<String, dynamic> account) async {
    for (final entry in account.entries) {
      switch (entry.key) {
        case 'account_status':
          await storage.write(key: entry.key, value: entry.value);
          getAccountStatus = entry.value;
          break;
        case 'rating':
          await storage.write(key: entry.key, value: entry.value);
          getAccountRating = entry.value;
          break;
        case 'first_name':
          await storage.write(key: entry.key, value: entry.value);
          getFirstName = entry.value;
          break;
        case 'last_name':
          await storage.write(key: entry.key, value: entry.value);
          getLastName = entry.value;
          break;
        case 'email':
          await storage.write(key: entry.key, value: entry.value);
          getEmail = entry.value;
          break;
      }
    }
  }
}
