import 'dart:async';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travelx_driver/home/bloc/home_cubit.dart';

Future<void> initializeBackgroundService() async {
  final service = FlutterBackgroundService();

  final prefs = await SharedPreferences.getInstance();
  final currentFlavor = prefs.getString('flavor') ?? 'travelsxdriver';

  String title =
      currentFlavor.contains('kurinjidriver')
          ? 'Kurinji Driver'
          : 'TravelsX Driver';

  await service.configure(
    androidConfiguration: AndroidConfiguration(
      onStart: onStart,
      autoStart: true,
      isForegroundMode: true,
      notificationChannelId: 'background_service_channel',
      initialNotificationTitle: title,
      initialNotificationContent: 'Tap to return to the app',
      foregroundServiceNotificationId: 888,
    ),
    iosConfiguration: IosConfiguration(
      autoStart: true,
      onForeground: onStart,
      onBackground: onIosBackground,
    ),
  );

  await service.startService();
}

@pragma('vm:entry-point')
Future<bool> onIosBackground(ServiceInstance service) async {
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();
  return true;
}

@pragma('vm:entry-point')
void onStart(ServiceInstance service) async {
  DartPluginRegistrant.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  final currentFlavor = prefs.getString('flavor') ?? 'travelsxdriver';

  String title = "";

  if (currentFlavor.contains('goguldriver')) {
    title = "Gogul Taxi Driver";
  } else if (currentFlavor.contains('uzhavandriver')) {
    title = "Uzhavan Driver";
  } else if (currentFlavor.contains('kurinjidriver')) {
    title = "Kurinji Driver";
  } else if (currentFlavor.contains('travelsxdriver')) {
    title = "TravelsX Driver";
  } else {
    title = "TravelsX Driver";
  }

  if (service is AndroidServiceInstance) {
    service.setForegroundNotificationInfo(title: title, content: "Running");

    service.on('setAsForeground').listen((event) {
      service.setAsForegroundService();
    });
    service.on('setAsBackground').listen((event) {
      service.setAsBackgroundService();
    });
  }
  service.on('stopService').listen((event) {
    service.stopSelf();
  });

  Timer.periodic(const Duration(minutes: 10), (timer) async {
    if (service is AndroidServiceInstance) {
      if (await service.isForegroundService()) {
        await HomeCubit().postUserCurrentLocation(source: "bg_service");
      } else {
        await HomeCubit().postUserCurrentLocation(source: "bg_service");
      }
    } else if (service is IOSServiceInstance) {
      print("iOS background service is running");
      await HomeCubit().postUserCurrentLocation(source: "bg_service");
    }
    service.invoke('update');
  });
}
