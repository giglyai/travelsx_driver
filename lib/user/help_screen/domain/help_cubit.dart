import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:travelx_driver/main.dart';
import 'package:travelx_driver/shared/api_client/api_client.dart';
import 'package:travelx_driver/shared/api_client/api_exception.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../shared/local_storage/user_repository.dart';
import '../data/help_data.dart';
import '../model/get_user_held_data.dart';

class HelpState extends Equatable {
  final ApiStatus userHelpApiStatus;
  final GetUserHelpData getUserHelpData;

  const HelpState({
    required this.userHelpApiStatus,
    required this.getUserHelpData,
  });

  static HelpState init() => HelpState(
        userHelpApiStatus: ApiStatus.init,
        getUserHelpData: GetUserHelpData(),
      );

  HelpState copyWith({
    ApiStatus? userHelpApiStatus,
    GetUserHelpData? getUserHelpData,
  }) =>
      HelpState(
        userHelpApiStatus: userHelpApiStatus ?? this.userHelpApiStatus,
        getUserHelpData: getUserHelpData ?? this.getUserHelpData,
      );

  @override
  List<Object?> get props => [
        userHelpApiStatus,
        getUserHelpData,
      ];
}

class HelpCubit extends Cubit<HelpState> {
  HelpCubit() : super(HelpState.init()) {}

  Future<void> getHelpData() async {
    emit(
      state.copyWith(
        userHelpApiStatus: ApiStatus.loading,
      ),
    );
    try {
      final response = await HelpData.getHelpData(
        lpId: UserRepository.getLpID ?? "",
        userId: UserRepository.getUserID ?? "",
        user: 'driver-ride',
      );
      final getUserHelpData = GetUserHelpData.fromJson(response);

      emit(
        state.copyWith(
          userHelpApiStatus: ApiStatus.success,
          getUserHelpData: getUserHelpData,
        ),
      );
    } on ApiException catch (e) {
      emit(state.copyWith(userHelpApiStatus: ApiStatus.failure));
    } catch (e) {
      emit(state.copyWith(userHelpApiStatus: ApiStatus.failure));
    }
  }

  Future<void> openWhatsapp({required String phoneNumber}) async {
    var whatsapp = phoneNumber;
    var whatsappurlAndroid =
        "whatsapp://send?phone=" + whatsapp + "&text=hello";
    var whatappURL_ios = "https://wa.me/$whatsapp?text=${Uri.parse("hello")}";
    if (Platform.isIOS) {
      // for iOS phone only
      if (await canLaunchUrl(Uri.parse(whatappURL_ios))) {
        await launchUrl(Uri.parse(whatappURL_ios));
      } else {
        ScaffoldMessenger.of(navigatorKey.currentState!.context)
            .showSnackBar(SnackBar(content: new Text("whatsapp no installed")));
      }
    } else {
      // android , web
      if (await canLaunchUrl(Uri.parse(whatsappurlAndroid))) {
        await launchUrl(Uri.parse(whatsappurlAndroid));
      } else {
        ScaffoldMessenger.of(navigatorKey.currentState!.context)
            .showSnackBar(SnackBar(content: new Text("whatsapp no installed")));
      }
    }
  }
}
