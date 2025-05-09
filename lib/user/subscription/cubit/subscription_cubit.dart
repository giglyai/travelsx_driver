import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../../shared/local_storage/user_repository.dart';
import '../data/subscription.data.dart';
import '../entity/subscription_res.dart';
part 'subscription_state.dart';

class SubscriptionCubit extends Cubit<SubscriptionState> {
  SubscriptionCubit() : super(SubscriptionInitial());

  SubscriptionRes? subscriptionRes;

  Future<void> getSubscriptionData({String? dateFilter}) async {
    emit(SubscriptionLoadingState());

    try {
      final response = await SubscriptionData.getSubscriptionData(
        lpId: UserRepository.getLpID,
        userId: UserRepository.getUserID,
        user: UserRepository.getProfile,
      );

      if (response['data'] is String) {
        //emit(EarningEmptyState(emptyMessage: response['data']));
      } else {
        subscriptionRes = SubscriptionRes.fromJson(response);
        if (subscriptionRes?.data != null) {
          emit(GotSubscriptionSuccessState(subscriptionRes: subscriptionRes!));
        }
      }
    } catch (e) {
      emit(SubscriptionFailureState(errorMessage: ""));
    }
  }
}
