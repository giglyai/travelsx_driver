part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class RiderToggleLoadingState extends HomeState {}

class ConfirmButtonEnable extends HomeState {
  final bool isEnable;
  ConfirmButtonEnable({required this.isEnable});
}

class GetTripSettlementAmount extends HomeState {
  final String settlementAmount;

  final String pickupAddress;
  final String dropupAddress;
  final String currency;

  GetTripSettlementAmount({
    required this.settlementAmount,
    required this.pickupAddress,
    required this.dropupAddress,
    required this.currency,
  });
}

class UpdateRiderAvailability extends HomeState {
  final bool isRiderAvailable;

  UpdateRiderAvailability({required this.isRiderAvailable});
}

class TripMetricsLoading extends HomeState {}

class TripMetricsSuccess extends HomeState {
  final TripMetrics tripMetrics;

  TripMetricsSuccess(this.tripMetrics);
}

class TripMetricsFailure extends HomeState {
  final String message;

  TripMetricsFailure(this.message);
}

class PromotionsLoading extends HomeState {}

class PromotionsSuccess extends HomeState {
  final PromotionModel promotionModel;

  PromotionsSuccess(this.promotionModel);
}

class PromotionsFailure extends HomeState {
  final String message;

  PromotionsFailure(this.message);
}

class GotRideSuccess extends HomeState {
  final List<ride_model.Ride> rides;

  GotRideSuccess(this.rides);
}

class GetRideSummary extends HomeState {}

class GotRidesSuccessIndex extends HomeState {}

class RidesLoading extends HomeState {}

class RidesEmptyData extends HomeState {}

class GotRidesFailure extends HomeState {
  final String message;

  GotRidesFailure(this.message);
}

class GetSelectedRide extends HomeState {
  final int selectedRideIndex;

  GetSelectedRide({required this.selectedRideIndex});
}

class GetRideRemainingTime extends HomeState {
  final int remainingTime;

  GetRideRemainingTime({required this.remainingTime});
}

class MutateRideSuccess extends HomeState {
  final RideStatus rideStatus;

  MutateRideSuccess(this.rideStatus);
}

class MutateHireRideSuccess extends HomeState {
  final RideStatus rideStatus;

  MutateHireRideSuccess(this.rideStatus);
}

class MutateRideFailure extends HomeState {}

class MutateHireRideFailure extends HomeState {}

class MutateOnTripsSuccess extends HomeState {}

class AcceptedByOtherDriver extends HomeState {}

class MutateOnTripsLoading extends HomeState {}

class MutateOnHireTripsSuccess extends HomeState {}

class AcceptedHireByOtherDriver extends HomeState {}

class MutateOnHireTripsLoading extends HomeState {}

class GetDistanceMatrixSuccess extends HomeState {
  final DistanceMatrix distanceMatrix;

  GetDistanceMatrixSuccess({required this.distanceMatrix});
}

class GetTripsFullRouteLoading extends HomeState {}

class GetRidesFullRouteLoading extends HomeState {}

class GetTripsFullRouteSuccess extends HomeState {
  final String routePath;
  final int selectedTripIndex;

  GetTripsFullRouteSuccess(
      {required this.routePath, required this.selectedTripIndex});
}

class GetRidesFullRouteSuccess extends HomeState {
  final String routePath;
  final int selectedRideIndex;

  GetRidesFullRouteSuccess(
      {required this.routePath, required this.selectedRideIndex});
}

class GetTripsFullRouteFailed extends HomeState {}

class GetRidesFullRouteFailed extends HomeState {}

class SuccessUpdateProfile extends HomeState {
  final String message;
  SuccessUpdateProfile({required this.message});
}

class FailureUpdateProfile extends HomeState {
  final String errorMessage;
  FailureUpdateProfile({required this.errorMessage});
}

class DriverBlocInitial extends HomeState {}

class DriverBlocLoading extends HomeState {}

class DriverBlocSuccess extends HomeState {
  final String message;

  DriverBlocSuccess({required this.message});
}

class DriverBlocFailure extends HomeState {}

class SetRateEmit extends HomeState {}

class GotManualRideSuccess extends HomeState {
  final List<ride_model.Ride> manualSearchRides;

  GotManualRideSuccess(this.manualSearchRides);
}

class ManualRidesEmptyData extends HomeState {}

class ManualRidesLoadingData extends HomeState {}

class ManualGotRidesLoading extends HomeState {}

class ManualGotRidesFailure extends HomeState {
  final String message;

  ManualGotRidesFailure(this.message);
}

class MutateRideLoading extends HomeState {}

class AppVersionSuccess extends HomeState {
  final AppVersionRes res;

  AppVersionSuccess({required this.res});
}
