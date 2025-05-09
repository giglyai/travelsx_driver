import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../../shared/api_client/api_exception.dart';

import '../../../shared/local_storage/log_in_status.dart';
import '../../../shared/local_storage/user_repository.dart';
import '../models/trip_filter_model.dart';
import '../models/trip_single_model.dart';
import '../repository/trip_repository.dart';

part 'trip_state.dart';

class TripCubit extends Cubit<TripState> {
  TripCubit() : super(TripInitial());

  TripSingleModel? tripSingleModel;

  TripFilterModel? tripFilterModel;
  LogInStatus getUserData = LogInStatus();

  Future<void> getSingleTripData(
      {String? dateFilter, String? tripStatus}) async {
    emit(TripLoadingState());
    try {
      final response = await TripRepository.getSingleTripData(
        tripStatus: tripStatus ?? 'booked',
        lpId: UserRepository.getLpID,
        userId: UserRepository.getUserID,
        dateFilter: dateFilter ?? "Today",
      );
      if (response['data'] is String) {
        emit(TripEmptyState(emptyMessage: response['data']));
      } else {
        tripSingleModel = TripSingleModel.fromJson(response);
        if (tripSingleModel?.data != null) {
          emit(GotTripSuccessState(tripSingleModel: tripSingleModel!));
        }
      }
    } catch (e) {
      emit(TripFailureState(errorMessage: ""));
    }
  }

  Future<void> getFilterData({String? dateFilter, String? tripStatus}) async {
    emit(TripLoadingState());
    try {
      final response = await TripRepository.getSingleTripData(
        tripStatus: tripStatus ?? 'booked',
        lpId: UserRepository.getLpID,
        userId: UserRepository.getUserID,
        dateFilter: dateFilter ?? "Today",
      );

      if (response['data'] is String) {
        emit(TripEmptyState(emptyMessage: response['data']));
      } else {
        tripFilterModel = TripFilterModel.fromJson(response);
        if (tripFilterModel?.data != null) {
          emit(GotFilterTripSuccessState(tripFilterModel: tripFilterModel!));
        }
      }
    } catch (e) {
      emit(TripFailureState(errorMessage: ""));
    }
  }

  void selectBase(int selectedBaseIndex) {
    emit(GotTripSelectedBase(selectedBaseIndex: selectedBaseIndex));
  }
}
