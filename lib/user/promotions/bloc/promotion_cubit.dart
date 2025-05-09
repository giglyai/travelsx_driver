import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../../shared/api_client/api_exception.dart';
import '../../../shared/local_storage/user_repository.dart';
import '../../../shared/utils/utilities.dart';
import '../models/active_completed_promotion.dart';
import '../repository/promotions_repository.dart';

part 'promotion_state.dart';

class PromotionCubit extends Cubit<PromotionState> {
  PromotionCubit() : super(PromotionInitial());

  ActiveCompletedPromotion? activeCompletedPromotion;

  Future<void> fetchActivePromotion() async {
    emit(ActivePromotionLoading());
    try {
      final currentPosition = await Utils.getCurrentLocation();

      final response = await PromotionRepository.activePromotion(
        lpId: UserRepository.getLpID,
        userId: UserRepository.getUserID,
        user: 'driver-ride',
        currentPosition: currentPosition,
        offset: 0,
        limit: 20,
      );

      if (response['data'] is String) {
        emit(GotPromotionEmptyState(message: response['data']));
      } else {
        activeCompletedPromotion = ActiveCompletedPromotion.fromJson(response);
        if (activeCompletedPromotion?.data != null) {
          emit(GotActivePromotionSuccess(
              activeCompletedPromotion: activeCompletedPromotion!));
        }
      }
    } on ApiException catch (e) {
      emit(ActivePromotionFailure(message: e.errorMessage ?? ""));
    }
  }

  Future<void> fetchCompletedPromotion() async {
    emit(CompletedPromotionLoading());
    try {
      final currentPosition = await Utils.getCurrentLocation();
      final response = await PromotionRepository.completedPromotion(
        lpId: UserRepository.getLpID,
        userId: UserRepository.getUserID,
        user: 'driver-ride',
        currentPosition: currentPosition,
        offset: 0,
        limit: 20,
      );

      if (response['data'] is String) {
        emit(GotPromotionEmptyState(message: response['data']));
      } else {
        activeCompletedPromotion = ActiveCompletedPromotion.fromJson(response);
        if (activeCompletedPromotion?.data != null) {
          emit(GotCompletedPromotionSuccess(
              activeCompletedPromotion: activeCompletedPromotion!));
        }
      }
    } catch (e) {
      emit(CompletedPromotionFailure(message: ""));
    }
  }
}
