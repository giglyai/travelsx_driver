import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:travelx_driver/main.dart';
import 'package:travelx_driver/shared/routes/named_routes.dart';
import 'package:travelx_driver/shared/routes/navigator.dart';
import 'package:travelx_driver/user/user_details/user_details_data.dart';
import 'package:package_info_plus/package_info_plus.dart';

class NotificationService {
  final AudioPlayer _audioPlayer = AudioPlayer();

  static final NotificationService _notificationService =
      NotificationService._internal();
  factory NotificationService() => _notificationService;
  NotificationService._internal();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    const AndroidInitializationSettings androidInitSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    final InitializationSettings initSettings = InitializationSettings(
      android: androidInitSettings,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        _handleNotificationTap(response.payload);
      },
    );
  }

  Future<void> showNotifications__(RemoteMessage? message) async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
          'GiglyAI Driver',
          'GiglyAI Driver',
          channelDescription: 'GiglyAI Driver Notifications',
          importance: Importance.max,
          priority: Priority.high,
          playSound: true,
          enableVibration: true,
          //sound: RawResourceAndroidNotificationSound('alert_sound'),
        );

    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidDetails,
    );

    final title = message?.notification?.title ?? "";
    final payload = title; // use title as payload for routing

    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      message?.notification?.body,
      notificationDetails,
      payload: payload,
    );
  }

  // Future<void> showNotifications(RemoteMessage? message) async {
  //   const AndroidNotificationDetails androidDetails =
  //       AndroidNotificationDetails(
  //         'driver_alert_channel',
  //         'TravelsX Ride Alert Alerts',
  //         channelDescription:
  //             'Notification channel for TravelsX Partner alerts',
  //         sound: RawResourceAndroidNotificationSound('driver_alert_sound'),
  //         importance: Importance.max,
  //         priority: Priority.high,
  //         playSound: true,
  //         enableVibration: true,
  //       );

  //   const NotificationDetails notificationDetails = NotificationDetails(
  //     android: androidDetails,
  //   );

  //   final title = message?.notification?.title ?? "";
  //   final payload = title; // use title as payload for routing

  //   await flutterLocalNotificationsPlugin.show(
  //     0,
  //     title,
  //     message?.notification?.body,
  //     notificationDetails,
  //     payload: payload,
  //   );
  // }

  Future<void> showNotifications(RemoteMessage? message) async {
    final info = await PackageInfo.fromPlatform();
    final package = info.packageName;

    final soundFile = () {
      switch (package) {
        case 'com.travelx.driver.kurinji':
          return 'kurinji_driver_ride_alert';
        case 'com.travelx.driver.gogul':
          return 'gogul_driver_ride_alert';
        case 'com.travelx.driver.uzhavan':
          return 'uzhavan_driver_ride_alert';
        case 'com.travelx.driver.mayiltrack':
          return 'mayiltrack_driver_ride_alert';
        case 'com.travelx.driver.googul':
          return 'googul_driver_ride_alert';
        default:
          return 'driver_alert_sound';
      }
    }();

    final androidDetails = AndroidNotificationDetails(
      'driver_alert_channel',
      'TravelsX Ride Alert Alerts',
      channelDescription: 'Notification channel for TravelsX Partner alerts',
      sound: RawResourceAndroidNotificationSound(soundFile),
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
      enableVibration: true,
    );

    final notificationDetails = NotificationDetails(android: androidDetails);

    await flutterLocalNotificationsPlugin.show(
      0,
      message?.notification?.title ?? '',
      message?.notification?.body ?? '',
      notificationDetails,
      payload: message?.notification?.title ?? '',
    );
  }

  Future<void> playAlertSound(String alertUrl) async {
    await _audioPlayer.play(UrlSource(alertUrl));
  }

  void _handleNotificationTap(String? payload) {
    print("Tapped notification payload: $payload");

    if (payload == null) return;

    if (payload.contains("New Trip available for you") ||
        payload.contains("New Trip assigned to you")) {
      AnywhereDoor.pushReplacementNamed(
        navigatorKey.currentState!.context,
        routeName: RouteName.homeScreen,
      );
    } else if (payload == "Account Verified") {
      ProfileRepository.instance.setUserProfileAccountStatus("Verified");
      ProfileRepository.instance.init();
      AnywhereDoor.pushReplacementNamed(
        navigatorKey.currentState!.context,
        routeName: RouteName.homeScreen,
      );
    }
  }
}
