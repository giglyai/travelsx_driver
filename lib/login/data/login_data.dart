import 'package:travelx_driver/shared/api_client/api_client.dart';
import 'package:travelx_driver/shared/constants/app_name/app_name.dart';
import 'package:travelx_driver/shared/routes/api_routes.dart';

class LoginData {
  static Future<Map<String, dynamic>> loginUser(
    String? email,
    String? passWord,
  ) async {
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };

    final response = await ApiClient().post(
      ApiRoutes.login,
      body: {"email": email, "password": passWord},
      headers: requestHeaders,
    );
    return response as Map<String, dynamic>;
  }

  static Future<Map<String, dynamic>> loginWithMobileNumber(
    String? countryCode,
    String? phoneNumber,
    String? email,
    int? passcode,
  ) async {
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
    final response = await ApiClient().post(
      ApiRoutes.otpLogin,
      body: {
        "country_code": countryCode,
        "phone_number": phoneNumber,
        "email": email,
        "passcode": passcode,
      },
      headers: requestHeaders,
    );
    return response;
  }

  static Future<Map<String, dynamic>> verifyOtp({
    required String clientToken,
    String? deviceToken,
    String? playerId,
    required String countryCode,
    required String phoneNumber,
    required String email,
    required String otp,
    required String user,
    required String appName,
    required String platform,

    required String userType,
    required String appVersion,
    required String deviceOS,
    required int deviceOSversion,
    required String deviceModel,
    required String createIsoTime,
  }) async {
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };

    final response = await ApiClient().post(
      ApiRoutes.otpVerify,
      body: {
        "client_token": clientToken,
        "device_token": deviceToken,
        "country_code": countryCode,
        "phone_number": phoneNumber,
        "email": email,
        "otp": otp,
        "user": user,
        "app_name": appName,
        "platform": platform,
        'user_type': userType,
        'app_version': appVersion,
        'device_os': deviceOS,
        'device_os_v': deviceOSversion,
        'device_model': deviceModel,
        'create_iso_time': createIsoTime,
      },
      headers: requestHeaders,
    );
    return response as Map<String, dynamic>;
  }

  // static Future<Map<String, dynamic>> getCountryCode() async {
  //   Map<String, String> requestHeaders = {
  //     'Content-type': 'application/json',
  //     'Accept': 'application/json',
  //   };
  //   const url =
  //       "https://api.geoapify.com/v1/ipinfo?&apiKey=49cad3b4c4f244e08e390bf483a264d2";
  //
  //   final response = await ApiClient().get(
  //     url,
  //     headers: requestHeaders,
  //   );
  //
  //   return response as Map<String, dynamic>;
  // }

  // static Future<Map<String, dynamic>> getCountryCode({
  //   required String lpId,
  //   required String userId,
  //   required LatLng currentPosition,
  // }) async {
  //   final response =
  //       await ApiClient().get(ApiRoutes.getCountryCode, queryParams: {
  //     'lp_id': lpId,
  //     'user_id': userId,
  //     'user_type': AppNames.appName,
  //     "latitude": currentPosition.latitude,
  //     "longitude": currentPosition.longitude,
  //     // "latitude": 25.2048,
  //     // "longitude": 55.2708,
  //   });
  //   return response as Map<String, dynamic>;
  // }

  static Future<Map<String, dynamic>> getCountryCode() async {
    final response = await ApiClient().get(
      ApiRoutes.getCountryCode,
      queryParams: {'user': AppNames.appName},
    );
    return response as Map<String, dynamic>;
  }
}
