part of 'promotion_cubit.dart';

@immutable
abstract class PromotionState {}

class PromotionInitial extends PromotionState {}

class ActivePromotionLoading extends PromotionState {}

class GotActivePromotionSuccess extends PromotionState {
  final ActiveCompletedPromotion activeCompletedPromotion;

  GotActivePromotionSuccess({required this.activeCompletedPromotion});
}

class GotPromotionEmptyState extends PromotionState {
  final String message;

  GotPromotionEmptyState({required this.message});
}

class ActivePromotionFailure extends PromotionState {
  final String message;

  ActivePromotionFailure({required this.message});
}

class CompletedPromotionLoading extends PromotionState {}

class GotCompletedPromotionSuccess extends PromotionState {
  final ActiveCompletedPromotion activeCompletedPromotion;

  GotCompletedPromotionSuccess({required this.activeCompletedPromotion});
}

class CompletedPromotionFailure extends PromotionState {
  final String message;

  CompletedPromotionFailure({required this.message});
}
