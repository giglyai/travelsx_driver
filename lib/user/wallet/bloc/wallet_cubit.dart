import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../../shared/local_storage/user_repository.dart';
import '../models/wallet_model.dart';
import '../repository/wallet_repository.dart';
part 'wallet_state.dart';

class WalletCubit extends Cubit<WalletState> {
  WalletCubit() : super(WalletInitial());
  WalletModel? walletModel;

  Future<void> getWalletData({String? dateFilter}) async {
    emit(WalletLoadingState());
    try {
      final response = await WalletRepository.getWalletData(
        lpId: UserRepository.getLpID,
        userId: UserRepository.getUserID,
        user: 'travelsx-driver',
        dateFilter: dateFilter ?? "This Week",
        // dateRange: "28-05-2023,31-05-2023",
      );

      if (response['data'] is String) {
        emit(WalletEmptyState(emptyMessage: response['data']));
      } else {
        walletModel = WalletModel.fromJson(response);
        if (walletModel?.data != null) {
          emit(GotWalletSuccessState(walletModel: walletModel!));
        }
      }
    } catch (e) {
      emit(WalletFailureState(errorMessage: ""));
    }
  }
}
