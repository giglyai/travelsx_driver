// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// class NotificationService {
//   // static final NotificationService _notificationService =
//   //     NotificationService._internal();
//   // factory NotificationService() {
//   //   return _notificationService;
//   // }
//   // NotificationService._internal();

//   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   late final AndroidNotificationDetails androidPlatformChannelSpecifics;
//   // Make it 'late final'
//   late final NotificationDetails
//       platformChannelSpecifics; // Make it 'late final'

//   Future<void> init() async {
//     //Initialization Settings for Android
//     final AndroidInitializationSettings initializationSettingsAndroid =
//         const AndroidInitializationSettings('@mipmap/ic_launcher');

//     //Initialization Settings for iOS
//     // final IOSInitializationSettings initializationSettingsIOS =
//     //     IOSInitializationSettings(
//     //   requestSoundPermission: false,
//     //   requestBadgePermission: false,
//     //   requestAlertPermission: false,
//     // );

//     //InitializationSettings for initializing settings for both platforms (Android & iOS)
//     final InitializationSettings initializationSettings =
//         InitializationSettings(
//       android: initializationSettingsAndroid,
//       //iOS: initializationSettingsIOS
//     );
//     await flutterLocalNotificationsPlugin.initialize(initializationSettings);
//   }

//   Future<void> showNotifications(RemoteMessage? message) async {
//     const AndroidNotificationDetails androidPlatformChannelSpecifics =
//         AndroidNotificationDetails(
//       'GiglyAI Driver',
//       // Replace with your own channel ID
//       'GiglyAI Driver', // Replace with your own channel   name
//       channelDescription: 'GiglyAI Driver',
//       importance: Importance.max,
//       priority: Priority.high,
//       playSound: true,
//       enableVibration: true,
//       silent: false,
//       sound:
//           RawResourceAndroidNotificationSound('live_chat_notification_sound'),
//     );
//     const NotificationDetails platformChannelSpecifics =
//         NotificationDetails(android: androidPlatformChannelSpecifics);
//     await flutterLocalNotificationsPlugin.show(
//       0, // Notification ID
//       message?.notification?.title,
//       message?.notification?.body,
//       platformChannelSpecifics,
//       // Use the initialized variable
//       payload: message?.notification?.body,
//     );
//   }
// }
