part of 'subscription_cubit.dart';

@immutable
abstract class SubscriptionState {}

class SubscriptionInitial extends SubscriptionState {}

class SubscriptionLoadingState extends SubscriptionState {}

class SubscriptionEmptyState extends SubscriptionState {
  final String emptyMessage;

  SubscriptionEmptyState({required this.emptyMessage});
}

class GotSubscriptionSuccessState extends SubscriptionState {
  final SubscriptionRes subscriptionRes;

  GotSubscriptionSuccessState({
    required this.subscriptionRes,
  });
}

class SubscriptionFailureState extends SubscriptionState {
  final String errorMessage;

  SubscriptionFailureState({required this.errorMessage});
}
