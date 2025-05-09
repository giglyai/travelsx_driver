part of 'wallet_cubit.dart';

@immutable
abstract class WalletState {}

class WalletInitial extends WalletState {}

class WalletLoadingState extends WalletState {}

class WalletEmptyState extends WalletState {
  final String emptyMessage;

  WalletEmptyState({required this.emptyMessage});
}

class GotWalletSuccessState extends WalletState {
  final WalletModel walletModel;

  GotWalletSuccessState({required this.walletModel});
}

class WalletFailureState extends WalletState {
  final String errorMessage;

  WalletFailureState({required this.errorMessage});
}
