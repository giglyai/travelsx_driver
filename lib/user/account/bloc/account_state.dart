part of 'account_cubit.dart';

@immutable
abstract class AccountState {}

class AccountInitial extends AccountState {}

class AccountLoading extends AccountState {}

class AccountSuccessState extends AccountState {
  final String message;

  AccountSuccessState({required this.message});
}

class AccountFailure extends AccountState {
  final String errorMessage;

  AccountFailure({required this.errorMessage});
}

class AccountProfileLoading extends AccountState {}

class AccountProfileSuccessState extends AccountState {
  final GetUserProfileData getUserProfileData;

  AccountProfileSuccessState({required this.getUserProfileData});
}

class AccountProfileFailure extends AccountState {
  final String errorMessage;

  AccountProfileFailure({required this.errorMessage});
}

class VehicleLoading extends AccountState {}

class VehicleLoadingSuccessState extends AccountState {
  final VehicleListModel vehicleInformationList;

  VehicleLoadingSuccessState({required this.vehicleInformationList});
}

class VehicleFailure extends AccountState {
  final String errorMessage;

  VehicleFailure({required this.errorMessage});
}

class ProfileUploadLoading extends AccountState {}

class ProfileUploadSuccessState extends AccountState {
  final String message;
  ProfileUploadSuccessState({required this.message});
}

class ProfileUpdateFailure extends AccountState {
  final String errorMessage;

  ProfileUpdateFailure({required this.errorMessage});
}

class DriverDocUploadSuccess extends AccountState {
  final String message;

  DriverDocUploadSuccess({required this.message});
}

class AccountDeleteLoading extends AccountState {}
class AccountDeleteSuccessState extends AccountState {
  final AccountDeleteRes accountDeleteRes;

  AccountDeleteSuccessState({required this.accountDeleteRes});
}

class AccountDeleteFailure extends AccountState {
  final String errorMessage;

  AccountDeleteFailure({required this.errorMessage});
}



class ProfileBackUploadLoading extends AccountState {}

class ProfileBackUploadSuccessState extends AccountState {
  final ProfileImageBackRes? profileImageBackRes;
  ProfileBackUploadSuccessState({this.profileImageBackRes});
}

class ProfileBackUpdateFailure extends AccountState {
  final String errorMessage;

  ProfileBackUpdateFailure({required this.errorMessage});
}





class VehicleInfoLoading extends AccountState {}

class VehicleInfoSuccessState extends AccountState {
  final String message;

  VehicleInfoSuccessState({required this.message});
}

class VehicleInfoFailure extends AccountState {
  final String errorMessage;

  VehicleInfoFailure({required this.errorMessage});
}