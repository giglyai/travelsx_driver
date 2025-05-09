part of 'my_agency_cubit.dart';

@immutable
abstract class MyAgencyState {}

class MyAgencyInitial extends MyAgencyState {}

class MyAgencySuccess extends MyAgencyState {
  final MyAgency myAgency;

  MyAgencySuccess({required this.myAgency});
}

class MyAgencyFailure extends MyAgencyState {
  final String errorMessage;

  MyAgencyFailure({required this.errorMessage});
}

class GetAgencyLoading extends MyAgencyState {}



class GetAgencyLocationSuccess extends MyAgencyState {
  MyAgency? myAgency;

  GetAgencyLocationSuccess({this.myAgency});
}

class GetAgencyLocationFailure extends MyAgencyState {}

class GetAgencyLocationEmpty extends MyAgencyState {
  String? emptyMessage;

  GetAgencyLocationEmpty({this.emptyMessage});
}

class AgencyRemoveSuccess extends MyAgencyState {
  String? message;

  AgencyRemoveSuccess({this.message});
}