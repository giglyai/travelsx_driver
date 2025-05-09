part of 'earning_cubit.dart';

@immutable
abstract class EarningState {}

class EarningInitial extends EarningState {}

class EarningLoadingState extends EarningState {}

class EarningEmptyState extends EarningState {
  final String emptyMessage;

  EarningEmptyState({required this.emptyMessage});
}

class GotEarningSuccessState extends EarningState {
  final EarningModel earningModel;

  GotEarningSuccessState({
    required this.earningModel,
  });
}

class GotFilterEarningSuccessState extends EarningState {
  final EarningFilterModel earningFilterModel;

  GotFilterEarningSuccessState({required this.earningFilterModel});
}

class GotEarningSelectedBase extends EarningState {
  final int selectedBaseIndex;

  GotEarningSelectedBase({required this.selectedBaseIndex});
}

class EarningFailureState extends EarningState {
  final String errorMessage;

  EarningFailureState({required this.errorMessage});
}
