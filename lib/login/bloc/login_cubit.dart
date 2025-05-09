import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelx_driver/shared/local_storage/auth_repository.dart';

import '../../shared/api_client/api_exception.dart';
import '../../shared/local_storage/log_in_status.dart';
import '../../shared/local_storage/user_repository.dart';
import '../data/login_data.dart';
import '../entity/country_code_model.dart';
import '../entity/otp_model.dart';
import '../entity/otp_response_model.dart';
import 'login_state.dart';

class ServiceLoginCubit extends Cubit<LoginState> {
  ServiceLoginCubit() : super(LoginInitial());

  String? errorMessage;
  OtpModel? otpModel;
  OtpModelResponse? otpModelResponse;
  CountryCodeModel? countryCodeModel;

  Future<void> loginWithMobileNumber(
      {String? countryCode, String? phoneNumber}) async {
    emit(PhoneNumberLoading());

    try {
      final response =
          await LoginData.loginWithMobileNumber(countryCode, phoneNumber);

      if (response['status'] == "success") {
        otpModel = OtpModel.fromJson(response);
        emit(PhoneNumberSuccess(message: otpModel?.data.toString() ?? ""));
      }
    } catch (e) {
      emit(PhoneNumberFailure(errorMessage: "".toString()));
    }
  }

  Future<void> verifyOtp(
      {String? platform,
      String? countryCode,
      String? phoneNumber,
      String? otp,
      String? clientToken,
      String? playerId,
      String? user,
      String? appName}) async {
    emit(OtpLoading());

    try {
      final response = await LoginData.verifyOtp(
          platform: platform ?? "",
          user: user ?? "",
          clientToken: clientToken ?? "",
          countryCode: countryCode ?? "",
          phoneNumber: phoneNumber ?? "",
          otp: otp ?? "",
          deviceToken: UserRepository.getDeviceToken,
          appName: appName ?? "");

      if (response['status'] == "success") {
        otpModelResponse = OtpModelResponse.fromJson(response);
        var token = otpModelResponse?.data?.authToken ?? "";
        var phoneNumber = otpModelResponse?.data?.user?.phoneNumber ?? "";
        var lpId = otpModelResponse?.data?.lp?.id.toString() ?? "";
        var userId = otpModelResponse?.data?.user?.id.toString() ?? "";
        var userProfile = otpModelResponse?.data?.userProfile ?? "";

        var countryCode =
            otpModelResponse?.data?.user?.countryCode.toString() ?? "";

        if (kDebugMode) {
          print("userId $userId");
        }
        setUserLocalStorage(
            token: token,
            userId: userId,
            lpId: lpId,
            phoneNumber: phoneNumber,
            countryCode: countryCode,
            userProfile: userProfile);

        UserRepository.instance.setAccessProfile(userProfile);
        UserRepository.instance.setAccessPhoneNumber(phoneNumber);
        UserRepository.instance.setAccessUserID(userId);
        UserRepository.instance.setAccessCountryCode(countryCode);
        UserRepository.instance.setAccessLpID(lpId);
        AuthRepository.instance.setAccessToken(token);
        AuthRepository.instance.init();
        UserRepository.instance.init();

        emit(OtpSuccess());
      }
    } catch (e) {
      emit(OtpFailure(errorMessage: "Failed, verify OTP to $phoneNumber"));
    }
  }

  Future<void> getCountryCode() async {
    emit(CountryCodeLoading());
    try {
      final response = await LoginData.getCountryCode();

      countryCodeModel = CountryCodeModel.fromJson(response);
      UserRepository.instance
          .setAccessCountry(countryCodeModel?.country?.currency ?? "");
      UserRepository.instance.init();

      emit(GotCountryCode(countryCodeModel: countryCodeModel));
    } on ApiException catch (e) {
      emit(GotCountryCodeFailure(errorMessage: e.errorMessage ?? ""));
    }
  }

  static void setUserLocalStorage(
      {required String token,
      required String userId,
      required String lpId,
      String? userProfile,
      required String phoneNumber,
      required String countryCode}) {
    LogInStatus userHasLoggedIn = LogInStatus();
    userHasLoggedIn.userHasLoggedIn(
        token: token,
        userId: userId,
        lpId: lpId,
        phoneNumber: phoneNumber,
        countryCode: countryCode,
        driverProfile: userProfile);
  }
}
