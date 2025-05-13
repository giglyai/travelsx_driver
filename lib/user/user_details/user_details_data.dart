import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:travelx_driver/user/account/enitity/profile_model.dart';

import '../../shared/local_storage/log_in_status.dart';

class ProfileRepository {
  ProfileRepository._();
  FlutterSecureStorage storage = const FlutterSecureStorage();

  /// Cached instance of [ProfileRepository];
  static ProfileRepository? _instance;

  static ProfileRepository get instance {
    _instance ??= ProfileRepository._();
    return _instance!;
  }

  Future<void> init() async {
    //Initialise tokens from secure storage
    getFirstName = await _accessFirstName;
    getLastName = await _accessLastName;
    getEmail = await _accessEmail;
    getProfileIcon = await _accessProfileIcon;
    getAccountStatus = await _accessAccountStatus;
    getAccountRating = await _accessAccountRating;
    getVehicleModel = await _accessVehicleModel;
        getVehicleType = await _accessVehicleType;
    getVehicleName = await _accessVehicleName;
    getVehicleNumber = await _accessVehicleNumber;
    getVehicleCategory = await _accessVehicleCategory;
    getCountryCode = await _accessCountryCode;
    getPhoneNumber = await _accessPhoneNumber;

    agencyList = await _accessAgencyList;
  }

  static String? getFirstName;
  static String? getLastName;
  static String? getEmail;
  static String? getProfileIcon;
  static String? getAccountStatus;
  static String? getAccountRating;
  static String? getVehicleModel;
  static String? getVehicleType;
  static String? getActingDriver;
  static String? getVehicleName;
  static String? getVehicleNumber;
  static String? getVehicleCategory;
  static String? getCountryCode;
  static String? getPhoneNumber;
  static List<AgencyList>? agencyList;

  Future<String?> get _accessFirstName async {
    return await LogInStatus().getUserProfileFirstName();
  }

  Future<List<AgencyList>?> get _accessAgencyList async {
    return await LogInStatus().getAgencyList();
  }

  Future<String?> get _accessVehicleModel async {
    return await LogInStatus().getUserVehicleModel();
  }

  Future<String?> get _accessVehicleName async {
    return await LogInStatus().getUserVehicleName();
  }

  Future<String?> get _accessVehicleNumber async {
    return await LogInStatus().getUserVehicleNumber();
  }

  Future<String?> get _accessVehicleType async {
    return await LogInStatus().getUserVehicleType();
  }

  Future<String?> get _accessVehicleCategory async {
    return await LogInStatus().getUserVehicleCategory();
  }

  Future<String?> get _accessLastName async {
    return await LogInStatus().getUserProfileLastName();
  }

  Future<String?> get _accessEmail async {
    return await LogInStatus().getUserProfileEmail();
  }

  Future<String?> get _accessProfileIcon async {
    return await LogInStatus().getUserProfileImageData();
  }

  Future<String?> get _accessAccountStatus async {
    return await LogInStatus().getUserProfileAccountData();
  }

  Future<String?> get _accessAccountRating async {
    return await LogInStatus().getUserProfileAccountRating();
  }

  Future<String?> get _accessCountryCode async {
    return await LogInStatus().getCountryCode();
  }

  Future<String?> get _accessPhoneNumber async {
    return await LogInStatus().getUserPhoneNumber();
  }

  Future<void> setUserFirstName(String firstName) async {
    getFirstName = firstName;
    return await LogInStatus.setUserProfileFirstName(
      profileFirstName: firstName,
    );
  }

  Future<void> setCountryCode(String countryCode) async {
    getCountryCode = countryCode;
    return await LogInStatus.setCountryCode(countryCode: countryCode);
  }

  Future<void> setUserPhoneNumber(String phoneNumber) async {
    getPhoneNumber = phoneNumber;
    return await LogInStatus.setUserPhoneNumber(phoneNumber: phoneNumber);
  }

  Future<void> setVehicleModel(String vehicleModel) async {
    getVehicleModel = vehicleModel;
    return await LogInStatus.setUserVehicleModel(vehicleModel: vehicleModel);
  }

  Future<void> setVehicleType(String vehicleType) async {
    getVehicleType = vehicleType;
    return await LogInStatus.setUserVehicleType(vehicleType: vehicleType);
  }

  Future<void> setActingDriver(String isActingDriver) async {
    getActingDriver = isActingDriver;
    return await LogInStatus.setActingDriver(isActingDriver: isActingDriver);
  }

  Future<void> setVehicleName(String vehicleName) async {
    getVehicleName = vehicleName;
    return await LogInStatus.setUserVehicleName(vehicleName: vehicleName);
  }

  Future<void> setVehicleNumber(String vehicleNumber) async {
    getVehicleNumber = vehicleNumber;
    return await LogInStatus.setUserVehicleNumber(vehicleNumber: vehicleNumber);
  }

  Future<void> setVehicleCategory(String vehicleCategory) async {
    getVehicleCategory = vehicleCategory;
    return await LogInStatus.setUserVehicleCategory(
      vehicleCategory: vehicleCategory,
    );
  }

  Future<void> setUserLastName(String lastName) async {
    getLastName = lastName;
    return await LogInStatus.setUserProfileLastName(profileLastName: lastName);
  }

  Future<void> setUserEmail(String email) async {
    getEmail = email;
    return await LogInStatus.setUserProfileEmail(profileEmail: email);
  }

  Future<void> setUserProfileIcon(String profileIcon) async {
    getProfileIcon = profileIcon;
    return await LogInStatus.setUserProfileImageData(
      profileImageData: profileIcon,
    );
  }

  Future<void> setUserProfileAccountStatus(String accountStatus) async {
    getAccountStatus = accountStatus;
    return await LogInStatus.setUserProfileAccountStatus(
      profileAccountStatus: accountStatus,
    );
  }

  Future<void> setAgencyList(List<AgencyList>? agencyList) async {
    agencyList = agencyList;
    return await LogInStatus.setAgencyList(agencyList: agencyList);
  }

  Future<void> setUserProfileAccountRating(String accountRating) async {
    getAccountRating = accountRating;
    return await LogInStatus.setUserProfileAccountRating(
      profileAccountRating: accountRating,
    );
  }
}
