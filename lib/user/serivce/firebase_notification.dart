// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:travelx_driver/home/bloc/home_cubit.dart';
//
// import '../../shared/local_storage/log_in_status.dart';
// import '../../shared/local_storage/user_repository.dart';
//
// class FireBaseApi {
//   final _firebaseMessaging = FirebaseMessaging.instance;
//
//   String? fCMToken;
//   Future<void> initNotification() async {
//     await _firebaseMessaging.requestPermission();
//     fCMToken = await _firebaseMessaging.getToken();
//     UserRepository.instance.setAccessDeviceToken(fCMToken ?? "");
//     UserRepository.instance.init();
//     saveDeviceToken();
//     initPushNotification();
//     listenForForegroundMessages();
//     print("token: $fCMToken");
//   }
//
//   Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//     print('Handling a background message ${message.messageId}');
//   }
//
//   Future<void> handleMessage(RemoteMessage? message) async {
//     if (message == null) return;
//
//     ///Send to screen
//     //await HomeCubit().fetchRides();
//   }
//
//   Future<void> handleOnMessageOpen(RemoteMessage? message) async {
//     if (message == null) return;
//
//     ///Send to screen
//     //await HomeCubit().fetchRides();
//   }
//
//   Future initPushNotification() async {
//     FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
//     FirebaseMessaging.onMessageOpenedApp.listen(handleOnMessageOpen);
//     FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
//   }
//
//   void listenForForegroundMessages() {
//     FirebaseMessaging.onMessage.listen(handleMessage);
//   }
//
//   saveDeviceToken() {
//     LogInStatus userHasLoggedIn = LogInStatus();
//     userHasLoggedIn.savedPlayerId(fCMToken ?? "");
//   }
// }
