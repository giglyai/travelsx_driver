// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:travelx_driver/login/entity/country_list/country_list.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {}

class LoginFailure extends LoginState {
  String? errorMessage;

  LoginFailure({this.errorMessage});
}

class UserIsNewSuccess extends LoginState {
  UserIsNewSuccess();
}

class PhoneNumberLoading extends LoginState {}

class PhoneNumberSuccess extends LoginState {
  String? message;

  PhoneNumberSuccess({this.message});
}

class PhoneNumberFailure extends LoginState {
  String? errorMessage;

  PhoneNumberFailure({this.errorMessage});
}

class OtpLoading extends LoginState {}

class OtpSuccess extends LoginState {
  String? message;

  OtpSuccess({this.message});
}

class OtpFailure extends LoginState {
  String? errorMessage;

  OtpFailure({this.errorMessage});
}

class CountryCodeLoading extends LoginState {}

// class GotCountryCode extends LoginState {
//   GetCountryCodeRes? countryCodeModel;
//
//   GotCountryCode({this.countryCodeModel});
// }

class GotCountryCode extends LoginState {
  CountryCodeList? countryCodeModel;

  GotCountryCode({this.countryCodeModel});
}

class GotCountryCodeFailure extends LoginState {
  String? errorMessage;

  GotCountryCodeFailure({this.errorMessage});
}
