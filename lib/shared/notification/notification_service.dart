import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:travelx_driver/user/user_details/user_details_data.dart';

class NotificationService {
  static final NotificationService _notificationService =
      NotificationService._internal();

  factory NotificationService() {
    return _notificationService;
  }

  NotificationService._internal();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  int badgeCount = 0; // Badge count for notifications
  ValueNotifier<int> badgeNotifier = ValueNotifier(
    0,
  ); // For dynamic badge updates

  /// Initialize notification service
  Future<void> init() async {
    // Request notification permissions
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission();

    print('User granted permission: ${settings.authorizationStatus}');

    // Initialize Android and iOS settings
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings();

    const InitializationSettings initializationSettings =
        InitializationSettings(
          android: initializationSettingsAndroid,
          iOS: initializationSettingsIOS,
        );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (response) {
        // Handle notification click
        print('Notification clicked with payload: ${response.payload}');
      },
    );

    // Configure Firebase messaging
    configureFirebaseMessaging();
  }

  /// Configure Firebase Messaging for notification handling
  void configureFirebaseMessaging() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Foreground message received: ${message.notification?.title}');

      // Handle specific notification types

      if (message.notification?.title == 'Account Verified') {
        ProfileRepository.instance
          ..setUserProfileAccountStatus("Verified")
          ..init();
        // AnywhereDoor.pushReplacementNamed(
        //   navigatorKey.currentState!.context,
        //   routeName: ScreenRoutes.sellerBottomNavBar,
        // );
      } else if (message.notification?.title == "You have got a new ride") {
        // AnywhereDoor.pushReplacementNamed(
        //   navigatorKey.currentState!.context,
        //   routeName: ScreenRoutes.sellerBottomNavBar,
        // );
      }
      // Update badge count
      badgeNotifier.value++;
      showNotifications(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('Notification clicked: ${message.notification?.title}');
      // Navigate or handle specific actions
      print('Foreground message received: ${message.notification?.title}');

      if (message.notification?.title == 'Account Verified') {
        ProfileRepository.instance
          ..setUserProfileAccountStatus("Verified")
          ..init();
        // AnywhereDoor.pushReplacementNamed(
        //   navigatorKey.currentState!.context,
        //   routeName: ScreenRoutes.sellerBottomNavBar,
        // );
      } else if (message.notification?.title == "You have got a new ride") {
        // AnywhereDoor.pushReplacementNamed(
        //   navigatorKey.currentState!.context,
        //   routeName: ScreenRoutes.sellerBottomNavBar,
        // );
      }
      // Handle specific notification types

      // Update badge count
      badgeNotifier.value++;
      showNotifications(message);
    });
  }

  /// Show local notification for foreground messages
  Future<void> showNotifications(RemoteMessage? message) async {
    if (message == null || message.notification == null) return;

    const AndroidNotificationDetails
    androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'travelsx_driver_channel',
      'TravelsX Driver Alerts',
      channelDescription: 'Notification channel for TravelsX Partner alerts',
      sound: RawResourceAndroidNotificationSound('travelsx_driver_ride_alert'),
      importance: Importance.max,
      priority: Priority.high,
    );

    //     AndroidNotificationDetails(
    //   'HOB Seller',
    //   'HOB Seller',
    //   channelDescription: 'HOB Seller Notifications',
    //   importance: Importance.max,
    //   priority: Priority.high,
    //   playSound: true,
    // );

    const DarwinNotificationDetails iOSPlatformChannelSpecifics =
        DarwinNotificationDetails();

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    await flutterLocalNotificationsPlugin.show(
      DateTime.now().millisecondsSinceEpoch ~/ 1000, // Unique notification ID
      message.notification!.title, // Notification title
      message.notification!.body, // Notification body
      platformChannelSpecifics,
      payload: message.data['payload'], // Optional payload
    );
  }

  /// Show in-app popup when a notification is received
  void _showInAppPopup(BuildContext context, String title, String body) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(title),
            content: Text(body),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Dismiss'),
              ),
            ],
          ),
    );
  }

  /// Reset badge count
  void resetBadgeCount() {
    badgeNotifier.value = 0;
  }
}
