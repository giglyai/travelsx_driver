import 'package:travelx_driver/shared/api_client/api_client.dart';
import 'package:travelx_driver/shared/constants/app_name/app_name.dart';
import 'package:travelx_driver/shared/routes/api_routes.dart';

class AddVehicleData {
  static Future<Map<String, dynamic>> getTravelCarList({
    required String lpId,
    required String userId,
  }) async {
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };

    var params = {
      "lp_id": lpId,
      "user_id": userId,
      // "user_id": lpId,
      "user": AppNames.appName,
    };

    final response = await ApiClient().get(
      ApiRoutes.getTravelCarList,
      queryParams: params,
      headers: requestHeaders,
    );

    return response as Map<String, dynamic>;
  }

  static Future<Map<String, dynamic>> sendOtp(
      {required String lpId,
      required String userId,
      required String user,
      String? countryCode,
      String? phoneNumber}) async {
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
    final response = await ApiClient().post(ApiRoutes.otpLogin,
        body: {
          "lp_id": lpId,
          "user_id": userId,
          "user": user,
        },
        headers: requestHeaders);
    return response as Map<String, dynamic>;
  }

  static Future<Map<String, dynamic>> travelVerifyVehicleOtp({
    required String lpId,
    required String userId,
    required String user,
    required String otp,
  }) async {
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };

    var body = {
      "lp_id": lpId,
      "user_id": userId,
      "user": user,
      "otp": otp,
    };

    final response = await ApiClient().post(
      ApiRoutes.travelVerifyVehicleOtp,
      body: body,
      headers: requestHeaders,
    );

    return response as Map<String, dynamic>;
  }

  static Future<Map<String, dynamic>> postVehicleData({
    required String lpId,
    required String userId,
    required String firstName,
    required String countryCode,
    required String phoneNumber,
    required String vehicleType,
    required String vehicleModel,
    required String vehicleNumber,
  }) async {
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
    var body = {
      "lp_id": lpId,
      "user_id": userId,
      "user": AppNames.appName,
      "first_name": firstName,
      "country_code": countryCode,
      "phone_number": phoneNumber,
      "vehicle_type": vehicleType,
      "vehicle_model": vehicleModel,
      "vehicle_number": vehicleNumber,
    };

    final response = await ApiClient().post(
      ApiRoutes.postVehicleData,
      body: body,
      headers: requestHeaders,
    );

    return response as Map<String, dynamic>;
  }

  static Future<Map<String, dynamic>> getProfileData({
    required lpId,
    required userId,
  }) async {
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
    final queryData = {
      "lp_id": lpId,
      "user_id": userId,
      "user": AppNames.appName,
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
    required String phoneNumber,
    required String countryCode,
  }) async {
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
    final queryData = {
      "lp_id": lpId,
      // "lp_id": "116000",
      "user_id": userId,
      "user": AppNames.appName
    };

    final response = await ApiClient().get(
      ApiRoutes.getUserVehicleData,
      headers: requestHeaders,
      queryParams: queryData,
    );
    return response as Map<String, dynamic>;
  }

  static Future<Map<String, dynamic>> addVehicleDetails({
    required int lpId,
    required int userId,
    required String countryCode,
    required String phoneNumber,
    required String vehicleType,
    required String vehicleModel,
    required String vehicleNumber,
    required String userName,
  }) async {
    final response = await ApiClient().post(
      ApiRoutes.userProfileUpdate,
      body: {
        "lp_id": lpId,
        "user_id": userId,
        "first_name": userName,
        "user": AppNames.appName,
        "vehicle_type": vehicleType,
        "vehicle_model": vehicleModel,
        "vehicle_number": vehicleNumber,
      },
    );
    return response as Map<String, dynamic>;
  }
}
