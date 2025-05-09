// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../entity/country_code_model.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {}

class LoginFailure extends LoginState {
  String? errorMessage;

  LoginFailure({this.errorMessage});
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

class GotCountryCode extends LoginState {
  CountryCodeModel? countryCodeModel;

  GotCountryCode({this.countryCodeModel});
}

class GotCountryCodeFailure extends LoginState {
  String? errorMessage;

  GotCountryCodeFailure({this.errorMessage});
}
