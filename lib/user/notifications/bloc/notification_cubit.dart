import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:travelx_driver/shared/constants/app_name/app_name.dart';

import '../../../shared/api_client/api_exception.dart';
import '../../../shared/local_storage/user_repository.dart';
import '../models/notifications_models.dart';
import '../repository/notifications_repository.dart';
part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit() : super(NotificationInitial());

  NotificationsModel? notificationsModel;

  Future<void> getRecentNotification() async {
    notificationsModel = null;
    emit(RecentNotificationLoading());
    try {
      final response = await NotificationRepository.getRecentNotification(
          lpId: UserRepository.getLpID,
          userId: UserRepository.getUserID,
          user: AppNames.appName,
          offset: 0,
          limit: 10);

      if (response['data'] is String) {
        emit(NotificationEmptyState(emptyMessage: response['data']));
      } else {
        notificationsModel = NotificationsModel.fromJson(response);
        if (notificationsModel?.data != null) {
          emit(RecentNotificationSuccess(
              notificationsModel: notificationsModel!));
        }
      }
    } catch (e) {
      emit(RecentNotificationFailure(errorMessage: ""));
    }
  }

  Future<void> getAllNotification() async {
    notificationsModel = null;

    emit(GetAllNotificationLoading());
    try {
      final response = await NotificationRepository.getAllNotification(
          lpId: UserRepository.getLpID,
          userId: UserRepository.getUserID,
          user: AppNames.appName,
          offset: 0,
          limit: 10);

      if (response['data'] is String) {
        emit(NotificationEmptyState(emptyMessage: response['data']));
      } else {
        notificationsModel = NotificationsModel.fromJson(response);
        if (notificationsModel?.data != null) {
          emit(GetAllNotificationSuccess(
              notificationsModel: notificationsModel!));
        }
      }
    } catch (e) {
      emit(GetAllNotificationFailure(errorMessage: ""));
    }
  }
}
