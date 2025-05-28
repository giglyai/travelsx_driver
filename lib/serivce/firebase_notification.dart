import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:travelx_driver/home/bloc/home_cubit.dart';
import 'package:travelx_driver/main.dart';
import 'package:travelx_driver/serivce/notification_service.dart';
import 'package:travelx_driver/shared/local_storage/log_in_status.dart';
import 'package:travelx_driver/shared/local_storage/user_repository.dart';
import 'package:travelx_driver/shared/routes/named_routes.dart';
import 'package:travelx_driver/shared/routes/navigator.dart';
import 'package:travelx_driver/user/user_details/user_details_data.dart';

class FireBaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;

  final HomeCubit _homeCubit = BlocProvider.of<HomeCubit>(
    navigatorKey.currentState!.context,
  );
  final notificationService = NotificationService();

  String? fCMToken;
  Future<void> initNotification() async {
    await _firebaseMessaging.requestPermission();
    LogInStatus logInStatus = LogInStatus();
    fCMToken = await _firebaseMessaging.getToken();
    UserRepository.instance.setAccessDeviceToken(fCMToken ?? "");
    logInStatus.setDeviceTokenFireBase(deviceToken: fCMToken ?? "");
    UserRepository.instance.init();
    saveDeviceToken();
    initPushNotification();
    listenForForegroundMessages();
    print("token: $fCMToken");
  }

  Future<void> handleMessage(RemoteMessage? message) async {
    if (message == null) return;
    if (message.notification?.title == 'New Trip available for you' ||
        message.notification?.title == 'New Trip assigned to you') {
      final alertSoundUrl = message.data["alert_url"] ??= "0";
      notificationService.showNotifications(message);
      notificationService.playBrandSound(alertSoundUrl);

      String notifBody = message.notification?.body ?? "";
      List<String> parts = notifBody.split(" ");
      int rideIdIndex = parts.indexWhere((part) => part.startsWith("RideId:"));
      String? rideId = rideIdIndex != -1 ? parts[rideIdIndex + 1] : null;
      bool isActingDriverRide = false;

      if (rideId != null) {
        // await MainHomeCubit().getUpcomingOnTripRideData();
        AnywhereDoor.pushReplacementNamed(
          navigatorKey.currentState!.context,
          routeName: RouteName.homeScreen,
        );
      }
    } else if (message.notification?.title ==
        'New Acting Driver ride available for you') {
      String notifBody = message.notification?.body ?? "";
      List<String> parts = notifBody.split(" ");
      int rideIdIndex = parts.indexWhere((part) => part.startsWith("RideId:"));
      String? rideId = rideIdIndex != -1 ? parts[rideIdIndex + 1] : null;
      bool isActingDriverRide = true;
      if (rideId != null) {
        // await MainHomeCubit().getUpcomingOnTripRideData();
        AnywhereDoor.pushReplacementNamed(
          navigatorKey.currentState!.context,
          routeName: RouteName.homeScreen,
        );
      }
    } else if (message.notification?.title == "Account Verified") {
      ProfileRepository.instance.setUserProfileAccountStatus("Verified");
      ProfileRepository.instance.init();
      AnywhereDoor.pushReplacementNamed(
        navigatorKey.currentState!.context,
        routeName: RouteName.homeScreen,
      );
    }
  }

  Future<void> handleOnMessageOpen(RemoteMessage? message) async {
    if (message == null) return;
    if (message.notification?.title == 'New Trip available for you' ||
        message.notification?.title == 'New Trip assigned to you') {
      String notifBody = message.notification?.body ?? "";

      final alertSoundUrl = message.data["alert_url"] ??= "0";
      notificationService.showNotifications(message);
      notificationService.playBrandSound(alertSoundUrl);

      List<String> parts = notifBody.split(" ");
      int rideIdIndex = parts.indexWhere((part) => part.startsWith("RideId:"));
      String? rideId = rideIdIndex != -1 ? parts[rideIdIndex + 1] : null;
      bool isActingDriverRide = false;

      if (rideId != null) {
        // await MainHomeCubit().getUpcomingOnTripRideData();
        AnywhereDoor.pushReplacementNamed(
          navigatorKey.currentState!.context,
          routeName: RouteName.homeScreen,
        );
      }
    } else if (message.notification?.title ==
        'New Acting Driver ride availabe for you') {
      String notifBody = message.notification?.body ?? "";
      List<String> parts = notifBody.split(" ");
      int rideIdIndex = parts.indexWhere((part) => part.startsWith("RideId:"));
      String? rideId = rideIdIndex != -1 ? parts[rideIdIndex + 1] : null;
      bool isActingDriverRide = true;

      if (rideId != null) {
        // await MainHomeCubit().getUpcomingOnTripRideData();
        AnywhereDoor.pushReplacementNamed(
          navigatorKey.currentState!.context,
          routeName: RouteName.homeScreen,
        );
      }
    } else if (message.notification?.title == "Account Verified") {
      ProfileRepository.instance.setUserProfileAccountStatus("Verified");
      ProfileRepository.instance.init();

      final alertSoundUrl = message.data["alert_url"] ??= "0";
      notificationService.showNotifications(message);
      notificationService.playBrandSound(alertSoundUrl);

      AnywhereDoor.pushReplacementNamed(
        navigatorKey.currentState!.context,
        routeName: RouteName.homeScreen,
      );
    }
  }

  Future initPushNotification() async {
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleOnMessageOpen);
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  }

  void listenForForegroundMessages() {
    FirebaseMessaging.onMessage.listen(handleMessage);
  }

  saveDeviceToken() {
    LogInStatus userHasLoggedIn = LogInStatus();
    userHasLoggedIn.savedDeviceToken(fCMToken ?? "");
  }
}

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Handling a background message ${message.messageId}');
}
