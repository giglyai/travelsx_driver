import '../../shared/api_client/api_client.dart';
import '../../shared/routes/api_routes.dart';

class LoginData {
  static Future<Map<String, dynamic>> loginUser(
      String? email, String? passWord) async {
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };

    final response = await ApiClient().post(ApiRoutes.login,
        body: {
          "email": email,
          "password": passWord,
        },
        headers: requestHeaders);
    return response as Map<String, dynamic>;
  }

  static Future<Map<String, dynamic>> loginWithMobileNumber(
      String? countryCode, String? phoneNumber) async {
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
    final response = await ApiClient().post(ApiRoutes.otpLogin,
        body: {
          "country_code": countryCode,
          "phone_number": phoneNumber,
        },
        headers: requestHeaders);
    return response as Map<String, dynamic>;
  }

  static Future<Map<String, dynamic>> verifyOtp(
      {required String platform,
      required String user,
      String? deviceToken,
      required String clientToken,
      String? playerId,
      required String countryCode,
      required String phoneNumber,
      required String otp,
      required String appName}) async {
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };

    final response = await ApiClient().post(ApiRoutes.otpVerify,
        body: {
          "platform": platform,
          "client_token": clientToken,
          "device_token": deviceToken,
          "player_id": playerId,
          "country_code": countryCode,
          "phone_number": phoneNumber,
          "otp": otp,
          "user": user,
          "app_name": appName
        },
        headers: requestHeaders);
    return response as Map<String, dynamic>;
  }

  static Future<Map<String, dynamic>> getCountryCode() async {
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
    const url =
        "https://api.geoapify.com/v1/ipinfo?&apiKey=49cad3b4c4f244e08e390bf483a264d2";

    final response = await ApiClient().get(
      url,
      headers: requestHeaders,
    );

    return response as Map<String, dynamic>;
  }
}
