import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'log_in_status.dart';

class AuthRepository {
  AuthRepository._();

  /// Cached instance of [AuthRepository];
  static AuthRepository? _instance;

  static AuthRepository get instance {
    _instance ??= AuthRepository._();
    return _instance!;
  }

  Future<void> init() async {
    //Initialise tokens from secure storage
    refreshToken = await _refreshToken;
    accessToken = await _accessToken;
  }

  static String? refreshToken;
  static String? accessToken;

  Future<String?> get _refreshToken async {
    return await LogInStatus().getUserToken();
  }

  Future<String?> get _accessToken async {
    return await LogInStatus().getUserToken();
  }

  Future<void> setRefreshToken(String token) async {
    refreshToken = token;
  }

  Future<void> setAccessToken(String token) async {
    accessToken = token;
    return await LogInStatus.setUserToken(token: token);
  }

  Future<void> clearAccessToken() async {
    return await logOutUser();
  }

  bool isUserLoggedIn() {
    return accessToken != null && (accessToken?.isNotEmpty == true);
  }

  static bool get isLoggedIn {
    return accessToken != null;
  }

  Future<void> logOutUser() async {
    FlutterSecureStorage storage = const FlutterSecureStorage();
    //logOutUser
    await storage.delete(key: 'auth_token');

    accessToken = null;
    refreshToken = null;
  }
}
