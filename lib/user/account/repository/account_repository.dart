import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:travelx_driver/home/models/position_data_model.dart';

import '../../../global_variables.dart';
import '../../../shared/api_client/api_client.dart';
import '../../../shared/routes/api_routes.dart';
import '../../../shared/utils/utilities.dart';
import '../enitity/upload.dart';

class AccountRepository {
  static Future<Map<String, dynamic>> postUserData({
    required int lpId,
    required int userId,
    required String user,
    required String firstName,
    required String lastName,
    required String email,
  }) async {
    final response = await ApiClient().post(ApiRoutes.userProfileUpdate,
        body: {
          "lp_id": lpId,
          "user_id": userId,
          "user": user,
          "first_name": firstName,
          "last_name": lastName,
          "email": email,
        },
        headers: header);

    return response as Map<String, dynamic>;
  }

  static Future<Map<String, dynamic>> deleteAccountData({
    required int lpId,
    required int userId,
    required String user,
  }) async {
    final response = await ApiClient().post(ApiRoutes.userAccountDelete,
        body: {"lp_id": lpId, "user_id": userId, "user": user},
        headers: header);
    return response as Map<String, dynamic>;
  }

  static Future<Map<String, dynamic>> getProfileData({
    required lpId,
    required userId,
    required user,
    required String phoneNumber,
    required String countryCode,
  }) async {
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
    final queryData = {
      "lp_id": lpId,
      "user_id": userId,
      "user": user,
    };

    final response = await ApiClient().getWithoutBottomSheet(
      ApiRoutes.getUserProfileData,
      headers: requestHeaders,
      queryParams: queryData,
    );
    return response as Map<String, dynamic>;
  }

  static Future<Map<String, dynamic>> getVehicleListData({
    required lpId,
    required userId,
    required user,
    required String phoneNumber,
    required String countryCode,
  }) async {
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
    final queryData = {"lp_id": lpId, "user_id": userId, "user": user};

    final response = await ApiClient().get(
      ApiRoutes.getUserVehicleData,
      headers: requestHeaders,
      queryParams: queryData,
    );
    return response as Map<String, dynamic>;
  }

  static Future<Map<String, dynamic>> uploadProfileImg(
      {required PostProfileData params, required String imagePath}) async {
    var data = FormData.fromMap({
      'files': [
        await MultipartFile.fromFile(imagePath, filename: "profile_image")
      ],
      'user_data': params.toJson(),
    });

    print(jsonEncode(params));
    // formdata.files
    //     .add(MapEntry('profile_image', MultipartFile.fromFileSync(imagePath)));
    // formdata.fields.add(MapEntry('user_data', params.toString()));

    final response = await ApiClient().post(
      ApiRoutes.uploadProfileImg,
      body: data,
      headers: {'Content-Type': 'multipart/form-data'},
    );

    return response as Map<String, dynamic>;
  }

  static Future<Map<String, dynamic>> postDriverVehicleInfo({
    required int lpId,
    required int userId,
    required String countryCode,
    required String phoneNumber,
    required String user,
    required String vehicleCompany,
    required String vehicleModel,
    required String vehicleNumber,
    required String licenseNumber,
    required String userName,
  }) async {
    final response = await ApiClient().post(ApiRoutes.userProfileUpdate,
        body: {
          "first_name": userName,
          "vehicle_model": vehicleModel,
          "vehicle_number": vehicleNumber,
          "licence_number": licenseNumber,
          "lp_id": lpId,
          "user_id": userId,
          "user": user,
          "active_driver": false,
          "vehicle_name": vehicleCompany,
        },
        headers: header);
    return response as Map<String, dynamic>;
  }

  static Future<Map<String, dynamic>> postFreshDriverVehicleInfo({
    required int lpId,
    required int userId,
    required String user,
    required String vehicleCompany,
    required String vehicleModel,
    required String vehicleNumber,
    required String licenseNumber,
    required String firstName,
    required String address,
    required String place,
    required bool actingDriver,
    required DriverPosition position,
  }) async {
    final response = await ApiClient().post(ApiRoutes.userProfileUpdate,
        body: {
          "first_name": firstName,
          "vehicle_company": vehicleCompany,
          "vehicle_model": vehicleModel,
          "vehicle_name": vehicleCompany,
          "vehicle_number": vehicleNumber,
          "licence_number": licenseNumber,
          "lp_id": lpId,
          "user_id": userId,
          "user": user,
          "address": address,
          "place": place,
          "latitude": position.latitude,
          "longitude": position.longitude,
          "active_driver": actingDriver,
        },
        headers: header);
    return response as Map<String, dynamic>;
  }

  static Future<Map<String, dynamic>> postBMTTravelInfo({
    required int lpId,
    required int userId,
    required String user,
    required String firstName,
    required String address,
    required String place,
    required String licenseNumber,
    required DriverPosition position,
  }) async {
    final response = await ApiClient().post(ApiRoutes.userProfileUpdate,
        body: {
          "first_name": firstName,
          "lp_id": lpId,
          "user_id": userId,
          "user": user,
          "address": address,
          "place": place,
          "latitude": position.latitude,
          "longitude": position.longitude,
          "license_number": licenseNumber,
        },
        headers: header);
    return response as Map<String, dynamic>;
  }

  static Future<Map<String, dynamic>> uploadDriverId({
    required PostProfileData params,
    required String frontImagePath,
    required String backImagePath,
    ListOfDocuments? listOfDocuments,
  }) async {
    String frontVariableName = "";
    String backVariableName = "";

    if (listOfDocuments == ListOfDocuments.aadhar) {
      frontVariableName = "aadhar_front_image";
      backVariableName = "aadhar_back_image";
    } else if (listOfDocuments == ListOfDocuments.dl) {
      frontVariableName = "dl_front_image";
      backVariableName = "dl_back_image";
    }

    var data = FormData.fromMap({
      "files": [
        await MultipartFile.fromFile(frontImagePath,
            filename: frontVariableName),
        await MultipartFile.fromFile(backImagePath, filename: backVariableName)
      ],
      // 'user_data': '"{\\"lp_id\\":${params.lpId},\\"user_id\\":${params.userId},\\"country_code\\":\\"${params.countryCode}\\",\\"phone_number\\":\\"${params.phoneNumber}\\",\\"user\\":\\"${params.user}\\"}"'
      'user_data': params.toJson(),
    });

    final response = await ApiClient().post(
      "${ApiRoutes.baseUrlV1}user/files/upload",
      body: data,
      headers: {'Content-Type': 'multipart/form-data'},
    );

    return response as Map<String, dynamic>;
  }
}
