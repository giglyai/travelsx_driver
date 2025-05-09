import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../../shared/local_storage/user_repository.dart';
import '../models/earning_filter_model.dart';
import '../models/earning_model.dart';
import '../repository/earning_repository.dart';
part 'earning_state.dart';

class EarningCubit extends Cubit<EarningState> {
  EarningCubit() : super(EarningInitial());

  EarningModel? earningModel;

  EarningFilterModel? earningFilterModel;

  Future<void> getEarningData({String? dateFilter}) async {
    emit(EarningLoadingState());

    try {
      final response = await EarningRepository.getEarningData(
          lpId: UserRepository.getLpID,
          userId: UserRepository.getUserID,
          dateFilter: dateFilter ?? "Today",
          user: UserRepository.getProfile,
          dateRange: "",
          offset: 0,
          limit: 10);

      if (response['data'] is String) {
        emit(EarningEmptyState(emptyMessage: response['data']));
      } else {
        earningModel = EarningModel.fromJson(response);
        if (earningModel?.data != null) {
          emit(GotEarningSuccessState(earningModel: earningModel!));
        }
      }
    } catch (e) {
      emit(EarningFailureState(errorMessage: ""));
    }
  }

  Future<void> getFilterData({String? dateFilter}) async {
    emit(EarningLoadingState());
    try {
      final response = await EarningRepository.getEarningData(
          lpId: UserRepository.getLpID,
          userId: UserRepository.getUserID,
          user: UserRepository.getProfile,
          dateFilter: dateFilter ?? "Today",
          dateRange: "",
          offset: 0,
          limit: 10);

      if (response['data'] is String) {
        emit(EarningEmptyState(emptyMessage: response['data']));
      } else {
        earningFilterModel = EarningFilterModel.fromJson(response);
        if (earningFilterModel?.data != null) {
          emit(GotFilterEarningSuccessState(
              earningFilterModel: earningFilterModel!));
        }
      }
    } catch (e) {
      emit(EarningFailureState(errorMessage: ""));
    }
  }

  void selectBase(int selectedBaseIndex) {
    emit(GotEarningSelectedBase(selectedBaseIndex: selectedBaseIndex));
  }
}
