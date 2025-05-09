part of 'trip_cubit.dart';

@immutable
abstract class TripState {}

class TripInitial extends TripState {}

class TripLoadingState extends TripState {}

class TripEmptyState extends TripState {
  final String emptyMessage;

  TripEmptyState({required this.emptyMessage});
}

class GotTripSuccessState extends TripState {
  final TripSingleModel tripSingleModel;

  GotTripSuccessState({
    required this.tripSingleModel,
  });
}

class GotFilterTripSuccessState extends TripState {
  final TripFilterModel tripFilterModel;

  GotFilterTripSuccessState({required this.tripFilterModel});
}

class GotTripSelectedBase extends TripState {
  final int selectedBaseIndex;

  GotTripSelectedBase({required this.selectedBaseIndex});
}

class TripFailureState extends TripState {
  final String errorMessage;

  TripFailureState({required this.errorMessage});
}

class TripCancelledLoadingState extends TripState {}

class GotCancelledTripSuccessState extends TripState {
  final TripSingleModel tripSingleModel;

  GotCancelledTripSuccessState({
    required this.tripSingleModel,
  });
}

class GotCancelledFilterTripSuccessState extends TripState {
  final TripFilterModel tripFilterModel;

  GotCancelledFilterTripSuccessState({required this.tripFilterModel});
}

class GotCancelledTripSelectedBase extends TripState {
  final int selectedBaseIndex;

  GotCancelledTripSelectedBase({required this.selectedBaseIndex});
}

class TripCancelledFailureState extends TripState {
  final String errorMessage;

  TripCancelledFailureState({required this.errorMessage});
}
