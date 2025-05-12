import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:travelx_driver/global_variables.dart';
import 'package:travelx_driver/home/revamp/bloc/main_home_cubit.dart';
import 'package:travelx_driver/login/entity/country_list/country_list.dart';
import 'package:travelx_driver/login/screen/verify_bottomsheet/verify_bottomsheet.dart';
import 'package:travelx_driver/login/screen/verify_otp_screen.dart';
import 'package:travelx_driver/main.dart';
import 'package:travelx_driver/shared/constants/app_name/app_name.dart';
import 'package:travelx_driver/shared/local_storage/auth_repository.dart';
import 'package:travelx_driver/shared/local_storage/log_in_status.dart';
import 'package:travelx_driver/shared/local_storage/user_repository.dart';
import 'package:travelx_driver/shared/routes/named_routes.dart';
import 'package:travelx_driver/user/user_details/user_details_data.dart';

import '../../../../shared/api_client/api_exception.dart';

import '../data/login_data.dart';
import '../entity/country_code_model.dart';
import '../entity/otp_model.dart';
import '../entity/otp_response_model.dart';
import 'login_state.dart';

/// A Cubit for handling user login, OTP verification, and country code fetching.
class ServiceLoginCubit extends Cubit<LoginState> {
  ServiceLoginCubit() : super(LoginInitial());

  String? errorMessage;
  OtpModel? otpModel;
  OtpModelResponse? otpModelResponse;
  CountryCodeModel? countryCodeModel;

  /// Initiates login with mobile number. Fetches OTP and navigates to OTP verification screen.
  Future<void> loginWithMobileNumber({
    String? countryCode,
    String? phoneNumber,
    String? email,
    int? passcode,
  }) async {
    emit(PhoneNumberLoading()); // Show loading state

    try {
      final response = await LoginData.loginWithMobileNumber(
        countryCode,
        phoneNumber,
        email,
        passcode,
      );

      if (response['status'] == "success") {
        otpModel = OtpModel.fromJson(response);

        // Emit success and navigate to OTP screen
        emit(PhoneNumberSuccess(message: otpModel?.data ?? ""));
        Navigator.pushNamed(
          navigatorKey.currentState!.context,
          RouteName.verifyOtpScreen,
          arguments: VerifyOtpScreen(
            countryCode: countryCode ?? "91", // Default country code
            mobileController: phoneNumber ?? "", // Default phone number
            email: email ?? "",
          ),
        );
      }
    } on ApiException catch (e, stackTrace) {
      //Utils.logErrorToCrashlyticsAndBackend(e, stackTrace);

      // Emit failure if OTP verification fails
      emit(PhoneNumberFailure(errorMessage: ""));
    } catch (e, stackTrace) {
      //Utils.logErrorToCrashlyticsAndBackend(e, stackTrace);
      // Emit failure if the request fails
      emit(PhoneNumberFailure(errorMessage: ""));
    }
  }

  /// Initiates login with mobile number. Fetches OTP and navigates to OTP verification screen.
  Future<void> bottomSheetLoginWithMobileNumber({
    String? countryCode,
    String? phoneNumber,
    String? email,
    int? passcode,
  }) async {
    emit(PhoneNumberLoading()); // Show loading state

    try {
      // Request OTP using the phone number and country code
      final response = await LoginData.loginWithMobileNumber(
        countryCode,
        phoneNumber,
        email,
        passcode,
      );

      if (response['status'] == "success") {
        otpModel = OtpModel.fromJson(response);

        // Emit success before showing the bottom sheet
        emit(PhoneNumberSuccess(message: otpModel?.data ?? ""));

        // Ensure context is safe
        final BuildContext? context = navigatorKey.currentContext;
        if (context != null) {
          VerifyOtpBottomSheetHelper.show(
            context,
            countryCode ?? "",
            phoneNumber ?? "",
            email ?? "",
          );
        } else {
          debugPrint("Navigator context is null, cannot show bottom sheet.");
        }
      } else {
        emit(
          PhoneNumberFailure(
            errorMessage: response['message'] ?? "OTP request failed",
          ),
        );
      }
    } on ApiException catch (e, stackTrace) {
      //Utils.logErrorToCrashlyticsAndBackend(e, stackTrace);
      emit(PhoneNumberFailure(errorMessage: e.message ?? "An error occurred"));
    } catch (e, stackTrace) {
      //Utils.logErrorToCrashlyticsAndBackend(e, stackTrace);
      emit(
        PhoneNumberFailure(
          errorMessage: "Something went wrong, please try again",
        ),
      );
    }
  }

  /// Verifies the OTP and handles both new and existing users.
  /// Verifies the OTP and handles both new and existing users.
  Future<void> verifyOtp({
    String? countryCode,
    String? phoneNumber,
    String? email,
    String? otp,
    String? clientToken,
    String? playerId,
    String? user,
    String? appName,
    required String platForm,
  }) async {
    emit(OtpLoading()); // Show loading state

    try {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      final deviceInfoPlugin = DeviceInfoPlugin();
      final deviceInfo = await deviceInfoPlugin.deviceInfo;
      final allInfo = deviceInfo.data;

      final userType = AppNames.appName;

      final appName = packageInfo.appName;
      final appVersion = packageInfo.version;

      final deviceOS = Platform.operatingSystem;
      final deviceOSversion = int.tryParse(allInfo['version']['release']) ?? 0;
      final deviceModel =
          "${allInfo['brand'] ?? ''} ${allInfo['device'] ?? ''}";
      final createIsoTime = DateTime.now().toIso8601String();

      // Verify the OTP with the provided data
      final response = await LoginData.verifyOtp(
        platform: platForm,
        clientToken: clientToken ?? "",
        countryCode: countryCode ?? "",
        phoneNumber: phoneNumber ?? "",
        email: email ?? "",
        deviceToken: UserRepository.getDeviceToken,
        otp: otp ?? "",
        user: user ?? "",
        appName: appName ?? "",
        userType: userType,
        appVersion: appVersion,
        deviceOS: deviceOS,
        deviceOSversion: deviceOSversion,
        deviceModel: deviceModel,
        createIsoTime: createIsoTime,
      );

      if (response['status'] == "success") {
        otpModelResponse = OtpModelResponse.fromJson(response);

        // Check if the user is new or existing
        if (otpModelResponse?.data?.user?.isNewUser == true) {
          var token = otpModelResponse?.data?.authToken ?? "";
          var phoneNumber = otpModelResponse?.data?.user?.phoneNumber ?? "";
          var lpId = otpModelResponse?.data?.lp?.id.toString() ?? "";
          var userId = otpModelResponse?.data?.user?.id.toString() ?? "";
          var userProfile = 'ride';
          var countryCode =
              otpModelResponse?.data?.user?.countryCode.toString() ?? "";
          bool? isSubscribed =
              otpModelResponse?.data?.user?.isSubscribed ?? false;

          if (kDebugMode) {
            print("userId $userId");
          }

          // Save user data to local storage
          await setUserLocalStorage(
            isSubscribed: isSubscribed.toString(),
            token: token,
            userId: userId,
            lpId: lpId,
            phoneNumber: phoneNumber,
            countryCode: countryCode,
            userProfile: userProfile,
          );

          // Set access data for user
          UserRepository.instance.setAccessProfile(userProfile);
          UserRepository.instance.setAccessPhoneNumber(phoneNumber);
          UserRepository.instance.setAccessUserID(userId);
          UserRepository.instance.setAccessCountryCode(countryCode);
          UserRepository.instance.setAccessLpID(lpId);
          // UserRepository.instance.setIsUserIsSubscribed(
          //   isSubscribed.toString(),
          // );
          AuthRepository.instance.setAccessToken(token);

          // Initialize repositories
          AuthRepository.instance.init();
          UserRepository.instance.init();
          ProfileRepository.instance.init();

          // Emit success state for new user
          emit(UserIsNewSuccess());

          Navigator.pushNamedAndRemoveUntil(
            navigatorKey.currentState!.context,
            RouteName.travelBottomNavigationBar,
            (f) => false,
          );
        } else {
          // Handle existing user
          var token = otpModelResponse?.data?.authToken ?? "";
          var phoneNumber = otpModelResponse?.data?.user?.phoneNumber ?? "";
          var lpId = otpModelResponse?.data?.lp?.id.toString() ?? "";
          var userId = otpModelResponse?.data?.user?.id.toString() ?? "";
          var userProfile = 'ride';
          var countryCode =
              otpModelResponse?.data?.user?.countryCode.toString() ?? "";
          bool? isSubscribed =
              otpModelResponse?.data?.user?.isSubscribed ?? false;

          if (kDebugMode) {
            print("userId $userId");
          }

          // Save user data to local storage
          await setUserLocalStorage(
            isSubscribed: isSubscribed.toString(),
            token: token,
            userId: userId,
            lpId: lpId,
            phoneNumber: phoneNumber,
            countryCode: countryCode,
            userProfile: userProfile,
          );

          // Set access data for user
          UserRepository.instance.setAccessProfile(userProfile);
          UserRepository.instance.setAccessPhoneNumber(phoneNumber);
          UserRepository.instance.setAccessUserID(userId);
          UserRepository.instance.setAccessCountryCode(countryCode);
          UserRepository.instance.setAccessLpID(lpId);
          // UserRepository.instance.setIsUserIsSubscribed(
          //   isSubscribed.toString(),
          // );
          AuthRepository.instance.setAccessToken(token);

          // Initialize repositories
          AuthRepository.instance.init();
          UserRepository.instance.init();
          ProfileRepository.instance.init();

          // Emit success state for existing user
          emit(OtpSuccess());

          Navigator.pushNamedAndRemoveUntil(
            navigatorKey.currentState!.context,
            RouteName.travelBottomNavigationBar,
            (f) => false,
          );
        }
      }
    } on ApiException catch (e, stackTrace) {
      // Emit failure if OTP verification fails
      emit(OtpFailure(errorMessage: "Failed, verify OTP to $phoneNumber"));
    } catch (e, stackTrace) {
      // Emit failure if OTP verification fails
      emit(OtpFailure(errorMessage: "Failed, verify OTP to $phoneNumber"));
    }
  }

  /// Verifies the OTP and handles both new and existing users.
  Future<void> bottomSheetVerifyOtp({
    String? countryCode,
    String? phoneNumber,
    String? otp,
    String? clientToken,
    String? playerId,
    String? user,
    String? appName,
    String? email,
    required String platForm,
  }) async {
    emit(OtpLoading()); // Show loading state

    try {
      // Verify the OTP with the provided data
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      final deviceInfoPlugin = DeviceInfoPlugin();
      final deviceInfo = await deviceInfoPlugin.deviceInfo;
      final allInfo = deviceInfo.data;

      final userType = AppNames.appName;

      final appName = packageInfo.appName;
      final appVersion = packageInfo.version;

      final deviceOS = Platform.operatingSystem;
      final deviceOSversion = int.tryParse(allInfo['version']['release']) ?? 0;
      final deviceModel =
          "${allInfo['brand'] ?? ''} ${allInfo['device'] ?? ''}";
      final createIsoTime = DateTime.now().toIso8601String();

      // Verify the OTP with the provided data
      final response = await LoginData.verifyOtp(
        platform: platForm,
        clientToken: clientToken ?? "",
        countryCode: countryCode ?? "",
        phoneNumber: phoneNumber ?? "",
        email: email ?? "",
        deviceToken: UserRepository.getDeviceToken,
        otp: otp ?? "",
        user: user ?? "",
        appName: appName ?? "",
        userType: userType,
        appVersion: appVersion,
        deviceOS: deviceOS,
        deviceOSversion: deviceOSversion,
        deviceModel: deviceModel,
        createIsoTime: createIsoTime,
      );

      if (response['status'] == "success") {
        otpModelResponse = OtpModelResponse.fromJson(response);
        // Handle existing user
        var token = otpModelResponse?.data?.authToken ?? "";
        var phoneNumber = otpModelResponse?.data?.user?.phoneNumber ?? "";
        var lpId = otpModelResponse?.data?.lp?.id.toString() ?? "";
        var userId = otpModelResponse?.data?.user?.id.toString() ?? "";
        var userProfile = 'ride';
        var countryCode =
            otpModelResponse?.data?.user?.countryCode.toString() ?? "";
        bool? isSubscribed =
            otpModelResponse?.data?.user?.isSubscribed ?? false;

        if (kDebugMode) {
          print("userId $userId");
        }

        // Save user data to local storage
        await setUserLocalStorage(
          isSubscribed: isSubscribed.toString(),
          token: token,
          userId: userId,
          lpId: lpId,
          phoneNumber: phoneNumber,
          countryCode: countryCode,
          userProfile: userProfile,
        );

        // Set access data for user
        UserRepository.instance.setAccessProfile(userProfile);
        UserRepository.instance.setAccessPhoneNumber(phoneNumber);
        UserRepository.instance.setAccessUserID(userId);
        UserRepository.instance.setAccessCountryCode(countryCode);
        UserRepository.instance.setAccessLpID(lpId);
        //UserRepository.instance.setIsUserIsSubscribed(isSubscribed.toString());
        AuthRepository.instance.setAccessToken(token);
        // Initialize repositories
        AuthRepository.instance.init();
        UserRepository.instance.init();
        ProfileRepository.instance.init();

        // Emit success state for existing user
        emit(OtpSuccess());
        await navigatorKey.currentState!.context
            .read<MainHomeCubit>()
            .getUserData();
        Navigator.pushNamedAndRemoveUntil(
          navigatorKey.currentState!.context,
          RouteName.travelBottomNavigationBar,
          (f) => false,
        );
      } else if (response['status'] == "error") {
        emit(OtpFailure(errorMessage: "Failed, verify OTP to ${phoneNumber}"));
      }
    } on ApiException catch (e, stackTrace) {
      //Utils.logErrorToCrashlyticsAndBackend(e, stackTrace);

      // Emit failure if OTP verification fails
      emit(OtpFailure(errorMessage: "Failed, verify OTP to ${phoneNumber}"));
    } catch (e, stackTrace) {
      //Utils.logErrorToCrashlyticsAndBackend(e, stackTrace);

      // Emit failure if OTP verification fails
      emit(OtpFailure(errorMessage: "Failed, verify OTP to ${phoneNumber}"));
    }
  }

  // Future<void> getCountryCode() async {
  //   emit(CountryCodeLoading()); // Show loading state
  //   try {
  //     final currentPosition = await Utils.getCurrentLocation();
  //
  //     if (currentPosition == null) {
  //       emit(GotCountryCodeFailure(errorMessage: ""));
  //     }
  //     ;
  //
  //     final response = await LoginData.getCountryCode(
  //         lpId: UserRepository.getLpID ?? "",
  //         userId: UserRepository.getUserID ?? "",
  //         currentPosition: currentPosition);
  //
  //     final countyCodeData = GetCountryCodeRes.fromJson(response);
  //     String? countryCode = countyCodeData?.data?.countryCode;
  //
  //     // Remove '+' from the country code if it exists
  //     if (countryCode != null && countryCode.startsWith('+')) {
  //       countryCode = countryCode.substring(1); // Remove the first character
  //     }
  //
  //     // Save country code in local storage
  //     UserRepository.instance.setAccessCountryCode(countryCode ?? "");
  //     UserRepository.instance.init();
  //
  //     // Emit success with country code data
  //     emit(GotCountryCode(countryCodeModel: countyCodeData));
  //   } on ApiException catch (e) {
  //     // Emit failure if country code fetching fails
  //     emit(GotCountryCodeFailure(errorMessage: e.errorMessage ?? ""));
  //   }
  // }

  /// Fetches the country code based on current location and user info.

  // Future<void> getCountryCode() async {
  //   emit(CountryCodeLoading()); // Show loading state
  //   try {
  //     final response = await LoginData.getCountryCode();
  //
  //     if (response['status'] == "success") {
  //       final countyCodeData = CountryCodeList.fromJson(response);
  //
  //       emit(GotCountryCode(countryCodeModel: countyCodeData));
  //     } else {
  //       emit(GotCountryCodeFailure(errorMessage: ""));
  //     }
  //   } on ApiException catch (e) {
  //     // Emit failure if country code fetching fails
  //     emit(GotCountryCodeFailure(errorMessage: e.errorMessage ?? ""));
  //   }
  // }

  Future<CountryCodeList?> getCountryCode() async {
    emit(CountryCodeLoading()); // Show loading state
    if (countryCodeList != null) {
      Future.delayed(Duration(milliseconds: 50), () {
        emit(GotCountryCode(countryCodeModel: countryCodeList));
      });
      return countryCodeList;
    }
    try {
      final response = await LoginData.getCountryCode();

      if (response['status'] == "success") {
        final countyCodeData = CountryCodeList.fromJson(response);

        emit(GotCountryCode(countryCodeModel: countyCodeData));
        countryCodeList = countyCodeData;
        return countyCodeData;
      } else {
        emit(GotCountryCodeFailure(errorMessage: ""));
      }
    } on ApiException catch (e, stackTrace) {
      //Utils.logErrorToCrashlyticsAndBackend(e, stackTrace);

      emit(GotCountryCodeFailure(errorMessage: e.errorMessage));
    } catch (e, stackTrace) {
      //Utils.logErrorToCrashlyticsAndBackend(e, stackTrace);

      emit(GotCountryCodeFailure(errorMessage: ""));
    }
  }

  /// Sets the user data in local storage after successful login or OTP verification.
  static Future<void> setUserLocalStorage({
    required String token,
    required String userId,
    required String lpId,
    String? userProfile,
    required String phoneNumber,
    required String isSubscribed,
    required String countryCode,
  }) async {
    LogInStatus userHasLoggedIn = LogInStatus();
    await userHasLoggedIn.userHasLoggedIn(
      //isSubscribed: isSubscribed,
      token: token,
      userId: userId,
      lpId: lpId,
      phoneNumber: phoneNumber,
      countryCode: countryCode,
      driverProfile: userProfile,
    );
  }
}
