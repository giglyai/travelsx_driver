part of 'notification_cubit.dart';

@immutable
abstract class NotificationState {}

class NotificationInitial extends NotificationState {}

class RecentNotificationLoading extends NotificationState {}

class NotificationEmptyState extends NotificationState {
  final String emptyMessage;

  NotificationEmptyState({required this.emptyMessage});
}

class RecentNotificationSuccess extends NotificationState {
  final NotificationsModel notificationsModel;

  RecentNotificationSuccess({required this.notificationsModel});
}

class RecentNotificationFailure extends NotificationState {
  final String errorMessage;

  RecentNotificationFailure({required this.errorMessage});
}

class GetAllNotificationLoading extends NotificationState {}

class GetAllNotificationSuccess extends NotificationState {
  final NotificationsModel notificationsModel;

  GetAllNotificationSuccess({required this.notificationsModel});
}

class GetAllNotificationFailure extends NotificationState {
  final String errorMessage;

  GetAllNotificationFailure({required this.errorMessage});
}
