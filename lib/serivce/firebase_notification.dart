import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:travelx_driver/main.dart';
import 'package:travelx_driver/serivce/notification_service.dart';
import 'package:travelx_driver/shared/local_storage/log_in_status.dart';
import 'package:travelx_driver/shared/local_storage/user_repository.dart';
import 'package:travelx_driver/shared/routes/named_routes.dart';
import 'package:travelx_driver/shared/routes/navigator.dart';
import 'package:travelx_driver/user/user_details/user_details_data.dart';

class FireBaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;
  final notificationService = NotificationService();

  String? fCMToken;

  Future<void> initNotification() async {
    await _firebaseMessaging.requestPermission();

    fCMToken = await _firebaseMessaging.getToken();
    UserRepository.instance.setAccessDeviceToken(fCMToken ?? "");
    LogInStatus().setDeviceTokenFireBase(deviceToken: fCMToken ?? "");
    UserRepository.instance.init();
    saveDeviceToken();

    await notificationService.init(); // IMPORTANT!
    initPushNotification();
    listenForForegroundMessages();

    print("token: $fCMToken");
  }

  Future<void> handleMessage(RemoteMessage? message) async {
    if (message == null) return;
    notificationService.showNotifications(message); // Always show
    //notificationService.playAlertSound(message.data['alert_url'] ?? "");
    final title = message.notification?.title ?? "";
    final body = message.notification?.body ?? "";

    if (title.contains("TravelsX Driver, New ride available for you") ||
        title.contains("TravelsX Driver, New ride assigned to you")) {
      _navigateToHomeScreen();
    } else if (title == "Account Verified") {
      ProfileRepository.instance.setUserProfileAccountStatus("Verified");
      ProfileRepository.instance.init();
      _navigateToHomeScreen();
    }
  }

  Future<void> handleOnMessageOpen(RemoteMessage? message) async {
    await handleMessage(message); // Reuse same logic
  }

  Future<void> initPushNotification() async {
    final initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      await handleMessage(initialMessage);
    }

    FirebaseMessaging.onMessageOpenedApp.listen(handleOnMessageOpen);
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  }

  void listenForForegroundMessages() {
    FirebaseMessaging.onMessage.listen(handleMessage);
  }

  void saveDeviceToken() {
    LogInStatus().savedDeviceToken(fCMToken ?? "");
  }

  void _navigateToHomeScreen() {
    AnywhereDoor.pushReplacementNamed(
      navigatorKey.currentState!.context,
      routeName: RouteName.homeScreen,
    );
  }
}

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Handling background message: ${message.messageId}');
}
